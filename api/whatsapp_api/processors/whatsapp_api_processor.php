<?php
require("../controllers/whatsapp_api.php");
require("../../whatsapp_api/redirect_url.php");

$app_Id = $_GET["app_id"];
$app_Secret = $_GET["app_secret"];



print_r(facebookLogin($app_Id, $app_Secret));
