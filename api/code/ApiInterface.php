<?php

class ApiInterface extends Controller {
	
	private $GOOG = 'https://www.google.com/fusiontables/api/query?sql=SELECT+*+FROM+2177968';
	
	// Set our AccountSid and AuthToken 
	private $AccountSid = "AC73f7408b42a64959b4fbc0c770305fdc";
	private $AuthToken = "351350c4b58924258e1eca728f047984";
	private $Pin;
	
	// Twilio REST API version 
	protected $ApiVersion = "2010-04-01";
	
	// Outgoing Caller ID you have previously validated with Twilio 
	protected $CallerID = '2028001827';
	
	private function smsUserPin($pin=11111,$phone) {
		$accountSid = $this->AccountSid;
    	$authToken = $this->AuthToken;
    	$callerid =  $this->CallerID;
		// Instantiate a new Twilio Rest Client 
		$client = new Services_Twilio($accountSid, $authToken);
		$message = $client->account->sms_messages->create(
		  $callerid, // From a valid Twilio number
		  $phone, // Text this number
		  "Your secret pin number is ".$pin
		);
		//$response = $client->request("/$ApiVersion/Accounts/$AccountSid/Calls","POST", $data); 

		// check response for success or error
		
		return $message->sid;


	}
	
	public function createUser($arguments){
		/* Request Variables */
    	$v = $arguments->requestVars();
    	$callbackFunc = NULL;
    	/* request keys */
    	$keys = array_keys($v);
    	
    	/*Check for Callback Key */
    	if(array_key_exists('callback',$v)){
    		if($v['callback'] == '?'){
    		echo "Invalid parameter value: callback=?";
    		exit;
    		}else{
    		$callbackFunc = $v['callback'];
    		}
    		//var_dump($callbackFunc);exit;
    	}
    	unset($v['callback']);
    	if($callbackFunc != NULL){
    		echo "//API Callback".PHP_EOL;
    		echo $callbackFunc."(";
    	}
    	
    	// Do Important stuff
    	if(!array_key_exists('name',$v)){
    		//NormalizeName into username
    	}
	}
	
    public function verifyPhone($arguments) {
    	//exit;
    	//Connect to simpleforum database
    	$accountSid = $this->AccountSid;
    	$authToken = $this->AuthToken;
    	$callerid =  $this->CallerID;
    	
    	/* Request Variables */
    	$v = $arguments->requestVars();
    	$callbackFunc = NULL;
    	/* request keys */
    	$keys = array_keys($v);
    	
    	/*Check for Callback Key */
    	if(array_key_exists('callback',$v)){
    		if($v['callback'] == '?'){
    		echo "Invalid parameter value: callback=?";
    		exit;
    		}else{
    		$callbackFunc = $v['callback'];
    		}
    		//var_dump($callbackFunc);exit;
    	}
    	
    	//header('Content-Type: text/plain;encoding=utf-8');
    	unset($v['callback']);
    	if($callbackFunc != NULL){
    		echo "//API Callback".PHP_EOL;
    		echo $callbackFunc."(";
    	}
    	
    	// Do Important stuff
    	if(!array_key_exists('phone',$v)){
    		$v['phone'] = 'null';
    	}else{
			//Validate US Phone
			$phone = self::validate_usphone($v['phone']);
			if($phone === false){
				echo "Invalid parameter value: phone=".$v['phone'];
				exit;
			}
    	}
    	
    	//Formatted Phone Number
    	$formattedPhone = preg_replace("/([0-9]{3})([0-9]{3})([0-9]{4})/", "($1) $2-$3", $v['phone']);
		$v['formatedPhone'] = $formattedPhone;
		
    	//Generate Pin
	   	$pin = $this->generatepin();
	   	
	   	//Set Pin to session (recommended) or send back to device
    	$v['pin'] = $pin;
    	Session::set('Pin', $pin);
    	//Text Pin to user
    	$a = $this->smsUserPin($pin,$v['phone']);
    	$v['a'] = hash('ripemd128',$a.'+'.$v['pin']);
    	$v['b'] = substr($a,2);
    	$args = json_encode($v);
    	print $args;
    	if($callbackFunc != NULL){
    		echo ")";
    	}
    	exit;//$args = json_encode(
    }
    
    public function verifyPin($arguments) {
    	//exit;
    	//Connect to simpleforum database
    	$accountSid = $this->AccountSid;
    	$authToken = $this->AuthToken;
    	$callerid =  $this->CallerID;
    	
    	/* Request Variables */
    	$v = $arguments->requestVars();
    	$callbackFunc = NULL;
    	/* request keys */
    	$keys = array_keys($v);
    	
    	/*Check for Callback Key */
    	if(array_key_exists('callback',$v)){
    		if($v['callback'] == '?'){
    		echo "Invalid parameter value: callback=?";
    		exit;
    		}else{
    		$callbackFunc = $v['callback'];
    		}
    		//var_dump($callbackFunc);exit;
    	}
    	
    	//header('Content-Type: text/plain;encoding=utf-8');
    	
    	
    	// Do Important stuff
    	if(!array_key_exists('pin',$v)){
    		$v['pin'] = 'null';
    	}else{
			//Check Pin
			
			if(array_key_exists('a',$v) && array_key_exists('b',$v)){
				 $test = hash('ripemd128','SM'.'ed672c272b714ffd97e0e394617ce9c7'.'+'.'091094');
				 if($v['a'] == $test){
				 	//Success
				 	//self::activateUser($v['b']);
				 	echo $test;
				 }
				 
				exit;
			}else{
				echo 'invalid';
				exit;
			}
    	}
    	
    	unset($v['callback']);
    	if($callbackFunc != NULL){
    		echo "//API Callback".PHP_EOL;
    		echo $callbackFunc."(";
    	}
    	
    	//Formatted Phone Number
    	$formattedPhone = preg_replace("/([0-9]{3})([0-9]{3})([0-9]{4})/", "($1) $2-$3", $v['phone']);
		$v['formatedPhone'] = $formattedPhone;
		
    	
    	$args = json_encode($v);
    	print $args;
    	if($callbackFunc != NULL){
    		echo ")";
    	}
    	exit;//$args = json_encode(
    }
    
    
    
    private function validate_usphone($phonenumber,$useareacode=true)
	{
		if ( preg_match("/^[ ]*[(]{0,1}[ ]*[0-9]{3,3}[ ]*[)]{0,1}[-]{0,1}[ ]*[0-9]{3,3}[ ]*[-]{0,1}[ ]*[0-9]{4,4}[ ]*$/",$phonenumber) || (preg_match("/^[ ]*[0-9]{3,3}[ ]*[-]{0,1}[ ]*[0-9]{4,4}[ ]*$/",$phonenumber) && !$useareacode)) return eregi_replace("[^0-9]", "", $phonenumber);
		return false;
	}
	
	private function generatepin($n=6) {
		$pin = intval( "0" . rand(1,9) . rand(0,9) . rand(0,9) . rand(0,9) . rand(0,9) . rand(0,9) );
	 	return $pin;
	}

	private function getRealIpAddr() {
		if (!empty($_SERVER['HTTP_CLIENT_IP']))   //check ip from share internet
		{
		  $ip= $_SERVER['HTTP_CLIENT_IP'];
		}
		else if (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //to check ip is pass from proxy
		{
		  $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
		}
		else
		{
		  $ip=$_SERVER['REMOTE_ADDR'];
		}
		return $ip;
	}
   
}
