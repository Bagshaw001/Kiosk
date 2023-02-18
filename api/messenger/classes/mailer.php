<?php

include_once (__DIR__. "/../PHPMailer/PHPMailer.php");
include_once (__DIR__. "/../PHPMailer/SMTP.php");
include_once (__DIR__. "/../PHPMailer/POP3.php");
include_once (__DIR__. "/../PHPMailer/OAuth.php");
require_once(__DIR__."/../../utils/env_manager.php");


use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;


class mailer_class{


	function send_email_cls($destination, $subject, $message){
		if (!is_env_remote()){
			return null;
		}

		$mail = new PHPMailer(true);
		$mail->IsSMTP();
		$mail->isHTML(true);
		$mail->SMTPDebug = 0;
		$mail->SMTPAuth = true;
		$mail->SMTPSecure = "ssl";
		$mail->Host = "smtp.gmail.com";
		$mail->Port = '465';
		$mail->AddAddress($destination);
		$mail->Username =email_username();
		$mail->Password =email_password();
		$mail->SetFrom(email_username(),'easyGo Ghana');
		$mail->AddReplyTo(email_username(),"easyGo Ghana");
		$mail->Subject = $subject;
		$mail->Body = $message;
		$mail->AltBody = $message;
		return $mail->Send();

	}

	/**Frozen implementation: Don't use */
	// function send_email_2cls($destination, $subject, $message){

	// 	// To send HTML mail, the Content-type header must be set
	// 	$headers[] = 'MIME-Version: 1.0';
	// 	$headers[] = 'Content-type: text/html; charset=iso-8859-1';

	// 	// Additional headers
	// 	// $headers[] = 'To: kwekuappiah11@gmail.com, kwekuaacquaye@gmail.com';
	// 	$headers[] = "To: $destination";
	// 	$headers[] = 'From: easyGo <'.email_username().'>';
	// 	// $headers[] = 'Cc: birthdayarchive@example.com';
	// 	// $headers[] = 'Bcc: birthdaycheck@example.com';

	// 	// Mail it
	// 	// return mail($destination, $subject, $message, implode("\r\n", $headers));
	// }



	
}
