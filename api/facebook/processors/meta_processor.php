<?php

require_once(__DIR__."/../../utils/core.php");
require_once(__DIR__."/../classes/whatsapp_api.php");
require_once(__DIR__."/../../database/controllers/db_controller.php");
require_once(__DIR__."/../../utils/chat_bot.php");


function facebook(){
	$request = $_SERVER["REQUEST_METHOD"];

		if ($request == "POST"){
			if(!isset($_POST["action"])){
				echo " <action> required";
				die();
			}

			switch($_POST["action"]){
				case "create_account":
					die();
				case "incoming_whatsapp":
					$object = json_decode($_REQUEST["message"], true);
					$number = $object["value"]["contacts"][0]["wa_id"];
					$message = $object["value"]["messages"][0]["text"]["body"];

					$file = 'log.txt';
					file_put_contents($file, "number $number message $message\n", FILE_APPEND | LOCK_EX);
	// $data =json_encode($object)."\n";
	// file_put_contents($file, "$data", FILE_APPEND | LOCK_EX);
					$whatsapp = new whats_app_api();
					$res = $whatsapp->send_message_custom("Welcome to kiosk. Chat bot is waiting for open ai key",$number,"EAAQ49qswcpsBAFRU4m5PMP7TvVCKcQE5vATSfUxTGg0PZBhBDcpiFWF3v2EOL40860BvZAj1eHyL3BuWpVMN33y56iSMKVZCTYNcewaZCnhZAZAucNc9NSe35DHdZBkFE3TprJzTCwNqpsIzEKgltY6DIdAuRjRqZCzC0qIVbaED2E7ybdoWcUAgWswZAprrSWV2NdXZAoMMMZBW4KrLlrv120WBe2ORLjKGfAZD");
					$a = json_encode($res);
					file_put_contents($file, "$a\n", FILE_APPEND | LOCK_EX);

					//send message back to sender

					// $message = $_REQUEST["message"];
					// $number= $_REQUEST["number"];

					//chatbot process message


					// $whatsapp->send_message_custom("Recied from webhook",'233559582518',"EAAQ49qswcpsBAFRU4m5PMP7TvVCKcQE5vATSfUxTGg0PZBhBDcpiFWF3v2EOL40860BvZAj1eHyL3BuWpVMN33y56iSMKVZCTYNcewaZCnhZAZAucNc9NSe35DHdZBkFE3TprJzTCwNqpsIzEKgltY6DIdAuRjRqZCzC0qIVbaED2E7ybdoWcUAgWswZAprrSWV2NdXZAoMMMZBW4KrLlrv120WBe2ORLjKGfAZD");
					// $whatsapp->send_message_template('0559582518','EAAQ49qswcpsBAIdmQg64JWxBFzORgh84OSHrEEQ4eXOII19PWGNWUTyRoULbZCY7sgmnbsvhruLqvCNVX69XU37qS0DMqPIug4G7RnZAG6vpNpBoos6uEAdZB2WHlIbeNkgMKbZCCl4hqYIBKhuJH6wCAQnGRkUdmgfZC5gPTdLPcnFC4lDwyH6rJWAVFaHnPAzrZA2nrZCEZCSAsjiQBNdrtZAcxCAI2ghoZD');
					// $object = $data["entry"][0]["changes"][0];
					// $message = $object["value"]["messages"][0]["text"]["body"];
					// $whatsapp = new whats_app_api();
					// $whatsapp->send_message_custom("Recied from webhook",'233559582518',"EAAQ49qswcpsBAFRU4m5PMP7TvVCKcQE5vATSfUxTGg0PZBhBDcpiFWF3v2EOL40860BvZAj1eHyL3BuWpVMN33y56iSMKVZCTYNcewaZCnhZAZAucNc9NSe35DHdZBkFE3TprJzTCwNqpsIzEKgltY6DIdAuRjRqZCzC0qIVbaED2E7ybdoWcUAgWswZAprrSWV2NdXZAoMMMZBW4KrLlrv120WBe2ORLjKGfAZD");
					$file = 'log.txt';
					$data =json_encode($data)."\n";
					file_put_contents($file, $data, FILE_APPEND | LOCK_EX);
					die();
				case "send_message":
					die();
				default:
					// echo "No implementation for <". $_POST["action"] .">";
					send_json(array("msg" => "No implementation for <". $_POST["action"] .">"));
					}
					die();



		}else if ($request == "GET"){
			switch($_GET["action"]){
				case "get_login_url":
					$store_id = $_GET["store_id"];
					//TODO verify that store exists before proceeding
					$whats = new whats_app_api();
					$url = $whats->generateLoginUrl($store_id);
					echo $url;
					// send_json( $url);
					die();
				case"get_token":
					$store_id = $_GET["store_id"];
					$code = $_GET["code"];
					$what = new whats_app_api();
					$response = $what->tryAndLoginWithFacbook($code,$store_id);
					if(!$response){
						echo "Something went wrong. Try again!";
						die();
					}
					// var_dump($response);
					$platform = $response["platform"];
					$expiry = $response["expiry_date"];
					$response = $response["data"];
					$token = $response["access_token"];
					$api_key = generate_id();
					$date = date('Y-m-d h:i:s');
					// echo $token;

					add_social_media_account($api_key,$store_id,$platform,$date,$expiry,$token);

					//store credential for store if new
					//update credential if exits
					//store token
					//ask user to return to their browser and refresh the page
					echo "Successfully linked your account. Refresh the dashboard to view";
					die();
				case "whatsapp_message":
					//get whatsapp message
					$number_id = $_REQUEST["value"]["metadata"]["phone_number_id"];
					$message = $_REQUEST["messages"][0]["text"]["body"];
					$message_id = $_REQUEST["messages"][0]["id"];

					//get response from chatbot
					$chat = new chat_bot();
					$res = $chat->send_prompt($message);
					$content=json_decode($res["choices"][0]["message"]['content'],true);
					$type = $content["type"];

					//action based response
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
						$products = $res["response"]["products"];

						//return a list of products
						break;
					case "unknown":
						break;
					case "catalog_request":
							//get all products
							//send products to user
					case "order":
						$product_name = $content["product_name"];
						$quantity = $content["quantity"];
						//get the price and let them know
						break;
					default:
						echo "Un covered type";
						echo "type: $type";
				}

					//send response
					die();
				default:
					send_json(array("msg" => "No implementation for <". $_GET["action"] .">"));
			}
			die();
		} else {
			echo "unsupported method";
			die();
		}

	echo "EOF";
	die();
}

facebook();
