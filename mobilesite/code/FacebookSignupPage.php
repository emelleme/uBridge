<?php

class FacebookSignupPage extends Page {

	public static $db = array(
	);

	public static $has_one = array(
	);

}
class FacebookSignupPage_Controller extends Page_Controller {

	/**
	 * An array of actions that can be accessed via a request. Each array element should be an action name, and the
	 * permissions or conditions required to allow the user to access it.
	 *
	 * <code>
	 * array (
	 *     'action', // anyone can access this action
	 *     'action' => true, // same as above
	 *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
	 *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
	 * );
	 * </code>
	 *
	 * @var array
	 */
	public static $allowed_actions = array (
	);

	public function init() {
		parent::init();
	}
	
	public function saveAuthToken($arguments){
		$token = $this->request['token'];
		$auth = explode("=",$token);
		Session::set('AuthToken',$auth[1]);
		echo $auth[1];
	}
	
	public function index(){
		// Check to see if Current Member is logged in
		$member = Member::currentUser();
		$token = Session::get('AuthToken');
		if($token==''){
			Director::redirect('/');
		}
		if($member){
			return $this->renderWith('EventSearchPage');
		}else{
			//New Member! Get Member info and create record
			if(!$token){
				Director::redirect('/');
			}
			$graph_url = "https://graph.facebook.com/me?access_token=" . $token;
			$userinfo = json_decode(file_get_contents($graph_url));
				//Create Member
			$dmember = new Member();
			$dmember->FirstName = @$userinfo["first_name"];
			$dmember->LastName = @$userinfo["last_name"];
			$dmember->username = @$userinfo["username"];
			$dmember->displayName = @$userinfo["name"];
			$dmember->Email = @$userinfo["email"];
			//$dmember->profilePhoto = @$userinfo["photoUrl"];
			$dmember->fbID = @$userinfo["id"];
			$dmember->locale = @$userinfo["locale"];
			$dmember->bio = @$userinfo["bio"];
			$dmember->fblocation = @$userinfo["location"]->name;
			$memberid = $dmember->write();
			$dmember->ID = $memberid;
			$dmember->logIn(TRUE);
			
			//Todo: direct user to setup page
			
			return $this->renderWith('EventSearchPage');
			//var_dump((array) $user);
			//var_dump($token);
			//exit;
			//return $this->renderWith(array('SignupPage','Page'));
		}
	}
	
	public function go(){
	//Session::clear_all();
		//Check Request Variable
		
			//Code value sent. Get auth token, and create new user.
		$token = Session::get('AuthToken');
		//get token from url hash
		return $this->renderWith('FbAuthenticate');
	}
}
