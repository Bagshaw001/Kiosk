<?php

require_once(__DIR__."/core.php");
require_once(__DIR__."/../utils/chat_bot.php");

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


echo "Testing curl \n";

echo function_exists("curl_version") ? "all good": "Cant run";



$chat = new chat_bot();


?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
</head>
<body>
	<form action="" method="post">
		<input type="text" name="message">
		<button type="submit">Send</button>
	</form>
	<?php
		if(isset($_POST["message"])){
			$message = $_POST["message"];
				$res = $chat->send_prompt($message);
				// echo "Response ";
				echo "<pre>";
				var_dump($res["choices"][0]["message"]);
				echo "</pre>";
				// $res = json_encode($res,true);
				$content=json_decode($res["choices"][0]["message"]['content'],true);
				$type = $content["type"];
				$reason = $content["reason"];


				echo "<small>Message you sent</small>: $message<br>";
				echo "<small>Classification</small>: $type<br>";
				echo "<small>Reason</small>: $reason<br>";

			}
	?>
</body>
</html>