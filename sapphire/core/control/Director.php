<?php
/**
 * Director is responsible for processing URLs, and providing environment information.
 * 
 * The most important part of director is {@link Director::direct()}, which is passed a URL and will execute the appropriate
 * controller.
 * 
 * Director also has a number of static methods that provide information about the environment, such as {@link Director::set_environment_type()}.
 *
 * @package sapphire
 * @subpackage control
 * @see Director::direct(),Director::addRules(),Director::set_environment_type()
 */
class Director {
	
	static private $urlParams;

	static private $rules = array();
	
	/**
	 * @var SiteTree
	 */
	private static $current_page;
	
	/**
	 * @deprecated 2.4
	 */
	static $siteMode;
	
	static $alternateBaseFolder;

	static $alternateBaseURL;
	
	static $dev_servers = array();
	
	static $test_servers = array();
	
	static protected $environment_type;

	/** 
	 * @deprecated 2.4
 	 */ 
	static protected $callbacks;

	function __construct() {
		if(isset($_GET['debug_profile'])) Profiler::mark("Director", "construct");
		Session::addToArray('history', substr($_SERVER['REQUEST_URI'], strlen(Director::baseURL())));
		if(isset($_GET['debug_profile'])) Profiler::unmark("Director", "construct");
	}

	/**
	 * Return a URL from this user's navigation history.
	 * @param pagesBack The number of pages back to go.  The default, 1, returns the previous
	 * page.
	 */
	static function history($pagesBack = 1) {
		return Session::get('history.' . intval(sizeof(Session::get('history')) - $pagesBack - 1));
	}


	/**
	 * Add URL matching rules to the Director.
	 * 
	 * The director is responsible for turning URLs into Controller objects.
	 * 
	 * @param $priority The priority of the rules; higher values will get your rule checked first.  
	 * We recommend priority 100 for your site's rules.  The built-in rules are priority 10, standard modules are priority 50.
	 */
	static function addRules($priority, $rules) {
		Director::$rules[$priority] = isset(Director::$rules[$priority]) ? array_merge($rules, (array)Director::$rules[$priority]) : $rules;
	}

	/**
	 * Process the given URL, creating the appropriate controller and executing it.
	 * 
	 * Request processing is handled as follows:
	 *  - Director::direct() creates a new SS_HTTPResponse object and passes this to Director::handleRequest().
	 *  - Director::handleRequest($request) checks each of the Director rules and identifies a controller to handle this 
	 *    request.
	 *  - Controller::handleRequest($request) is then called.  This will find a rule to handle the URL, and call the rule
	 *    handling method.
	 *  - RequestHandler::handleRequest($request) is recursively called whenever a rule handling method returns a
	 *    RequestHandler object.
	 *
	 * In addition to request processing, Director will manage the session, and perform the output of the actual response
	 * to the browser.
	 * 
	 * @param $url String, the URL the user is visiting, without the querystring.
	 * @uses handleRequest() rule-lookup logic is handled by this.
	 * @uses Controller::run() Controller::run() handles the page logic for a Director::direct() call.
	 */
	static function direct($url) {
		// Validate $_FILES array before merging it with $_POST
		foreach($_FILES as $k => $v) {
			if(is_array($v['tmp_name'])) {
				$v = ArrayLib::array_values_recursive($v['tmp_name']);
				foreach($v as $tmpFile) {
					if($tmpFile && !is_uploaded_file($tmpFile)) {
						user_error("File upload '$k' doesn't appear to be a valid upload", E_USER_ERROR);
					}
				}
			} else {
				if($v['tmp_name'] && !is_uploaded_file($v['tmp_name'])) {
					user_error("File upload '$k' doesn't appear to be a valid upload", E_USER_ERROR);
				}
			}
		}
		
		$req = new SS_HTTPRequest(
			(isset($_SERVER['X-HTTP-Method-Override'])) ? $_SERVER['X-HTTP-Method-Override'] : $_SERVER['REQUEST_METHOD'],
			$url, 
			$_GET, 
			array_merge((array)$_POST, (array)$_FILES),
			@file_get_contents('php://input')
		);
		
		// @todo find better way to extract HTTP headers
		if(isset($_SERVER['HTTP_ACCEPT'])) $req->addHeader("Accept", $_SERVER['HTTP_ACCEPT']);
		if(isset($_SERVER['CONTENT_TYPE'])) $req->addHeader("Content-Type", $_SERVER['CONTENT_TYPE']);
		if(isset($_SERVER['HTTP_REFERER'])) $req->addHeader("Referer", $_SERVER['HTTP_REFERER']);

		// Load the session into the controller
		$session = new Session(isset($_SESSION) ? $_SESSION : null);
		
		$result = Director::handleRequest($req, $session);
		$session->inst_save();

		// Return code for a redirection request
		if(is_string($result) && substr($result,0,9) == 'redirect:') {
			$response = new SS_HTTPResponse();
			$response->redirect(substr($result, 9));
			$response->output();

		// Handle a controller
		} else if($result) {
			if($result instanceof SS_HTTPResponse) {
				$response = $result;
				
			} else {
				$response = new SS_HTTPResponse();
				$response->setBody($result);
			}
			
			// ?debug_memory=1 will output the number of bytes of memory used for this request
			if(isset($_REQUEST['debug_memory']) && $_REQUEST['debug_memory']) {
				Debug::message(sprintf(
					"Peak memory usage in bytes: %s", 
					number_format(memory_get_peak_usage(),0)
				));
			} else {
				$response->output();
			}

			//$controllerObj->getSession()->inst_save();
		}
	}
	
