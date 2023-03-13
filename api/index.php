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
			require_once(__DIR__."/payment/processors/payment.php");
		case "media":
		case "messenger":
			require_once(__DIR__."/messenger/processors/messenger.php");
			break;

		default:
		send_json(array("msg"=> "Component Implementation unavailable"));
	}
?>