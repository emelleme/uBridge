<?php
 /* Maps Controller */
class Maps_Controller extends ContentController {
    public function stations($arguments) {
        return $this->renderWith(array('MapsPage','StationMap'));
    }
    
    function districts($arguments) {
        return $this->renderWith(array('MapsPage','DistrictMap'));
    }
}
 
?>
