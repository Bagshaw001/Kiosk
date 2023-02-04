<?php
require("controllers/whatsapp_api.php");
if (isset($_GET["code"])) {

    $code = $_GET["code"];
    $app_Id = $_GET["client_id"];
    $app_Secret = $_GET["app_secret"];

    $fb_login = tryAndLoginWithFacbook($code, $app_Secret, $app_Id);

    print_r($fb_login["response"]["response"]["fb_response"]["access_token"]);

    store_credential($app_Secret, $app_Id, $fb_login["platform"], $fb_login["response"]["response"]["fb_response"]["access_token"], $fb_login["expiry_time"]);
}
