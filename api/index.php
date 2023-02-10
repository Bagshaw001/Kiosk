<?php
// url = 'http://localhost/kiosk/api/index.php/{component}/'
	require_once(__DIR__."/utils/core.php");
	require_once(__DIR__."/utils/http_handler.php");

	if (isset($_SERVER["PATH_INFO"])){
		$component = trim($_SERVER["PATH_INFO"],"/");
	}else {
		send_json(array("msg"=> "No component provided"));
		die();
	}


	switch($component){
		case "database":
			require_once(__DIR__."/database/processors/database.php");
			break;
		case "messenger":
			require_once(__DIR__."/messenger/processors/messenger.php");
			break;
		case "social_media":
		case "payments":
		case "media":


		default:
		send_json(array("msg"=> "Component Implementation unavailable"));
	}
?>