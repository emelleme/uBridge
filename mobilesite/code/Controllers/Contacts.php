<?php
 /* Contacts Controller */
class Contacts_Controller extends ContentController {
    public function index($arguments) {
        return $this->renderWith('ContactsPage');
    }

    private $ADMIN_URL = 'https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+2024373';
    private $INVESTIGATIVE_URL = 'https://www.google.com/fusiontables/api/query?sql=SELECT+UNIT,ADDRESS,TELEPHONE,EMAIL+FROM+2024091';
    private $PATROL_URL = 'https://www.google.com/fusiontables/api/query?sql=SELECT+UNIT,ADDRESS,PHONE,EMAIL+FROM+1842345';

    private function getContact($sql) {
        /* Returns contacts as json string */
        $r = new RestfulService($sql,$expiry = 3600);
        $resp = $r->request();
        $contacts = str_getcsv($resp->getBody(), "\n");
        $arr = array();

        foreach($contacts as $key=>$contact){
            if($key >= 0 && $contact != ''){
                $arr[$key] = str_getcsv($contact, ",");
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

    private function customiseDataForTemplate($url, $title) {
        $fetchedContacts = $this->getContact($url);
        //Returns Unit, Address, Phone, and Email
        $contacts = new DataObjectSet();
        foreach($fetchedContacts as $key=>$value){
            if($key > 0){
                //Create DataObject array
                $c = array(
                    "Unit" => $value[0],
                    "Address" => $value[1],
                    "Phone" => $value[2],
                    "Email" => $value[3]
                );
                //Push the data onto the DataObjectSet
                $contacts->push(new ArrayData($c));
            }
        }
        //Now that we have our Data Set, we can send it to the template
        $dataForTemplate = array(
            "ContactsInfo" => $contacts,
            "ContactsTitle" => $title
        );
        //var_dump($contacts);
        return $this->customise($dataForTemplate)->renderWith("ContactList");
    }
    
    public function UniformPatrolContacts(){
    	return $this->customiseDataForTemplate($this->PATROL_URL, "Uniform Patrol Contacts");
    }

    public function InvestigativeContacts(){
        return $this->customiseDataForTemplate($this->INVESTIGATIVE_URL, "Investigative Contacts");
    }

    public function AdministrativeContacts(){
        return $this->customiseDataForTemplate($this->ADMIN_URL, "Administrative Contacts");
    }

}
 
?>
