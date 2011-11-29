<?php
/**
 * ForumRole
 *
 * This decorator adds the needed fields and methods to the {@link Member}
 * object.
 *
 * @package forum
 */
class HostRole extends DataObjectDecorator {

	/**
	 * Define extra database fields
	 *
	 * Return an map where the keys are db, has_one, etc, and the values are
	 * additional fields/relations to be defined
	 */
	function extraStatics() {
		$fields = array(
			'db' => array(
				'nickName' => 'Varchar',
				'displayName' => 'Varchar',
				'identifier' => 'Varchar(150)',
				'PhoneNumber' => 'Varchar',
				'pin' => 'Varchar(5)',
				'profilePicture' => 'Varchar(150)',
				'language' => 'Varchar'
			),
			'has_one' => array(
				
			),
			'has_many' => array(
				'VerifiedAddresses' => 'Address'
			),
			'belongs_many_many' => array(
				'Events' => 'Event',
				'EventSessions' => 'Session'
			),
			'searchable_fields' => array(
				
			),
			'indexes' => array(
			),
		);
		
		return $fields;
	}
	
	function updateCMSFields(FieldSet &$fields) {
		//$allForums = DataObject::get('Forum');
		//$fields->removeByName('FirstName');
		//$fields->removeByName('Surname');
		//$fields->removeByName('PersonalDetails');
		//$fields->removeByName('Password');
		//$fields->removeByName('pin');
		
	}
}
