<?php
	require_once(__DIR__."/../facebook/classes/whatsapp_api.php");

	$chat = new whats_app_api();
	$response = $chat->send_message_custom("Class is over",'233506899883',"EAAQ49qswcpsBANjBYZB1HZCeIvzYKZAzut4pOZAeRAFPsM1EQ1ctUgN42c11aOZAYeZAGIiu0Q2wnEweISiuQ5PevdB26Jo3yXMcdylSvCjcmxpROT7mTaZButFdw8vtebEKZAk6ITkGQJUgxZBFk0SIMPBtIoXDQ268ZCFa958RX4g2BarWp7Lomk2EdF6dRawaZBzOW0IPwqygJUZAysxc7kJl5qyQfRT35EcZD");
	var_dump($response);
	return $response;
?>