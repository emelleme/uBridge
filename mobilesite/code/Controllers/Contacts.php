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
        $r = new RestfulService($sql,$expiry = 3);
        $resp = $r->request();
        $contacts = explode("\n",$resp->getBody());
        $arr = array();

        foreach($contacts as $key=>$contact){
            if($key >= 0 && $contact != ''){
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
    
    public function UniformPatrolContacts(){
    	//Get Contacts
    	$patrol = $this->getContact($this->PATROL_URL);
    	//Returns Unit, Address, Phone, and Email
    	$contacts = new DataObjectSet();
		foreach($patrol as $key=>$value){
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
    		"PatrolContacts" => $contacts
		);
		//var_dump($contacts);
    	return $this->customise($dataForTemplate)->renderWith("UniformPatrolList");
    }

    public function PatrolContactsAsHTML() {
        $html = '<li>
                    <h3>Uniform Patrol Contacts</h3>                
                    <ul data-role="listview" data-filter="true">';
        $contacts = $this->getContact($this->PATROL_URL);
        foreach($contacts as $key=>$contact){
            
            // very weird - can't access this way: $contact[2]

            $html .= '<li>
                            <div data-role="collapsible" data-theme="d" data-content-theme="b">
                                <h3>' . current($contact) . '</h3>
                                <div class="AddressBlock">
                                    <h4>Address</h4>
                                    <p>' . next($contact) . '</p>
                                </div>';
            next($contact);
            next($contact);
            
            $html .=            '<div class="AddressBlock">
                                    <div class="ui-grid-a">
                                    <div class="ui-block-a"><h4>Phone</h4></div>
                                    <div class="ui-block-b"><h4>Email</h4></div>
                                    </div>
                                    <div class="ui-grid-a">
                                    <div class="ui-block-a">' . next($contact) . '</div>
                                    <div class="ui-block-b">' . next($contact) . '</div>
                                    </div>
                                </div>
                            </div>
                        </li>';
        }
        $html .= '</ul></li>';    
        return $html;
    }

}
 
?>
