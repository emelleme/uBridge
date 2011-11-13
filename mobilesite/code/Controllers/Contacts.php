<?php
 /* Maps Controller */
class Contacts_Controller extends ContentController {
    public function index($arguments) {
        return $this->renderWith('ContactsPage');
    }

    private $ADMIN_URL = 'https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+2024373';
    private $INVESTIGATIVE_URL = 'https://www.google.com/fusiontables/api/query?sql=SELECT+UNIT,ADDRESS,EMAIL,TELEPHONE+FROM+2024091';
    private $PATROL_URL = 'https://www.google.com/fusiontables/api/query?sql=SELECT+UNIT,ADDRESS,EMAIL,PHONE+FROM+1842345';

    private function getContact($sql) {
        /* Returns contacts as json string */
        $r = new RestfulService($sql,$expiry = 3600);
        $resp = $r->request();
        $contacts = explode("\n",$resp->getBody());
        $arr = array();

        foreach($contacts as $key=>$contact){
            if($key >= 0){
                $arr[$key] = explode(",",$contact);
            }
        }
            
        return $arr;             
    }
    
    public function getAdministrativeContacts($arguments){
    	echo json_encode($this->getContact($this->ADMIN_URL));
    }
    
    public function getInvestigativeContacts($arguments){
    	echo json_encode($this->getContact($this->INVESTIGATIVE_URL));
    }
    
    public function getPatrolContacts($arguments){
    	echo json_encode($this->getContact($this->PATROL_URL));
    }

    public function getAllContacts($arguments) {
        $arr = array();
        $arr['administrative'] = $this->getContact($this->ADMIN_URL);
        $arr['investigative'] = $this->getContact($this->INVESTIGATIVE_URL);
        $arr['patrol'] = $this->getContact($this->PATROL_URL);

        echo json_encode($arr);
    }
    
}
 
?>
