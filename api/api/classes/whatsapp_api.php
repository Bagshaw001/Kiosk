<?php

/**
 * This file handles all the function that affect the 
 */
require(__DIR__ . "/../../../api/utils/env_manager.php");
require(__DIR__ . "/../../../api/utils/functions.php");
require_once(__DIR__ . "/../../../api/utils/http_handler.php");
require("api_request.php");
/**
 * This function make api calls
 */




/**
 * This function returns the url to log the user into their facebook account 
 * @return 
 * code in the redirect url
 */
class whats_app_api
{
    public $http;
    function __construct()
    {
        $this->http = new http_handler();
    }

    /**
     * This function return the url to the Login flow
     */
    function facebookLogin($client_id, $app_secret, $business_id)
    {
        $postBody =  array(
            "client_id" => $client_id,
            "redirect_uri" => redirect_url() . "?" . "client_id=" . $client_id . "&app_secret=" . $app_secret . "&business_id=" . $business_id,
            "state" => facebook_state(),
            "scope" => "email",
            "auth_type" => "rerequest",
            "response_type" => "code"
        );

        $endpoint = facebook_main_domain() . facebook_version() . "/dialog/oauth" . "?" . http_build_query($postBody);

        return $endpoint;
    }

    /**
     * This function makes a request to exchange the code gotten for the access token
     * @return array  
     */

    function accessToken($code, $app_secret, $client_id, $business_id)
    {



        $postBody = array(
            "client_id" => $client_id,
            "client_secret" =>  $app_secret,
            "redirect_uri" => redirect_url() . "?" . "client_id=" . $client_id . "&app_secret=" . $app_secret . "&business_id=" . $business_id,
            "state" => facebook_state(),
            "code" => $code
        );

        $endpoint = facebook_graph_domain() . facebook_version() . "/oauth/access_token" . "?" . http_build_query($postBody);

        $response = fb_api_Request($endpoint);



        // print_r($response);
        //Check for error

        if (isset($response['response']['error'])) {
            return false;
        }

        return array(
            "appId" => $client_id,
            "response" => $response,
            "code" => $code
        );
    }


    /**
     * This function implements the login flow by callinf the other functions 
     * @return array
     */
    function tryAndLoginWithFacbook($code, $app_secret, $client_id, $business_id)
    {

        $login = $this->accessToken($code, $app_secret, $client_id, $business_id);
        // $business_details = get_phone_id($business_id, $login["response"]["fb_response"]["access_token"]);
        //We need to get the business infomation 
        if ($login == false) {
            return false;
        }

        //Converts the secs to days
        $days = convertSecToDay($login["response"]["response"]["expires_in"]);
        $date = expiryTime($days);

        return array(
            "status" => "success",
            "response" => $login,
            // "business_details" => $business_details,
            "expiry_time" => $date,
            "platform" => "whatsapp"

        );
    }


    /**
     * This function send the store credential to the database endpoint
     */
    function store_credential($api_key, $store_id, $platform, $bearer_token, $business_id = null, $expiry_time = null)
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

        return  $this->http->post("localhost/kiosk/api/index.php/database", $postBody);
    }



    // 1188531992031899
    // 089fb06e4ac84a1505168413a848a012

}
