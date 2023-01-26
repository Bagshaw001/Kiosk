<?php
	if (session_status() === PHP_SESSION_NONE) {
		session_start();
	}

	define('FACEBOOK_ENDPOINT_BASE','https://graph.facebook.com/v5.0');
	
?>