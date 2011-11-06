<?php
 /* Maps Controller */
class Contacts_Controller extends ContentController {
    public function index($arguments) {
        return $this->renderWith('ContactsPage');
    }

    private function getContact($sql) {
        /* Returns contacts as json string */
        $r = new RestfulService($sql,$expiry = 3600);
        $resp = $r->request();
        $contacts = explode("\n",$resp->getBody());
        $arr = array();

        foreach($contacts as $key=>$contact){
            if($key > 0){
                $arr[$key] = explode(",",$contact);
            }
        }
            
        return json_encode($arr);             
    }
    
    public function getAdministrativeContacts($arguments){
    	echo $this->getContact('https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+2024373');
    }
    
    public function getInvestigativeContacts($arguments){
    	echo $this->getContact('https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+2024091');
    }
    
    public function getPatrolContacts($arguments){
    	echo $this->getContact('https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+1842345');
    }
    
    function districts($arguments) {
        return $this->renderWith(array('MapsPage','DistrictMap'));
    }
}
 
?>
