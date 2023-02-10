<?php
	require_once(__DIR__."/../controllers/mailer_controller.php");
	require_once(__DIR__. "/../../utils/core.php");

	function messenger(){
		$request = $_SERVER["REQUEST_METHOD"];

		if ($request == "POST"){
			if(!isset($_POST["action"])){
				echo " <action> required";
				die();
			}
			$email = $_POST["email"];

			switch($_POST["action"]){
				case "notify_signup":
					email_signup($email);
					break;
				case "notify_2fa_change":
					$status = $_POST["status"];
					email_notify_2fa($email,$status);
					break;
				case "send_2fa_code":
					$token = $_POST["token"];
					email_2fa_code($email,$token);

					break;
				case "notify_withdrawal":
					$amount = $_POST["amount"];
					email_notify_withdrawal($email,$amount);
					break;
				case "send_forgot_password_token":
					$token = $_POST["token"];
					email_forgot_password($email,$token);
					break;
				case "notify_password_change":
					email_notify_password_change($email);
					break;
				case "send_email_verification_code":
					$token = $_POST["token"];
					email_verify($email,$token);
					break;
				default:
					echo "No implementation for <". $_POST["action"] .">";
					}


			send_json(array("msg" => "email sent"));
			die();
		}else{
			echo "unsupported method";
			die();
		}
		echo "EOF";
		die();
	}

	messenger();
	//send sms


?>