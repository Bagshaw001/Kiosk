<?php

/**
 * This file handles all the function that affect the 
 */
require("../utils/env_manager.php");

/**
 * This function make api calls
 */

function apiRequest($url)
{
    $cURLConnection = curl_init();

    curl_setopt($cURLConnection, CURLOPT_URL, $url);
    curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, true);

    $phoneList = curl_exec($cURLConnection);
    curl_close($cURLConnection);

    $jsonArrayResponse = json_decode($phoneList);

    return $jsonArrayResponse;
}


/**
 * This  function tries to login the person if successful then the code is passed through the 
 * response url parameters
 */
function facebookLogin($appId)
{
    $postBody =  array(
        "client_id" => $appId,
        "redirect_url" => redirect_url(),
        "state" => facebook_state(),
        "scope" => "email",
        "auth_type" => "rerequest",
        "response_type" => "code"
    );

    $endpoint = facebook_main_domain() . facebook_version() . "/dialog/oauth" . "?" . http_build_query($postBody);

    $response = apiRequest($endpoint);

    return array(
        "appId" => $appId,
        "response" => $response
    );
}

/**
 * This function exchanges the code with access token 
 */

function accessToken($code, $appSecret, $appId)
{


    $postBody = array(
        'client_id' => $appId,
        'client_secret' =>  $appSecret,
        'redirect_uri' => redirect_url(),
        'code' => $code
    );
    $endpoint = facebook_graph_domain() . facebook_version() . "/oauth/access_token" . "?" . http_build_query($postBody);

    $response = apiRequest($endpoint);

    return array(
        "appId" => $appId,
        "response" => $response,
        "code" => $code
    );
}
