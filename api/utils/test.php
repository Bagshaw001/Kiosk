<?php

require_once(__DIR__."/core.php");

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
		<input type="text" name="message" value="Do you have IPhone 13">
		<button type="submit">Send</button>
	</form>
	<?php
		if(isset($_POST["message"])){
			$message = $_POST["message"];
			if($message == "help"){
				echo "Here are the recommended templates you can use to get automated responses
				Making an enquiry: Do you have ........
				Ordering a product: I want to buy <product_name>
				
				";
			}else {
				$res = $chat->send_prompt($message);
				// echo "Response ";
				echo "<pre>";
				var_dump($res["choices"][0]["message"]);
				echo "</pre>";
				// $res = json_encode($res,true);
				// $content = json_decode(utf8_encode($res["choices"][0]["message"]["content"]), true);
				$content=json_decode($res["choices"][0]["message"]['content'],true);

				echo "<strong>Content</strong>";
				echo "<pre>";
				var_dump($content);
				echo "</pre>";
				$type = $content["type"];
				$reason = $content["reason"];


				echo "<small>Message you sent</small>: $message<br>";
				echo "<small>Classification</small>: $type<br>";
				echo "<small>Reason</small>: $reason<br>";

				//actions depending on the type of text
				switch($type){
					case "enquiry":
						//get the products with the name and get the availability
						$product_name = $content["product_name"];
						$http = new http_handler();

						$res = $http->post("137.184.228.209/kiosk/api/index.php/database",array(
							"action" => "search_products",
							"store_id" => "be53953f6d9a979d34a265547f962448",
							"product_name" => $product_name
						));
						echo "<pre>";
						echo "<small>Products</small><br>";
						var_dump($res["response"]["products"]);
						echo "</pre>";

						//return a list of products
						break;
					case "order":
						$product_name = $content["product_name"];
						$quantity = $content["quantity"];
						break;
					default:
						echo "Un covered type";
						echo "type: $type";
				}
			}

		}
	?>
</body>
</html>