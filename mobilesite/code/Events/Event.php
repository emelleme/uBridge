<?php
class Event extends Page {

	public static $db = array(
		'EventTitle' => 'Varchar(20)',
		'Category' => 'Varchar',
		'AuthorName' => 'Varchar',
		'AuthorEmail' => 'Varchar',
		'Summary' => 'Text',
		'startTime' => 'Varchar',
		'endTime' => 'Varchar'
	);
	
	public static $many_many = array(
		'Messages' => 'uMessage',
		'Attendees' => 'Member'
	);
	
	public static $has_one = array(
		'Owner' => 'Member'
	);
	
	public static $has_many = array(
		'Sessions' => 'Session'
	);
	

}
/* Event Controller */
class Event_Controller extends ContentController {
	public function v($arguments){
		//View Event
    	return $this->renderWith('EventViewPage');
    }
    public function edit($arguments){
    	//Requires Permission Check
    	$params = $this->getURLParams();
    	$event = DataObject::get_by_id("Event", $params["ID"]);
    	$data = array(
    		"EventInfo" => $event
		);
    	return $this->customise($data)->renderWith('EventEditPage');
    }
    public function search($arguments){
    
    	$member = Member::currentUser();
		$token = Session::get('AuthToken');
		
		if($token==''){
			Director::redirect('/login');
		}
		if($member){
			return $this->renderWith('EventSearchPage');
		}else{
			//New Member! Get Member info and create record
			if(!$token){
				Director::redirect('/login');
			}
			$graph_url = "https://graph.facebook.com/me?access_token=" . $token;
			$userinfo = json_decode(file_get_contents($graph_url));
			$userinfo = (array) $userinfo;
				//Create Member
			$dmember = new Member();
			$dmember->FirstName = @$userinfo["first_name"];
			$dmember->LastName = @$userinfo["last_name"];
			$dmember->fbusername = @$userinfo["username"];
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
}
