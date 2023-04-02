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
    private $base_url;

    function __construct()
    {
        $this->http = new http_handler();
        $this->base_url = facebook_graph_domain(). facebook_version();
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

    /**Retrives from facebook the id for the phone number linked with the store's account */
    function get_phone_number_id(){
        return "105467232450445";
    }

    function get_linked_numbers($account_id,$token){
        return $this->http->get($this->base_url."/$account_id/phone_numbers?access_token=$token");
    }

    function get_one_linked_number($phone_id){
        return $this->http->get($this->base_url."/$phone_id");
    }






    /**Sends a pre-approved message template to the [number] */
    function send_message_template($number,$token){

        $body =
        "{ 'messaging_product': 'whatsapp', 'to': '$number', 'type': 'template', 'template': { 'name': 'hello_world', 'language': { 'code': 'en_US' } } }"       ;
        $header = array(
            "Authorization: Bearer $token",
            'Content-Type: application/json'
        );
        $phone_id = $this->get_phone_number_id();
        // echo facebook_graph_domain(). facebook_version(). "/$phone_id/messages";

        // return $this->http->post("https://graph.facebook.com/v15.0/105467232450445/messages",$body,$header);
        return $this->http->post($this->base_url. "/$phone_id/messages",$body,$header);

    }


    /**Sends a dynamic message to a customer within the conversation period
     * The customer must initiate the conversation however for this to work, i.e text the
     * linked account first, or respond to a previously sent template message to initiate the
     * conversation period
     */
    function send_message_custom($message,$number,$token, $contains_url = false){
        $preview_url = $contains_url ? "true" : "false";

        $header = array(
            "Authorization: Bearer $token",
            'Content-Type: application/json'
        );
        $body = "{ 'messaging_product': 'whatsapp', 'recipient_type': 'individual', 'to': '$number', 'type': 'text', 'text': {   'preview_url': $preview_url, 'body': '$message' } }";
        // echo $body;

        $phone_id = $this->get_phone_number_id();
        return $this->http->post($this->base_url. "/$phone_id/messages", $body,$header);

    }


    function send_message_media($number,$link,$token){
        $header = array(
            "Authorization: Bearer $token",
            'Content-Type: application/json'
        );
        $body = "{ 'messaging_product': 'whatsapp', 'recipient_type': 'individual', 'to': '$number', 'type': 'image', 'image': { 'link' : '$link' } }";
        $phone_id = $this->get_phone_number_id();

        return $this->http->post($this->base_url. "/$phone_id/messages",$body,$header);
    }


    function upload_fb_media($phone_id, $media_path, $token){
        // Set the POST data
        $post_data = array(
            'file' => new CURLFile($media_path),
            'type' => 'image/jpeg',
            'messaging_product' => 'whatsapp'
        );

        // Initialize the cURL session
        $curl = curl_init($this->base_url."/$phone_id/media");

        // Set the cURL options
        curl_setopt($curl, CURLOPT_POST, true);
        curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($curl, CURLOPT_HTTPHEADER, array(
            "Authorization: Bearer $token"
        ));

        // Execute the cURL session
        $response = curl_exec($curl);

        // Close the cURL session
        curl_close($curl);
        return $response;
    }



}
