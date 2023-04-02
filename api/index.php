<?php
// url = 'http://localhost/kiosk/api/index.php/{component}/'
	require_once(__DIR__."/utils/core.php");
	$component = trim($_SERVER["PATH_INFO"],"/");


	switch($component){
		case "database":
			require_once(__DIR__."/database/processors/database.php");
			die();
		case "payments":
			require_once(__DIR__."/payment/processors/payment.php");
			die();
		case "messenger":
			require_once(__DIR__."/facebook/processors/meta_processor.php");
			die();
		case "token":
			$code = $_POST["code"];
			$encrypt = encrypt($code);
			echo $encrypt;
			die();
			// echo "<pre>";
			// var_dump($_GET);
			// echo "</pre>";
			// echo "<pre>";
			// var_dump($_POST);
			// echo "</pre>";
			// echo "<pre>";
			// var_dump($_REQUEST);
			// echo "</pre>";

			break;

		default:
			send_json(array("msg"=> "Component Implementation unavailable"));
	}
?>