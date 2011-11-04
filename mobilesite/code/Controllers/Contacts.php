<?php
 /* Maps Controller */
class Contacts_Controller extends ContentController {
    public function index($arguments) {
        return $this->renderWith('ContactsPage');
    }
    
    public function getAdministrativeContacts($arguments){
    	/* Returns contacts as a json or array */
    	$sql = 'https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+2024373';
		$r = new RestfulService($sql,$expiry = 3600);
		$resp = $r->request();
		$contacts = explode("\n",$resp->getBody());
		foreach($contacts as $key=>$contact){
			if($key > 0){
				var_dump(explode(",",$contact));
			}
		}					
    }
    
    public function getInvestigativeContacts($arguments){
    	/* Returns contacts as a json or array */
    }
    
    public function getPatrolContacts($arguments){
    	/* Returns contacts as a json or array */
    }
    
    function districts($arguments) {
        return $this->renderWith(array('MapsPage','DistrictMap'));
    }
}
 
?>
