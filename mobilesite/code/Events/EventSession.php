<?php
class uEventSession extends DataObject {

	public static $db = array(
		'SessionName' => 'Varchar(100)',
		'SessionAuthor' => 'Varchar(100)',
		'SessionAuthorBio' => 'Text',
		'SessionLocation' => 'Varchar',
		'SessionLocationID' => 'Varchar(150)',
		'Summary' => 'Text',
		'LastResponse' => 'Int',
		'releaseDate' => 'Varchar(30)'//Datetime 
	);

	public static $has_one = array(
		'Event' => 'Event'
	);
	
	public static $many_many = array(
		'Messages' => 'uMessage',
		'Attendees' => 'Member'
	);

}
