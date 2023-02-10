<?php
require_once(__DIR__."/http_handler.php");


	$http = new http_handler();

	$response = $http->post("localhost/kiosk/api/index.php/messenger",array());
	var_dump($response);
?>