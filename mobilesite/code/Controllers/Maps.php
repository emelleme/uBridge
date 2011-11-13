<?php
 /* Maps Controller */
class Maps_Controller extends ContentController {
	public function index($arguments){
		return $this->renderWith('MapsPage');
	}
    public function stations($arguments) {
        return $this->renderWith(array('MapsPage','StationMap'));
    }
    
    function districts($arguments) {
        return $this->renderWith(array('MapsPage','DistrictMap'));
    }
}
 
?>
