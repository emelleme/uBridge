<?php

global $project;
$project = 'mobilesite';

global $database;
$database = 'ubridge_3';
 
// Use _ss_environment.php file for configuration
require_once("conf/ConfigureFromEnv.php");

MySQLDatabase::set_connection_charset('utf8');

// This line set's the current theme. More themes can be
// downloaded from http://www.silverstripe.org/themes/
SSViewer::set_theme('blackcandy');
Security::setDefaultAdmin("admin","password1");

Director::set_environment_type("dev");

//Add Host Role
DataObject::add_extension('Member', 'HostRole');
DataObject::add_extension('Member', 'UserRole');
/* URL Rules for Map View */
Director::addRules(50, array('guest/$Action/$ID' => 'GuestLogin_Controller'));
Director::addRules(50, array('host/$Action/$ID' => 'Host_Controller'));
Director::addRules(50, array('event/$Action/$ID' => 'Event_Controller'));
Director::addRules(50, array('login/$Action/$ID' => 'FacebookSignupPage_Controller'));
Director::addRules(50, array('signup/$Action/$ID' => 'FacebookSignupPage_Controller'));

// Set the site locale
i18n::set_locale('en_US');

LeftAndMain::setApplicationName("Emelle.me CMS");
// enable nested URLs for this site (e.g. page/sub-page/)
SiteTree::enable_nested_urls();
