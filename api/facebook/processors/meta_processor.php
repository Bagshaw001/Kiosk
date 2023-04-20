<?php

require_once(__DIR__."/../../utils/core.php");
require_once(__DIR__."/../classes/whatsapp_api.php");
require_once(__DIR__."/../../database/controllers/db_controller.php");
require_once(__DIR__."/../../utils/chat_bot.php");


function facebook(){

	// $store_id = "be53953f6d9a979d34a265547f962448";
	// $product_name = $_GET["name"];

	// $product_id = search_products($product_name,$store_id);
	// send_json($product_id);
	// die();
	$request = $_SERVER["REQUEST_METHOD"];

		if ($request == "POST"){
			if(!isset($_POST["action"])){
				echo " <action> required";
				die();
			}

			switch($_POST["action"]){
				case "incoming_whatsapp":
					$object = json_decode($_REQUEST["message"], true);
					$number = $object["value"]["contacts"][0]["wa_id"];
					$message = $object["value"]["messages"][0]["text"]["body"];
					$message_id = $object["value"]["messages"][0]["id"];
					$store_id = "be53953f6d9a979d34a265547f962448";
					$whatsapp_api = "EAAQ49qswcpsBAM2j514s99Vne5AB1fpSh56YqXfZCUsSTy75ZANnkaB11YmaGQLE281D9m5CNw7uMqqZBDcSuOhoOBHeGdAZAXalgPZBOevPjbq6Y1TVswdE4MEgxZBsTWwPvvBpZBdwUMgAfHg3dHgimd91nFbSrvLBeiJUjRfNuPwEZArTa1ycpNYOSQalQzgIaNoGIaL60W7CSTY059N2IbG7JKFD7SgZD";

					$whatsapp = new whats_app_api();

					//parse common phrases
					if(str_contains($message,"order_id=")){
						$category="purchase";
					}else{

						$chat = new chat_bot();

						$chat_response = $chat->send_prompt($message);
						// $r = json_encode($chat_response);
						// $whatsapp->send_message_custom("$r", $number,$whatsapp_api);
						// $r = $chat_response["id"];
						// $whatsapp->send_message_custom("1 $r",$number,$whatsapp_api);

						$chat_obj = $chat_response["choices"][0]["message"]["content"];
						$chat_obj = json_decode($chat_obj,true);
						$category = $chat_obj["type"];

					}


					switch($category){
						case 'enquiry':
							$product_name = $chat_obj["product_name"];
							$post_body = array(
								"action"=> "search_products",
								"store_id" => $store_id,
								"product_name" => $product_name
							);
							//get all products with that name, their available quantities and prices
							$http = new http_handler();
							$post_res = $http->post("137.184.228.209/kiosk/api/index.php/database",
							$post_body);


							// send user list of inventory
							$products = $post_res["response"]["products"];

							if(empty($products)){//No products match that name
								$whatsapp_response = "We do not have a product under the name ($product_name). These are the products we have===     ";
								$post_res = $http->post("137.184.228.209/kiosk/api/index.php/database",
								array("action"=>"get_products","store_id"=> $store_id));
								$products = $post_res["response"]["products"];
							}else { //products match that name
								$whatsapp_response = "Here are all the products we have matching that name===     ";
							}


							foreach ($products as $prod) {
								$name = $prod["product_name"];
								$price = $prod["price"];
								$whatsapp_response.="     $name = GHC $price     ";
							}


							$whatsapp->send_message_reply( $whatsapp_response,$number,$whatsapp_api,$message_id);

							die();
						case 'order':
							$http = new http_handler();
							$product_name = $chat_obj["product_name"];
							$quantity = $chat_obj["quantity"];
							//if product exists, create an order and send the user
							//the id with the prompt to follow a format to make payment
							// $product_id = $http->post("137.184.228.209/kiosk/api/index.php/database",
							// array(
							// 	"action" => "search_products",
							// 	"product_name" => $product_name,
							// 	"store_id" => $store_id
							// ));
							$product_id = search_products($product_name,$store_id);
							// $whatsapp->send_message_reply("$product_name".json_encode($product_id),$number,$whatsapp_api,$message_id);

							$product_id = $product_id[0]["product_id"];

							$order_res1 = $http->post("137.184.228.209/kiosk/api/index.php/database",
							array(
								"action" => "order_product",
								"store_id" => $store_id,
								"product_id"=> $product_id,
								"quantity" => $quantity,
								"customer_id" => $number,
								"customer_name" => "Whatsapp customer"
							));


							$order_res = $order_res1["response"]["order_id"];
							// $whatsapp->send_message_reply(json_encode($order_res1),$number,$whatsapp_api,$message_id);

							$whatsapp->send_message_reply("You have successfully placed an order. Kindly provide this information for payment. NB: Replace only the here text keeping the bracket[] order_id=[f260f32674a78a1cbd159542c1c84651] Mobile money number=[here] Mobile money network =[here] ",
							$number,$whatsapp_api,$message_id
							  );
						die();

						case 'purchase':
							//todo check the payment prompt to make sure this works

							$message_array = explode("]",$message);
							$order_id = substr($message_array[0],strpos($message_array[0],"[")+1);
							$paybox = new paybox_custom();
							$order = get_order_info($order_id);
							$amount = $order["amount"];
							$network = substr($message_array[1],strpos($message_array[1],"[")+1);
							$pay_num = substr($message_array[2],strpos($message_array[2],"[")+1);
							$payload = array("source" => "capstone");
							$e = $paybox->charge_momo($order_id,'0.1', $network, $pay_num, $payload);
							$whatsapp->send_message_reply(json_encode($e),$number,$whatsapp_api,$message_id);
							die();
							// $order_id = ();
							// $network = ;
							// $number = ();

						default: //assume as a personal message
						$r = json_encode($chat_response);
							$whatsapp->send_message_custom("We have no answer> $r",$number,$whatsapp_api);
							die();
					}


					// $res = $whatsapp->send_message_reply("Welcome to kiosk. Chat bot is waiting for open ai key",$number,"EAAQ49qswcpsBAFRU4m5PMP7TvVCKcQE5vATSfUxTGg0PZBhBDcpiFWF3v2EOL40860BvZAj1eHyL3BuWpVMN33y56iSMKVZCTYNcewaZCnhZAZAucNc9NSe35DHdZBkFE3TprJzTCwNqpsIzEKgltY6DIdAuRjRqZCzC0qIVbaED2E7ybdoWcUAgWswZAprrSWV2NdXZAoMMMZBW4KrLlrv120WBe2ORLjKGfAZD",$message_id);

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
					// $file = 'log.txt';
					// $data =json_encode($data)."\n";
					// file_put_contents($file, $data, FILE_APPEND | LOCK_EX);
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
				// case "whatsapp_message":
				// 	//get whatsapp message
				// 	$number_id = $_REQUEST["value"]["metadata"]["phone_number_id"];
				// 	$message = $_REQUEST["messages"][0]["text"]["body"];
				// 	$message_id = $_REQUEST["messages"][0]["id"];

				// 	//get response from chatbot
				// 	$chat = new chat_bot();
				// 	$res = $chat->send_prompt($message);
				// 	$content=json_decode($res["choices"][0]["message"]['content'],true);
				// 	$type = $content["type"];

				// 	//action based response
				// switch($type){
				// 	case "enquiry":
				// 		//get the products with the name and get the availability
				// 		$product_name = $content["product_name"];
				// 		$http = new http_handler();

				// 		$res = $http->post("137.184.228.209/kiosk/api/index.php/database",array(
				// 			"action" => "search_products",
				// 			"store_id" => "be53953f6d9a979d34a265547f962448",
				// 			"product_name" => $product_name
				// 		));
				// 		$products = $res["response"]["products"];

				// 		//return a list of products
				// 		break;
				// 	case "unknown":
				// 		break;
				// 	case "catalog_request":
				// 			//get all products
				// 			//send products to user
				// 	case "order":
				// 		$product_name = $content["product_name"];
				// 		$quantity = $content["quantity"];
				// 		//get the price and let them know
				// 		break;
				// 	default:
				// 		echo "Un covered type";
				// 		echo "type: $type";
				// }

				// 	//send response
				// 	die();
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
