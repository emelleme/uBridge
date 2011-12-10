<?php
/**
 * ForumRole
 *
 * This decorator adds the needed fields and methods to the {@link Member}
 * object.
 *
 * @package forum
 */
class UserRole extends DataObjectDecorator {

	/**
	 * Define extra database fields
	 *
	 * Return an map where the keys are db, has_one, etc, and the values are
	 * additional fields/relations to be defined
	 */
	function extraStatics() {
		$fields = array(
			'db' => array(
				'username' => 'Varchar',
				'displayName' => 'Varchar',
				'fbID' => 'Varchar(10)',
				'fblocation' => 'Varchar(50)',
				'fbbio' => 'Text',
				'gender' => 'Varchar',
				'PhoneNumber' => 'Varchar',
				'pin' => 'Varchar(5)',
				'profilePicture' => 'Varchar(150)',
				'timezone' => 'Varchar',
				'updated_time' => 'Varchar'
			),
			'has_one' => array(
				
			),
			'has_many' => array(
				//'EventRSVPs' => 'Event',
				//'SessionRSVPs' => 'EventSession'
			),
			'belongs_many_many' => array(
				'Events' => 'Event',
				'EventSessions' => 'EventSession'
			),
			'searchable_fields' => array(
				
			),
			'indexes' => array(
			),
		);
		
		return $fields;
	}
	
	
}
