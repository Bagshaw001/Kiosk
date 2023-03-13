<?php

require_once(__DIR__."/../../utils/core.php");
	require_once(__DIR__."/../controllers/db_controller.php");
	ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

	function payment(){
		$request = $_SERVER["REQUEST_METHOD"];

		if ($request == "POST"){
			if(!isset($_POST["action"])){
				echo " <action> required";
				die();
			}

			switch($_POST["action"]){
				case "get_banks":
					$paybox = new paybox_custom();
					$response = $paybox->get_banks();
					send_json(array("banks" => $response));
					die();
				case "get_transaction_details":
					$paybox = new paybox_custom();
					$transaction_id = $_POST["transaction_id"];
					$paybox->get_transaction($transaction_id);
					die();
				case "approve_withdrawal":
				case "request_withdrawal":
					$mode = $_POST["mode"];
					$amount = $_POST["amount"];
					$user_id = $_POST["requesting_user_id"];
					$user = get_user_by_id($user_id);
					$user_name = $user["user_name"];
					$email = $user["email"];
					$store_id = $_POST["store_id"];


					$paybox = new paybox_custom();


					if($mode == "mobile_money"){
						$number = $_POST["number"];
						$name = $_POST["name"];


					}else {
						$account_number = $_POST["account_number"];
						$bank_code = $_POST["bank_code"];

						$paybox->withdraw_bank($amount,$account_number,$bank_code,$user_name,$email,$user_id);

					}
				case "request_customer_payment":
				case "verify_payment":
					die();
				default:
					// echo "No implementation for <". $_POST["action"] .">";
					send_json(array("msg" => "No implementation for <". $_POST["action"] .">"));
					}
					die();



		}else{
			echo "unsupported method";
			die();
		}
		echo "EOF";
		die();
	}

	payment();
?>