<?php
 /* Maps Controller */
class GuestLogin_Controller extends ContentController {
    public function index($arguments){
    	return $this->renderWith('GuestLogin');
    }
    
    public function googauth($arguments) {
        //return $this->renderWith(array('MapsPage','StationMap'));
    }
}
 
?>
