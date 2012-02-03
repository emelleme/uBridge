<?php
class uEvent extends Page {

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
		'Sessions' => 'EventSession'
		
	);
	

}
/* Event Controller */
class Event_Controller extends ContentController {
	
	/* add controllers for place verification, saving events, and rsvps */

	public function v($arguments){
		//View Event
    	return $this->renderWith('EventViewPage');
    }
    
    public function saveData($arguments){
		//View Event
		$params = $this->getURLParams();
		$eventinfo = $arguments->requestVars();
		$member = Member::currentUser();
		$dmember = DataObject::get_one("Event", '"Event_Live"."ID" = '.$params["ID"].' AND "Event_Live"."OwnerID"='.$member->ID);
		$dmember->Summary = @$eventinfo["first_name"];
		$dmember->startTime = @$eventinfo["date1"]." - ".@$eventinfo["date2"];
		$dmember->endTime = @$eventinfo["date3"]." - ".@$eventinfo["date4"];
		$dmember->MemberID = $member->ID;
		$dmember->write();
    	return Director::redirect('/host');
    }
    
    public function edit($arguments){
    	//Requires Permission Check
    	$params = $this->getURLParams();
    	$member = Member::currentUser();
    	//var_dump($member);
    	$event = DataObject::get_one("Event", '"Event_Live"."ID" = '.$params["ID"].' AND "Event_Live"."OwnerID"='.$member->ID);
    	if($event){
			$data = array(
				"EventInfo" => $event
			);
			return $this->customise($data)->renderWith('EventEditPage');
    	}else{
    		return Director::redirect('/host');
    	}
    }
    
    
    public function search($arguments){
    
    	$member = Member::currentUser();
		$token = Session::get('AuthToken');
		
		if($token==''){
			Director::redirect('/login');
		}
		if($member){
			return $this->renderWith('AppPage');
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
			
			return $this->renderWith('AppPage');
			//var_dump((array) $user);
			//var_dump($token);
			//exit;
			//return $this->renderWith(array('SignupPage','Page'));
		}
    }
}