	/**
	 * Test a URL request, returning a response object.
	 * 
	 * This method is the counterpart of Director::direct() that is used in functional testing.  It will execute the URL given,
	 * 
	 * @param string $url The URL to visit
	 * @param array $postVars The $_POST & $_FILES variables
	 * @param Session $session The {@link Session} object representing the current session.  By passing the same object to multiple
	 * calls of Director::test(), you can simulate a persisted session.
	 * @param string $httpMethod The HTTP method, such as GET or POST.  It will default to POST if postVars is set, GET otherwise.
	 *  Overwritten by $postVars['_method'] if present.
	 * @param string $body The HTTP body
	 * @param array $headers HTTP headers with key-value pairs
	 * @param array $cookies to populate $_COOKIE
	 * @return SS_HTTPResponse
	 * 
	 * @uses getControllerForURL() The rule-lookup logic is handled by this.
	 * @uses Controller::run() Controller::run() handles the page logic for a Director::direct() call.
	 */
	static function test($url, $postVars = null, $session = null, $httpMethod = null, $body = null, $headers = null, $cookies = null) {
		// These are needed so that calling Director::test() doesnt muck with whoever is calling it.
		// Really, it's some inappropriate coupling and should be resolved by making less use of statics
		$oldStage = Versioned::current_stage();
		$getVars = array();
		
		if(!$httpMethod) $httpMethod = ($postVars || is_array($postVars)) ? "POST" : "GET";
		
		if(!$session) $session = new Session(null);

		// Back up the current values of the superglobals
		$existingRequestVars = isset($_REQUEST) ? $_REQUEST : array();
		$existingGetVars = isset($_GET) ? $_GET : array(); 
		$existingPostVars = isset($_POST) ? $_POST : array();
		$existingSessionVars = isset($_SESSION) ? $_SESSION : array();
		$existingCookies = isset($_COOKIE) ? $_COOKIE : array();
		$existingServer	= isset($_SERVER) ? $_SERVER : array();
		
		$existingCookieReportErrors = Cookie::report_errors();
		$existingRequirementsBackend = Requirements::backend();

		Cookie::set_report_errors(false);
		Requirements::set_backend(new Requirements_Backend());

		// Handle absolute URLs
		if (@parse_url($url, PHP_URL_HOST) != '') {
			$bits = parse_url($url);
			$_SERVER['HTTP_HOST'] = $bits['host'];
			$url = Director::makeRelative($url);
		}

		$urlWithQuerystring = $url;
		if(strpos($url, '?') !== false) {
			list($url, $getVarsEncoded) = explode('?', $url, 2);
			parse_str($getVarsEncoded, $getVars);
		}
		
		// Replace the superglobals with appropriate test values
		$_REQUEST = array_merge((array)$getVars, (array)$postVars); 
		$_GET = (array)$getVars; 
		$_POST = (array)$postVars; 
		$_SESSION = $session ? $session->inst_getAll() : array();
		$_COOKIE = (array) $cookies;
		$_SERVER['REQUEST_URI'] = Director::baseURL() . $urlWithQuerystring;

		$req = new SS_HTTPRequest($httpMethod, $url, $getVars, $postVars, $body);
		if($headers) foreach($headers as $k => $v) $req->addHeader($k, $v);
		$result = Director::handleRequest($req, $session);
		
		// Restore the superglobals
		$_REQUEST = $existingRequestVars; 
		$_GET = $existingGetVars; 
		$_POST = $existingPostVars; 
		$_SESSION = $existingSessionVars;   
		$_COOKIE = $existingCookies;
		$_SERVER = $existingServer;

		Cookie::set_report_errors($existingCookieReportErrors); 
		Requirements::set_backend($existingRequirementsBackend);

		// These are needed so that calling Director::test() doesnt muck with whoever is calling it.
		// Really, it's some inappropriate coupling and should be resolved by making less use of statics
		Versioned::reading_stage($oldStage);
		
		return $result;
	}
		
