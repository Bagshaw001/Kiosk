<?php

/**
 * This file handles all the function that affect the 
 */
require("../../../Kiosk/api/utils/env_manager.php");
require("../../../Kiosk/api/functions/functions.php");
require("../../api/api/controllers/api_request.php");
require_once(__DIR__ . "/../../../api/utils/http_handler.php");
/**
 * This function make api calls
 */




/**
 * This function returns the url to log the user into their facebook account 
 * @return 
 * code in the redirect url
 */

function facebookLogin($appId, $appSecret, $business_id)
{
    $postBody =  array(
        "client_id" => $appId,
        "redirect_uri" => redirect_url() . "?" . "client_id=" . $appId . "&app_secret=" . $appSecret . "&business_id=" . $business_id,
        "state" => facebook_state(),
        "scope" => "email",
        "auth_type" => "rerequest",
        "response_type" => "code"
    );

    $endpoint = facebook_main_domain() . facebook_version() . "/dialog/oauth" . "?" . http_build_query($postBody);

    // $response = apiRequest($endpoint);
    // print_r($endpoint);
    return $endpoint;
}

/**
 * This function makes a request to exchange the code gotten for the access token
 * @return array  
 */

function accessToken($code, $appSecret, $appId)
{


    $postBody = array(
        "client_id" => $appId,
        "client_secret" =>  $appSecret,
        "redirect_uri" => redirect_url() . "?" . "client_id=" . $appId . "&app_secret=" . $appSecret,
        "code" => $code
    );
    $endpoint = facebook_graph_domain() . facebook_version() . "/oauth/access_token" . "?" . http_build_query($postBody);

    $response = fb_api_Request($endpoint);

    return array(
        "appId" => $appId,
        "response" => $response,
        "code" => $code
    );
}


/**
 * This function implements the login flow by callinf the other functions 
 * @return array
 */
function tryAndLoginWithFacbook($code, $appSecret, $appId, $business_id)
{

    $fb_login = accessToken($code, $appSecret, $appId);
    $business_details = get_phone_id($business_id, $fb_login["response"]["fb_response"]["access_token"]);
    $status = "fail";

    if ($fb_login["response"]["has_errors"] == TRUE || $business_details == false) {
        return array(
            "status" => $status,
            "error" => $fb_login["response"]["has_errors"] || $business_details["error"]
        );
    }
    $status = "success";
    $days = convertSecToDay($fb_login["response"]["fb_response"]["expires_in"]);
    $date = expiryTime($days);




    return array(
        "status" => $status,
        "fb_response" => $fb_login,
        "business_details" => $business_details,
        "expiry_time" => $date,
        "platform" => "whatsapp"

    );
}


/**
 * This function send the store credential to the database enpoint
 */
function store_credential($api_key, $store_id, $platform, $bearer_token, $business_id, $expiry_time)
{

    $http = new http_handler();

    //Send the data to the database
    $postBody = array(
        "api_key" => $api_key,
        "store_id" => $store_id,
        "platform" => $platform,
        "bearer_token" => $bearer_token,
        "expiry_time" => $expiry_time,
        "action" => "store_credential"

    );

    return  $http->post("localhost/kiosk/api/index.php/database", $postBody);
}

/**
 * This function get the phone id of the registered phone number
 * 
 */
function get_phone_id($business_id, $access_token)
{
    $http = new http_handler();

    $url = facebook_graph_domain() . facebook_version() . "/" . $business_id . "/phone_numbers";

    $header = array(
        "access_token" => $access_token
    );

    $response = $http->get($url, null, $header);

    if (isset($response["error"])) {
        return false;
    }

    return $response;
}

// function send_txt_msg($business_id, $msg, $access_token, $to)
// {

//     $postBody = array(
//         "messaging_product" => "whatsapp",
//         "to" => $to,
//         "type" => "template",
//         "template" => array(
//             "name" => "hello_world",
//             "language" => array("code" => "en_US")


//         )
//     );
// }

// 1188531992031899
// 089fb06e4ac84a1505168413a848a012