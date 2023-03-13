<?php
require("classes/whatsapp_api.php");

/**
 * This page 
 */
if (isset($_GET["code"])) {

    $code = $_GET["code"];
    $app_Id = $_GET["client_id"];
    $app_Secret = $_GET["app_secret"];
    $business_id = $_GET["business_id"];

    $whatsapp = new whats_app_api();

    $login = $whatsapp->tryAndLoginWithFacbook($code, $app_Secret, $app_Id, $business_id);

    if ($login == false) {
        return false;
    }

    // print_r($login["response"]["response"]["response"]["access_token"]);
    $whatsapp->store_credential($app_Secret, $app_Id, $login["platform"], $login["response"]["response"]["response"]["access_token"], $business_id, $login["expiry_time"]);

    //Redirrect back to the Account link screen

    //Subscribe to your WABA


    //Gett the business information

    //Register the phonenumber id
} elseif (isset($_GET["error_code"]) || isset($_GET["error"])) {
    //Direct them to an error page displaying the error code
}
