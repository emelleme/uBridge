<?php

global $project;
$project = 'mobilesite';

global $database;
$database = 'mobile_dev';
 
// Use _ss_environment.php file for configuration
require_once("conf/ConfigureFromEnv.php");

MySQLDatabase::set_connection_charset('utf8');

// This line set's the current theme. More themes can be
// downloaded from http://www.silverstripe.org/themes/
SSViewer::set_theme('blackcandy');
Security::setDefaultAdmin("admin","password1");

Director::set_environment_type("dev");

/* URL Rules for Map View */
Director::addRules(50, array('map/$Action/$ID' => 'Maps_Controller'));
Director::addRules(50, array('contact/$Action/$Division/$Query' => 'Contacts_Controller'));
Director::addRules(50, array('media/$Action/$ID' => 'Media_Controller'));
Director::addRules(50, array('forms/$Action/$ID' => 'Forms_Controller'));
// Set the site locale
i18n::set_locale('en_US');

// enable nested URLs for this site (e.g. page/sub-page/)
SiteTree::enable_nested_urls();
