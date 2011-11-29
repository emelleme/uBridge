<?php
class uMessage extends DataObject {

	public static $db = array(
		'Sid' => 'Varchar(100)',
		'SmsStatus' => 'Varchar',
		'Debug' => 'Text',
		'Body' => 'Text',
		'LastResponse' => 'Int',
		'releaseDate' => 'Varchar(30)'//Datetime 
	);

	public static $belongs_many_many = array(
		'Events' => 'Event'
	);

}
