<?php

require_once(__DIR__."/../../utils/core.php");
require_once(__DIR__."/../classes/whatsapp_api.php");
require_once(__DIR__."/../../database/controllers/db_controller.php");
	ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
header("Access-Control-Allow-Origin: * ");
header("Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS");
function facebook()
{
	$request = $_SERVER["REQUEST_METHOD"];

		if ($request == "POST"){
			if(!isset($_POST["action"])){
				echo " <action> required";
				die();
			}

			switch($_POST["action"]){
				case "create_account":
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