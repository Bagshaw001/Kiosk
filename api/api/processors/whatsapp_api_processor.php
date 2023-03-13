<?php
require("../classes/whatsapp_api.php");
//This get the user input and returns the Login url which should ask for facebook
//Login
$client_id = $_GET["app_id"];
$app_secret = $_GET["app_secret"];
$business_id = $_GET["business_id"];

$test = new whats_app_api();
$test->facebookLogin($client_id, $app_secret, $business_id);