	/**
	 * Handle an HTTP request, defined with a SS_HTTPRequest object.
	 *
	 * @return SS_HTTPResponse|string
	 */
	protected static function handleRequest(SS_HTTPRequest $request, Session $session) {
		krsort(Director::$rules);

		if(isset($_REQUEST['debug'])) Debug::show(Director::$rules);
		foreach(Director::$rules as $priority => $rules) {
			foreach($rules as $pattern => $controllerOptions) {
				if(is_string($controllerOptions)) {
					if(substr($controllerOptions,0,2) == '->') $controllerOptions = array('Redirect' => substr($controllerOptions,2));
					else $controllerOptions = array('Controller' => $controllerOptions);
				}
				
				if(($arguments = $request->match($pattern, true)) !== false) {
					// controllerOptions provide some default arguments
					$arguments = array_merge($controllerOptions, $arguments);
					
					// Find the controller name
					if(isset($arguments['Controller'])) $controller = $arguments['Controller'];
					
					// Pop additional tokens from the tokeniser if necessary
					if(isset($controllerOptions['_PopTokeniser'])) {
						$request->shift($controllerOptions['_PopTokeniser']);
					}

					// Handle redirections
					if(isset($arguments['Redirect'])) {
						return "redirect:" . Director::absoluteURL($arguments['Redirect'], true);

					} else {
						Director::$urlParams = $arguments;
						$controllerObj = new $controller();
						$controllerObj->setSession($session);

						try {
							$result = $controllerObj->handleRequest($request);
						} catch(SS_HTTPResponse_Exception $responseException) {
							$result = $responseException->getResponse();
						}
						if(!is_object($result) || $result instanceof SS_HTTPResponse) return $result;
						
						user_error("Bad result from url " . $request->getURL() . " handled by " . 
							get_class($controllerObj)." controller: ".get_class($result), E_USER_WARNING);
						
					}
				}
			}
		}
	}
	
	/**
	 * Returns the urlParam with the given name
	 * 
	 * @deprecated 3.0 Use SS_HTTPRequest->latestParam()
	 */
	static function urlParam($name) {
		if(isset(Director::$urlParams[$name])) return Director::$urlParams[$name];
	}
	
	/**
	 * Returns an array of urlParams.
	 * 
	 * @deprecated 3.0 Use SS_HTTPRequest->latestParams()
	 */
	static function urlParams() {
		return Director::$urlParams;
	}

	/**
	 * Set url parameters (should only be called internally by RequestHandler->handleRequest()).
	 * 
	 * @param $params array
	 */
	static function setUrlParams($params) {
		Director::$urlParams = $params;
	}
	
	/**
	 * Return the {@link SiteTree} object that is currently being viewed. If there is no SiteTree object to return,
	 * then this will return the current controller.
	 *
	 * @return SiteTree
	 */
	public static function get_current_page() {
		return self::$current_page ? self::$current_page : Controller::curr();
	}
	
