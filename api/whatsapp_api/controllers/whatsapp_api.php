<?php

/**
 * This file handles all the function that affect the 
 */
require("../../../Kiosk/api/utils/env_manager.php");
require("../../../Kiosk/api/functions/functions.php");

/**
 * This function make api calls
 */

function fb_api_Request($url)
{
    $cURLConnection = curl_init();

    curl_setopt($cURLConnection, CURLOPT_URL, $url);
    curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($cURLConnection, CURLOPT_SSL_VERIFYPEER, FALSE);

    $phoneList = curl_exec($cURLConnection);

    $jsonArrayResponse = json_decode($phoneList, true);

    print_r($jsonArrayResponse);
    curl_close($cURLConnection);

    return array(
        "url" => $cURLConnection,
        "fb_response" => $jsonArrayResponse,
        "has_errors" => isset($jsonArrayResponse["error"]) ? TRUE : FALSE,
        "msg" => isset($jsonArrayResponse["error"])
    );
}

function apiRequest($url)
{
    $cURLConnection = curl_init();

    curl_setopt($cURLConnection, CURLOPT_URL, $url);
    curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($cURLConnection, CURLOPT_SSL_VERIFYPEER, FALSE);

    $phoneList = curl_exec($cURLConnection);

    $jsonArrayResponse = json_decode($phoneList, true);

    print_r($jsonArrayResponse);
    curl_close($cURLConnection);

    return array(
        "url" => $cURLConnection,
        "response" => $jsonArrayResponse,
        // "msg" => $jsonArrayResponse["msg"]
    );
}



/**
 * This  function tries to login the person if successful then the code is passed through the 
 * response url parameters
 */
function facebookLogin($appId, $appSecret)
{
    $postBody =  array(
        "client_id" => $appId,
        "redirect_uri" => redirect_url() . "?" . "client_id=" . $appId . "&app_secret=" . $appSecret,
        "state" => facebook_state(),
        "scope" => "email",
        "auth_type" => "rerequest",
        "response_type" => "code"
    );

    $endpoint = facebook_main_domain() . facebook_version() . "/dialog/oauth" . "?" . http_build_query($postBody);

    // $response = apiRequest($endpoint);

    return $endpoint;
}

/**
 * This function exchanges the code with access token 
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



function tryAndLoginWithFacbook($code, $appSecret, $appId)
{
    //Do the Login process and access the token from the res
    $fb_login = accessToken($code, $appSecret, $appId);
    $status = "fail";

    if ($fb_login["response"]["has_errors"] == TRUE) {
        return array(
            "status" => $status,
            "error" => $fb_login["response"]["has_errors"]
        );
    }
    $status = "success";
    $days = convertSecToDay($fb_login["response"]["fb_response"]["expires_in"]);
    $date = expiryTime($days);



    return array(
        "status" => $status,
        "response" => $fb_login,
        "expiry_time" => $date,
        "platform" => "whatsapp"

    );
}

function store_credential($api_key, $store_id, $platform, $bearer_token, $expiry_time)
{
    //Send the data to the database
    $postBody = array(
        "api_key" => $api_key,
        "store_id" => $store_id,
        "platform" => $platform,
        "bearer_token" => $bearer_token,
        "expiry_time" => $expiry_time,
        "action" => "store_credential"

    );
    $endpoint = "localhost/kiosk/index.php/database/" . "?" . http_build_query($postBody);

    $response = apiRequest($endpoint);

    print_r(
        $response
    );

    // if ($response["response"]["msg"] !== "Success") {

    //     return array(
    //         "response" => $response,
    //         "status" => "Request Failed"

    //     );
    // }

    return array(
        "response" => $response,
        "status" => "Success"
    );
}

// 1188531992031899
// 089fb06e4ac84a1505168413a848a012