<?php
// url = 'http://localhost/kiosk/api/index.php/{component}/'
	require_once(__DIR__."/utils/core.php");
	$component = trim($_SERVER["PATH_INFO"],"/");


	switch($component){
		case "database":
			require_once(__DIR__."/database/processors/database.php");
			break;
		case "social_media":
		case "payments":
		case "media":


		default:
		send_json(array("msg"=> "Component Implementation unavailable"));
	}
?>