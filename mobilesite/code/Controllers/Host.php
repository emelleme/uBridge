<?php
 /* Maps Controller */
class Host_Controller extends ContentController {
	 //Google Verify Assertion API
    private static $SERVER_URL =
    "https://www.googleapis.com/identitytoolkit/v1/relyingparty/verifyAssertion?key=AIzaSyBLq4-L6c1EhVh-QmMyRFzqwph8vx-TasY";
    
    public function init(){
    	parent::init();
    	SSViewer::set_theme('braindark');
		$params = $this->getURLParams();
		
		//Check 
		
    }
    
    public function eventStart($arguments){
    	/* Create New Event and direct to event edit page */
    	$eventinfo = $arguments->requestVars();
    	if(!@$eventinfo["name"]){
    	var_dump(@$eventinfo["name"]);
    	Director::redirect('host/home');
    	}else{
    		//Create the New Event
    		$event  = new Event();
    		$event->Title = @$eventinfo["name"];
    		$event->Category = "Conference";
    		$event->Summary = @$eventinfo["summary"];
    		$mem = Member::currentUser();
    		$event->OwnerID = $mem->ID;
    		$eventid = $event->write();
    		Director::redirect('/event/edit/'.$eventid);
    	}
    	
    }
    
    public function index($arguments){
    	//Check to see if User is Logged in
    	if($member = Member::currentUser()){
			return Director::redirect('/host/home');
		}else{
    		return $this->renderWith('LoginPage','HostPage');
    	}
    }
    
    public function home($arguments){
    	if($member = Member::currentUser()){
    	return $this->renderWith(array('ConstructionPage','HostPage'));
    	}else{
    		return $this->renderWith('LoginPage','HostPage');
    	}
    }
    
    public function dashboard($arguments){
    	return $this->renderWith('HostPage');
    }
    
    public function profile($arguments){
    	return $this->renderWith(array('ProfilePage','HostPage'));
    }
    
    public function callback($arguments){
    	$url = $this->getCurrentUrl();
		$postData = @file_get_contents('php://input');
		
		//Run the Verify Assertion API 
  		$result = $this->verifyReq($url, $postData);
  		if($result == NULL){
  		return $this->renderWith('FederatedLoginFail');
  		exit;
  		}else{
  		$userinfo = json_decode($result,true);
  		$verifiedEmail ='';
  		if(!$verifiedEmail = @$userinfo["verifiedEmail"]){
  			$verifiedEmail = @$userinfo["email"];
  		};
  		//Parse User info, check to see if registered, and return to proper page.
  		$member = DataObject::get_one('Member',"Email = '".$verifiedEmail."'");
  		if(!$member){
			//New Member!
			//Generate Pin for phone call
		   	$pin = $this->generatepin();
		   	Session::set('Pin', $pin);
		   	//Create Member
			$dmember = new Member();
			if (@$userinfo["firstName"] != NULL){
			$dmember->FirstName = @$userinfo["firstName"];
			}else{
			$dmember->FirstName = @$userinfo["displayName"];
			}
			$dmember->nickName = str_replace(" ", "", @$userinfo["nickName"]);
			$dmember->displayName = @$userinfo["displayName"];
			$dmember->Email = $verifiedEmail;
			if (@$userinfo["photoUrl"] != NULL){
			$dmember->photoUrl = @$userinfo["photoUrl"];
			}else{
			$dmember->photoUrl = 'http://ubridge.mobi/themes/braindark/images/avatar.png';
			}
			$dmember->identifier = @$userinfo["identifier"];
			$dmember->language = @$userinfo["language"];
			$dmember->pin = $pin;
			$dmember->addToGroupByCode('event-host','Event Hosts');
			$memberid = $dmember->write();
			
			$dmember->ID = $memberid;
			
			//Add User to Event Host Group
			$dmember->addToGroupByCode('event-host','Event Hosts');
			$dmember->logIn(TRUE);
			//var_dump($dmember);
			//exit;
			//Director::redirect('home');
			return $this->renderWith('FederatedLoginSuccess');
		}else{
			//Member exists. log them in.
			$member->logIn(TRUE);
			return $this->renderWith('FederatedLoginSuccess');
		}
		}
  		//var_dump($mem);
  		//exit;
    }
    public function userStatus($arguments) {
    	//Check to see if a user is already registered
    	$this->response->removeHeader("Content-Type"); 
    	$this->response->addHeader("Content-Type", "text/plain; charset=UTF-8"); 
        $this->response->addHeader("Expires", "Mon, 26 Jul 1997 05:00:00 GMT");
        $this->response->addHeader("Cache-Control", "no-cache, must-revalidate");
        echo '{"registered":true}';
        //return $this->renderWith(array('MapsPage','StationMap'));
    }
    
    public function login($arguments) {
        //return $this->renderWith(array('MapsPage','StationMap'));
    }
    
    public function signup($arguments) {
        //return $this->renderWith(array('MapsPage','StationMap'));
    }
    
    public function logout($arguments) {
        //return $this->renderWith(array('MapsPage','StationMap'));
    }
    
    
   

  public static function getCurrentUrl() {
    $url = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 'https://' : 'http://';
    $url .= $_SERVER['SERVER_NAME'];
    if ($_SERVER['SERVER_PORT'] != '80') {
      $url .= $_SERVER['SERVER_PORT'];
    }
    $url .= $_SERVER["REQUEST_URI"];
    return $url;
  }

  private static function postReq($postData) {
    $ch = new RestfulService(self::$SERVER_URL,0);
    $response = $ch->request('', "POST", json_encode($postData),$headers=array('Content-Type: application/json'));
    
    $http_code = $response->getStatusCode();
    if ($http_code == '200' && !empty($response)) {
        return $response->getBody();
    }
    return $response->getBody();
  }
  
  public static function verifyReq($continueUrl, $response) {
    $request = array();
    $request['requestUri'] = $continueUrl;
    $request['postBody'] = $response;
    
    $result = self::postReq($request);
    if (!empty($result['result'])) {
        return $result;
    }
    return NULL;
  }
  
  private function generatepin($n=5) {
		$pin = intval( "0" . rand(1,9) . rand(0,9) . rand(0,9) . rand(0,9) . rand(0,9) );
	 	return $pin;
	}
    
}
 
?>
