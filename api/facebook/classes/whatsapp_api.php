<?php

/**
 * This file handles all the function that affect the
 */
require_once(__DIR__ . "/../../utils/core.php");


/**
 * This function make api calls
 */




class whats_app_api{
    public $http;
    function __construct()
    {
        $this->http = new http_handler();
    }





    /**
     * This function generates a url for facebook's login flow
     */
    function generateLoginUrl( $store_id){
        $postBody =  array(
            "client_id" => fb_app_id(),
            "redirect_uri" => redirect_url(),
            // "redirect_uri" => redirect_url()."?client_id=$client_id&app_secret=$app_secret&business_id=$store_id",
            "state" => $store_id,
            // "extras"=> "{'setup':{'channel':'IG_API_ONBOARDING'}}",
            "scope" => "email",
            "auth_type" => "rerequest",
            "response_type" => "code"
        );

        $endpoint = facebook_main_domain().facebook_version()."/dialog/oauth?" . http_build_query($postBody);
        return $endpoint;
    }










    /**
     * This function makes a request to exchange the code gotten for the access token
     * @return array
     */

    function accessToken($code, $store_id)
    {



        $postBody = array(
            "client_id" => fb_app_id(),
            "client_secret" =>  fb_app_secret(),
            "redirect_uri" => redirect_url(),
            "state" => $store_id,
            "code" => $code
        );

        $endpoint = facebook_graph_domain() . facebook_version() . "/oauth/access_token?" . http_build_query($postBody);
        // echo "endpoint $endpoint";
        try{

            $response =file_get_contents($endpoint);
            // echo "fb $response";
            $json = json_decode($response,true);
            return $json;
        } catch(Exception $e){
            return false;
        }
    }


    /**
     * This function implements the login flow by callinf the other functions
     * @return array
     */
    function tryAndLoginWithFacbook($code, $business_id)
    {

        $login = $this->accessToken($code, $business_id);
        //We need to get the business infomation
        if ($login == false) {
            return false;
        }

        //Converts the secs to days
        $days = convertSecToDay($login["expires_in"]);
        $date = expiryTime($days);

        //save token

        return array(
            "status" => "success",
            "data" => $login,
            // "business_details" => $business_details,
            "expiry_date" => $date,
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

        return  $this->http->post(server_base_url() . "api/index.php/database", $postBody);
    }




}
