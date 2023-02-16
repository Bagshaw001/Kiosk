<?php
require("controllers/whatsapp_api.php");

/**
 * This page 
 */
if (isset($_GET["code"])) {

    $code = $_GET["code"];
    $app_Id = $_GET["client_id"];
    $app_Secret = $_GET["app_secret"];
    $business_id = $_GET["business_id"];

    $login =  tryAndLoginWithFacbook($code, $app_Secret, $app_Id, $business_id);

    print_r($fb_login["fb_response"]["response"]["fb_response"]["access_token"]);
    store_credential($app_Secret, $app_Id, $login["platform"], $login["fb_response"]["response"]["fb_response"]["access_token"], $login["business_details"]['data']["id"], $login["expiry_time"]);

    //Redirrect back to the Account link screen

    //Subscribe to your WABA


    //Gett the business information

    //Register the phonenumber id
} elseif (isset($_GET["error_code"]) || isset($_GET["error"])) {
    //Direct them to an error page displaying the error code
}
