<?php
	require_once(__DIR__. "/../classes/mailer.php");



	//send sign up email
	function email_signup($destination){
		$mail = new mailer_class();
		$mail->send_email_cls($destination,
		"Welcome to Kiosk","You have created an account on kiosk");
	}
	//sign forgot password link
	function email_forgot_password($destination, $token){
		$mail = new mailer_class();
		$mail->send_email_cls($destination, "You requested a password change",
		"You have requested a password reset. Kindly click on this link $token"
		);
	}
	// notify of changed password
	function email_notify_password_change($destination){
		$mail = new mailer_class();
		$mail->send_email_cls($destination, "Your password has been changed",
		"You have successfull changed your password"
		);
	}
	// verify email
	function email_verify($destination, $verification_token){
		$mail = new mailer_class();
		$mail->send_email_cls($destination, "Kiosk email verification",
		"Use this token to verify your email $verification_token"
		);
	}
	// notify of withdrawal
	function email_notify_withdrawal($destination, $amount){
		$mail = new mailer_class();
		$mail->send_email_cls($destination, "Withdrawal from your kiosk account request",
		"You have made a request to withdraw GHC $amount"
	);

	}
	// send 2fa code
	function email_notify_2fa($destination, $enabled = true){
		$mail = new mailer_class();
		$mail->send_email_cls($destination,
		"Two factor authentication settings changed",
		$enabled ? "You have enabled two factor authentication on your account"
		:"You have disabled two factor authentication on your account ",
		);
	}
	// send 2fa verification
	function email_2fa_code($destination, $code){
		$mail = new mailer_class();
		$mail->send_email_cls($destination,
		"Your Kiosk 2fa code","$code");
	}

?>