	/**
	 * Set the currently active {@link SiteTree} object that is being used to respond to the request.
	 *
	 * @param SiteTree $page
	 */
	public static function set_current_page($page) {
		self::$current_page = $page;
	}
	
	/**
	 * @deprecated 2.4 Use {@link Director::get_current_page()}.
	 */
	static function currentPage() {
		return self::get_current_page();
	}

	/**
	 * Turns the given URL into an absolute URL.
	 * @todo Document how relativeToSiteBase works
	 */
	static function absoluteURL($url, $relativeToSiteBase = false) {
		if(strpos($url,'/') === false && !$relativeToSiteBase) $url = dirname($_SERVER['REQUEST_URI'] . 'x') . '/' . $url;

	 	if(substr($url,0,4) != "http") {
	 		if($url[0] != "/") $url = Director::baseURL()  . $url;
			// Sometimes baseURL() can return a full URL instead of just a path
			if(substr($url,0,4) != "http") $url = self::protocolAndHost() . $url;
		}

		return $url;
	}

	/**
	 * Returns the part of the URL, 'http://www.mysite.com'.
	 * 
	 * @return boolean|string The domain from the PHP environment. Returns FALSE is this environment variable isn't set.
	 */
	static function protocolAndHost() {
		if(self::$alternateBaseURL) {
			if(preg_match('/^(http[^:]*:\/\/[^\/]+)(\/|$)/', self::$alternateBaseURL, $matches)) {
				return $matches[1];
			}
		}

		if(isset($_SERVER['HTTP_HOST'])) {
			return Director::protocol() . $_SERVER['HTTP_HOST'];
		} else {
			global $_FILE_TO_URL_MAPPING;
			if(Director::is_cli() && isset($_FILE_TO_URL_MAPPING)) $errorSuggestion = '  You probably want to define '.
				'an entry in $_FILE_TO_URL_MAPPING that covers "' . Director::baseFolder() . '"';
			else if(Director::is_cli()) $errorSuggestion = '  You probably want to define $_FILE_TO_URL_MAPPING in '.
				'your _ss_environment.php as instructed on the "sake" page of the doc.silverstripe.com wiki';
			else $errorSuggestion = "";
			
			user_error("Director::protocolAndHost() lacks sufficient information - HTTP_HOST not set.$errorSuggestion", E_USER_WARNING);
			return false;
			
		}
	}

	/**
	 * Return the current protocol that the site is running under 
	 *
	 * @return String
	 */
	static function protocol() {
		if(isset($_SERVER['HTTP_X_FORWARDED_PROTOCOL']) && strtolower($_SERVER['HTTP_X_FORWARDED_PROTOCOL']) == 'https') return "https://";
		return (isset($_SERVER['SSL']) || (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off')) ? 'https://' : 'http://';
	}

	/**
	 * Redirect to another page.
	 *  - $url can be an absolute URL
	 *  - or it can be a URL relative to the "site base"
	 *  - if it is just a word without an slashes, then it redirects to another action on the current controller.
	 */
	static function redirect($url, $code=302) {
		Controller::curr()->redirect($url, $code);
	}

	/**
	 * Tests whether a redirection has been requested.
	 * @return string If redirect() has been called, it will return the URL redirected to.  Otherwise, it will return null;
	 */
	static function redirected_to() {
		return Controller::curr()->redirectedTo();
	}
	
	/**
	 * Sets the HTTP status code
	 */
	static function set_status_code($code) {
		return Controller::curr()->getResponse()->setStatusCode($code);
	}
	
	/**
	 * Returns the current HTTP status code
	 */
	static function get_status_code() {
		return Controller::curr()->getResponse()->getStatusCode();
	}

	/**
	 * @deprecated 2.5 Use Controller->redirectBack()
	 */
	static function redirectBack() {
		Controller::curr()->redirectBack();
	}

	/**
	 * Returns the root URL for the site.
	 * It will be automatically calculated unless it is overridden with {@link setBaseURL()}.
	 */
	static function baseURL() {
		if(self::$alternateBaseURL) return self::$alternateBaseURL;
		else {
			$base = BASE_URL;
			if($base == '/' || $base == '/.' || $base == '\\') $baseURL = '/';
			else $baseURL = $base . '/';
			
			if(defined('BASE_SCRIPT_URL')) return $baseURL . BASE_SCRIPT_URL;
			else return $baseURL;
		}
	}
	
	/**
	 * Sets the root URL for the website.
	 * If the site isn't accessible from the URL you provide, weird things will happen.
	 */
	static function setBaseURL($baseURL) {
		self::$alternateBaseURL = $baseURL;
	}

	/**
	 * Returns the root filesystem folder for the site.
	 * It will be automatically calculated unless it is overridden with {@link setBaseFolder()}.
	 */
	static function baseFolder() {
		if(self::$alternateBaseFolder) return self::$alternateBaseFolder;
		else return BASE_PATH;
	}

	/**
	 * Sets the root folder for the website.
	 * If the site isn't accessible from the folder you provide, weird things will happen.
	 */
	static function setBaseFolder($baseFolder) {
		self::$alternateBaseFolder = $baseFolder;
	}

	/**
	 * Turns an absolute URL or folder into one that's relative to the root of the site.
	 * This is useful when turning a URL into a filesystem reference, or vice versa.
	 * 
	 * @todo Implement checking across http/https protocols
	 * 
	 * @param string $url Accepts both a URL or a filesystem path
	 * @return string Either a relative URL if the checks succeeded, or the original (possibly absolute) URL.
	 */
	static function makeRelative($url) {
		// Allow for the accidental inclusion of a // in the URL
		$url = ereg_replace('([^:])//','\\1/',$url);
		$url = trim($url);

		// Only bother comparing the URL to the absolute version if $url looks like a URL.
		if(preg_match('/^https?[^:]*:\/\//',$url)) {
			$base1 = self::absoluteBaseURL();
			// If we are already looking at baseURL, return '' (substr will return false)
			if($url == $base1) return '';
			else if(substr($url,0,strlen($base1)) == $base1) return substr($url,strlen($base1));
			// Convert http://www.mydomain.com/mysitedir to ''
			else if(substr($base1,-1)=="/" && $url == substr($base1,0,-1)) return "";
		}
		
		// test for base folder, e.g. /var/www
		$base2 = self::baseFolder();
		if(substr($url,0,strlen($base2)) == $base2) return substr($url,strlen($base2));

		// Test for relative base url, e.g. mywebsite/ if the full URL is http://localhost/mywebsite/
		$base3 = self::baseURL();
		if(substr($url,0,strlen($base3)) == $base3) return substr($url,strlen($base3));
		
		// Nothing matched, fall back to returning the original URL
		return $url;
	}
	
	/**
	 * Returns true if a given path is absolute. Works under both *nix and windows
	 * systems
	 *
	 * @param string $path
	 * @return bool
	 */
	public static function is_absolute($path) {
		if($path[0] == '/' || $path[0] == '\\') return true;
		return preg_match('/^[a-zA-Z]:[\\\\\/]/', $path) == 1;
	}
	
	/**
	 * Checks if a given URL is absolute (e.g. starts with 'http://' etc.).
	 * 
	 * @param string $url
	 * @return boolean
	 */
	public static function is_absolute_url($url) {
		$url = trim($url);
		// remove all query strings to avoid parse_url choking on URLs like 'test.com?url=http://test.com'
		$url = preg_replace('/(.*)\?.*/', '$1', $url);
		$parsed = parse_url($url);
		return (isset($parsed['scheme']));
	}
	
	/**
	 * Checks if a given URL is relative by checking
	 * {@link is_absolute_url()}.
	 * 
	 * @param string $url
	 * @return boolean
	 */
	public static function is_relative_url($url) {
		return (!Director::is_absolute_url($url));
	}
	
	/**
	 * Checks if the given URL is belonging to this "site",
	 * as defined by {@link makeRelative()} and {@link absoluteBaseUrl()}.
	 * Useful to check before redirecting based on a URL from user submissions
	 * through $_GET or $_POST, and avoid phishing attacks by redirecting
	 * to an attackers server.
	 * 
	 * @param string $url
	 * @return boolean
	 */
	public static function is_site_url($url) {
		$relativeUrl = Director::makeRelative($url);
		return (bool)self::is_relative_url($relativeUrl);
	}
	
	/**
	 * Given a filesystem reference relative to the site root, return the full file-system path.
	 * 
	 * @param string $file
	 * @return string
	 */
	public static function getAbsFile($file) {
		return self::is_absolute($file) ? $file : Director::baseFolder() . '/' . $file;
	}
	
	/**
	 * Returns true if the given file exists.
	 * @param $file Filename specified relative to the site root
	 */
	static function fileExists($file) {
		// replace any appended query-strings, e.g. /path/to/foo.php?bar=1 to /path/to/foo.php
		$file = preg_replace('/([^\?]*)?.*/','$1',$file);
		return file_exists(Director::getAbsFile($file));
	}

	/**
	 * Returns the Absolute URL of the site root.
	 */
	 static function absoluteBaseURL() {
	 	return Director::absoluteURL(Director::baseURL());
	 }
	 
	/**
	 * Returns the Absolute URL of the site root, embedding the current basic-auth credentials into the URL.
	 */
	 static function absoluteBaseURLWithAuth() {
		$s = "";
		$login = "";
		
	 	if(isset($_SERVER['PHP_AUTH_USER'])) $login = "$_SERVER[PHP_AUTH_USER]:$_SERVER[PHP_AUTH_PW]@";

	 	return Director::protocol() . $login .  $_SERVER['HTTP_HOST'] . Director::baseURL();
	 }

	/**
	 * Force the site to run on SSL.
	 * 
	 * To use, call from _config.php. For example:
	 * <code>
	 * if(Director::isLive()) Director::forceSSL();
	 * </code>
	 * 
	 * If you don't want your entire site to be on SSL, you can pass an array of PCRE regular expression
	 * patterns for matching relative URLs. For example:
	 * <code>
	 * if(Director::isLive()) Director::forceSSL(array('/^admin/', '/^Security/'));
	 * </code>
	 * 
	 * Note that the session data will be lost when moving from HTTP to HTTPS.
	 * It is your responsibility to ensure that this won't cause usability problems.
	 * 
	 * CAUTION: This does not respect the site environment mode. You should check this
	 * as per the above examples using Director::isLive() or Director::isTest() for example.
	 * 
	 * @return boolean|string String of URL when unit tests running, boolean FALSE if patterns don't match request URI
	 */
	static function forceSSL($patterns = null) {
		$matched = false;

		if($patterns) {
			// protect portions of the site based on the pattern
			$relativeURL = self::makeRelative(Director::absoluteURL($_SERVER['REQUEST_URI']));
			foreach($patterns as $pattern) {
				if(preg_match($pattern, $relativeURL)) {
					$matched = true;
					break;
				}
			}
		} else {
			// protect the entire site
			$matched = true;
		}

		if($matched && (!isset($_SERVER['HTTPS']) || $_SERVER['HTTPS'] == 'off') && !(isset($_SERVER['HTTP_X_FORWARDED_PROTOCOL']) && strtolower($_SERVER['HTTP_X_FORWARDED_PROTOCOL']) == 'https')) {
			$destURL = str_replace('http:', 'https:', Director::absoluteURL($_SERVER['REQUEST_URI']));

			// This coupling to SapphireTest is necessary to test the destination URL and to not interfere with tests
			if(class_exists('SapphireTest', false) && SapphireTest::is_running_test()) {
				return $destURL;
			} else {
				if(!headers_sent()) header("Location: $destURL");
				die("<h1>Your browser is not accepting header redirects</h1><p>Please <a href=\"$destURL\">click here</a>");
			}
		} else {
			return false;
		}
	}

	/**
	 * Force a redirect to a domain starting with "www."
	 */
	static function forceWWW() {
		if(!Director::isDev() && !Director::isTest() && strpos($_SERVER['HTTP_HOST'], 'www') !== 0) {
			$destURL = str_replace(Director::protocol(), Director::protocol() . 'www.', Director::absoluteURL($_SERVER['REQUEST_URI']));

			header("Location: $destURL", true, 301);
			die("<h1>Your browser is not accepting header redirects</h1><p>Please <a href=\"$destURL\">click here</a>");
		}
	}

	/**
	 * Checks if the current HTTP-Request is an "Ajax-Request"
	 * by checking for a custom header set by prototype.js or
	 * wether a manually set request-parameter 'ajax' is present.
	 *
	 * @return boolean
	 */
	static function is_ajax() {
		if(Controller::has_curr()) {
			return Controller::curr()->isAjax();
		} else {
			return (
				isset($_REQUEST['ajax']) ||
				(isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == "XMLHttpRequest")
			);
		}
	}
	
	/**
	 * Returns true if this script is being run from the command line rather than the webserver.
	 * 
	 * @return boolean
	 */
	public static function is_cli() {
		return (php_sapi_name() == "cli");
	}

	////////////////////////////////////////////////////////////////////////////////////////////
	// Site mode methods
	////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * @deprecated 2.4
	 */
	static function set_site_mode($mode) {
		user_error (
			'Director::set_site_mode() is deprecated as the functionality is no longer neccesary.', E_USER_NOTICE
		);
		
		Director::$siteMode = $mode;
		
		if(isset(self::$callbacks[$mode])) {
			foreach(self::$callbacks[$mode] as $extension) {
				call_user_func($extension);
			}
		}
	}
	
	/**
	 * @deprecated 2.4
	 */
	static function get_site_mode() {
		user_error (
			'Director::set_site_mode() is deprecated as the functionality is no longer neccesary.', E_USER_NOTICE
		);
		
		return Director::$siteMode;
	}

	/**
	 * @deprecated 2.4 Use a custom extension on your controller.
	 */
	static function add_callback($function, $mode = 'site') {
		user_error (
			'Director::add_callback() is deprecated, please use a custom extension on your controller', E_USER_NOTICE
		);
		
		self::$callbacks[$mode][] = $function;
	}

	////////////////////////////////////////////////////////////////////////////////////////////
	// Environment type methods
	////////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * Set the environment type of the current site.
	 *
	 * Typically, a SilverStripe site have a number of environments: 
	 *  - development environments, such a copy on your local machine.
	 *  - test sites, such as the one you show the client before going live.
	 *  - the live site itself.
	 * 
	 * The behaviour of these environments often varies slightly.  For example, development sites may have errors dumped to the screen,
	 * and order confirmation emails might be sent to the developer instead of the client.
	 * 
	 * To help with this, Sapphire support the notion of an environment type.  The environment type can be dev, test, or live.
	 * 
	 * You can set it explicitly with Director::set_environment_tpye().  Or you can use {@link Director::set_dev_servers()} and {@link Director::set_test_servers()}
	 * to set it implicitly, based on the value of $_SERVER['HTTP_HOST'].  If the HTTP_HOST value is one of the servers listed, then
	 * the environment type will be test or dev.  Otherwise, the environment type will be live.
	 *
	 * Dev mode can also be forced by putting ?isDev=1 in your URL, which will ask you to log in and then push the site into dev
	 * mode for the remainder of the session. Putting ?isDev=0 onto the URL can turn it back.
	 * 
	 * Test mode can also be forced by putting ?isTest=1 in your URL, which will ask you to log in and then push the site into test
	 * mode for the remainder of the session. Putting ?isTest=0 onto the URL can turn it back.
	 * 
	 * Generally speaking, these methods will be called from your _config.php file.
	 * 
	 * Once the environment type is set, it can be checked with {@link Director::isDev()}, {@link Director::isTest()}, and
	 * {@link Director::isLive()}.
	 * 
	 * @param $et string The environment type: dev, test, or live.
	 */
	static function set_environment_type($et) {
		if($et != 'dev' && $et != 'test' && $et != 'live') {
			SS_Backtrace::backtrace();
			user_error("Director::set_environment_type passed '$et'.  It should be passed dev, test, or live", E_USER_WARNING);
		} else {
			self::$environment_type = $et;
		}
	}
	
	/**
	 * Can also be checked with {@link Director::isDev()}, {@link Director::isTest()}, and {@link Director::isLive()}.
	 * 
	 * @return string 'dev', 'test' or 'live'
	 */
	static function get_environment_type() {
		if(Director::isLive()) {
			return 'live';
		} elseif(Director::isTest()) {
			return 'test';
		} elseif(Director::isDev()) {
			return 'dev';
		} else {
			return false;
		}
	}

	/**
	 * Specify HTTP_HOST values that are development environments.
	 * For information about environment types, see {@link Director::set_environment_type()}.
	 * 
	 * CAUTION: Domain information can easily be spoofed in HTTP requests,
	 * we recommend to set this mode via {@link Director::set_environment_type()}
	 * or an _ss_environment.php instead.
	 * 
	 * @param $servers array An array of HTTP_HOST values that should be treated as development environments.
	 */
	static function set_dev_servers($servers) {
		Director::$dev_servers = $servers;
	}
	
	/**
	 * Specify HTTP_HOST values that are test environments.
	 * For information about environment types, see {@link Director::set_environment_type()}.
	 * 
	 * CAUTION: Domain information can easily be spoofed in HTTP requests,
	 * we recommend to set this mode via {@link Director::set_environment_type()}
	 * or an _ss_environment.php instead.
	 * 
	 * @param $servers array An array of HTTP_HOST values that should be treated as test environments.
	 */
	static function set_test_servers($servers) {
		Director::$test_servers = $servers;
	}

	/*
	 * This function will return true if the site is in a live environment.
	 * For information about environment types, see {@link Director::set_environment_type()}.
	 */
	static function isLive() {
		return !(Director::isDev() || Director::isTest());
	}
	
	/**
	 * This function will return true if the site is in a development environment.
	 * For information about environment types, see {@link Director::set_environment_type()}.
	 */
	static function isDev() {
		// This variable is used to supress repetitions of the isDev security message below.
		static $firstTimeCheckingGetVar = true;
		
		// Use ?isDev=1 to get development access on the live server
		if(isset($_GET['isDev'])) {
			if(Security::database_is_ready()) {
				if($firstTimeCheckingGetVar && !Permission::check('ADMIN')){
					BasicAuth::requireLogin("SilverStripe developer access. Use your CMS login", "ADMIN");
				}
				$_SESSION['isDev'] = $_GET['isDev'];
				if($firstTimeCheckingGetVar) $firstTimeCheckingGetVar = false;
			} else {
				if($firstTimeCheckingGetVar && DB::connection_attempted()) {
	 				echo "<p style=\"padding: 3px; margin: 3px; background-color: orange; 
						color: white; font-weight: bold\">Sorry, you can't use ?isDev=1 until your
						Member and Group tables database are available.  Perhaps your database
						connection is failing?</p>";
					$firstTimeCheckingGetVar = false;
				}
			}
		}

		if(isset($_SESSION['isDev']) && $_SESSION['isDev']) return true;

		if(self::$environment_type) return self::$environment_type == 'dev';
		
		// Check if we are running on one of the development servers
		if(isset($_SERVER['HTTP_HOST']) && in_array($_SERVER['HTTP_HOST'], Director::$dev_servers))  {
			return true;
		}
		
		return false;
	}
	
	/**
	 * This function will return true if the site is in a test environment.
	 * For information about environment types, see {@link Director::set_environment_type()}.
	 */
	static function isTest() {
		// Use ?isTest=1 to get test access on the live server, or explicitly set your environment
		if(isset($_GET['isTest'])) {
			if(Security::database_is_ready()) {
				BasicAuth::requireLogin("SilverStripe developer access. Use your CMS login", "ADMIN");
				$_SESSION['isTest'] = $_GET['isTest'];
			} else {
				return true;
			}
		}
		if(self::isDev()) return false;
		
		if(self::$environment_type) {
			return self::$environment_type == 'test';
		}
		
		// Check if we are running on one of the test servers
		if(isset($_SERVER['HTTP_HOST']) && in_array($_SERVER['HTTP_HOST'], Director::$test_servers))  {
			return true;
		}
		
		return false;
	}

}