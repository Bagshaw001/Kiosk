<?php

/**
 * This file handles all the function that affect the
 */
require_once(__DIR__ . "/../../utils/core.php");
require_once(__DIR__ . "/../../utils/http_handler.php");
require(__DIR__ . "/facebook_api.php");

/**
 * This function make api calls
 */




class whats_app_api
{
    public $http;
    public $facebook;
    function __construct()
    {
        $this->http = new http_handler();
        $facebook = new facebook_api();
        $this->facebook = $facebook;
    }




    /**
     * This function generates a url for facebook's login flow
     */
    function generateLoginUrl($store_id)
    {
        return $this->facebook->fb_generateLoginUrl($store_id, "business_management,whatsapp_business_management,whatsapp_business_messaging,catalog_management");
    }


    /**
     * This function makes a request to exchange the code gotten for the access token
     * @return array
     */

    function accessToken($code, $store_id)
    {
        return $this->facebook->fb_accessToken($code, $store_id);
    }


    /**
     * This function implements the login flow by callinf the other functions
     * @return array
     */
    function tryAndLoginWithFacbook($code, $business_id)
    {

        return $this->facebook->fb_tryAndLoginWithFacbook($code, $business_id, "whatsapp");
    }


    /**
     * This function send the store credential to the database endpoint
     */
    function store_credential($api_key, $store_id, $platform, $bearer_token, $business_id = null, $expiry_time = null)
    {

        //Send the data to the database
        return $this->facebook->fb_store_credential($api_key, $store_id, $platform, $bearer_token, $business_id = null, $expiry_time = null);
    }

    /**
     * This function gets the user list of phone id's
     */
    function get_phone_id($business_id, $access_token)
    {
        $header = array(
            "access_token" => $access_token,
        );
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . $business_id . "/phone_numbers";
            return $this->http->get($endpoint, null, $header);
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function checks if the webhook configuration to the phone number is set up properly
     */
    function check_subscription($business_id, $access_token)
    {
        $header = array(
            "access_token" => $access_token,
        );
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . $business_id . "/subscribed_apps";

            $response = $this->http->get($endpoint, null, $header);

            if ($response["success"] == true) {
                return true;
            }
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function  register the person phonenumber
     */
    function register_phone_number($phone_id, $access_token, $six_digit_pin)
    {
        $header = array(
            "access_token" => $access_token,
        );
        $postBody = array(
            "messaging_product" => "whatsapp",
            "pin" => $six_digit_pin
        );
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . $phone_id . "/register";

            $response = $this->http->post($endpoint, $postBody, $header);

            if ($response["success"] == true) {
                return true;
            }
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function is still under review
     */
    function send_msg($phone_id, $access_token, $msg_body, $to)
    {
        $header = array(
            "access_token" => $access_token,
        );
        $postBody = array(
            "messaging_product" => "whatsapp",
            "recipient_type" => "individual",
            "to" => $to,
            "type" => "text",
            "text" => array(
                "body" => $msg_body
            )
        );
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . $phone_id . "/messages";

            $response = $this->http->post($endpoint, $postBody, $header);

            if (isset($response->messages[0]->id)) {
                //store the response of what you sent
                $postBody = array(
                    "to" => $to,
                    "msg" => $msg_body,
                    "phone_id" => $phone_id,
                    "msg_id" => $response->messages[0]->id,
                    "status" => "outgoing",
                    "type" => "send_msg",
                    "action" => "whatsapp_msg"
                );
                $endpoint = "http://localhost/api/index.php/database";
                return $this->http->post($endpoint, $postBody);
            }
        } catch (Exception $e) {
            return false;
        }
    }

    //Reply to text

    function reply_msg($phone_id, $access_token, $msg_body, $to, $prev_msg_id, $url = null)
    {
        $header = array(
            "access_token" => $access_token,
        );
        $postBody = array(
            "messaging_product" => "whatsapp",
            "recipient_type" => "individual",
            "to" => $to,
            "context" => array("message_id" => $prev_msg_id),
            "type" => "text",
            "text" => array(
                "preview_url" => $url,
                "body" => $msg_body
            )
        );
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . $phone_id . "/messages";

            $response = $this->http->post($endpoint, $postBody, $header);

            if (isset($response->messages[0]->id)) {
                //store the response of what you sent
                $postBody = array(
                    "to" => $to,
                    "msg" => $msg_body,
                    "url" => $url,
                    "phone_id" => $phone_id,
                    "msg_id" => $response->messages[0]->id,
                    "prev_msg_id" => $prev_msg_id,
                    "status" => "outgoing",
                    "type" => "reply_msg",
                    "action" => "whatsapp_msg"
                );


                $endpoint = "http://localhost/api/index.php/database";
                return $this->http->post($endpoint, $postBody);
            }
            return false;
        } catch (Exception $e) {
            return false;
        }
    }

    //send message with preview link
    function send_preview_url($phone_id, $access_token, $msg_body, $to)
    {
        $header = array(
            "access_token" => $access_token,
        );
        $postBody = array(
            "messaging_product" => "whatsapp",
            "to" => $to,
            "text" => array(
                "preview_url" => true,
                "body" => $msg_body
            )
        );
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . $phone_id . "/messages";

            $response = $this->http->post($endpoint, $postBody, $header);

            if (isset($response->messages[0]->id)) {
                //store the response of what you sent
                //store the response of what you sent
                $postBody = array(
                    "to" => $to,
                    "msg" => $msg_body,
                    "phone_id" => $phone_id,
                    "msg_id" => $response->messages[0]->id,
                    "status" => "outgoing",
                    "type" => "preview_url",
                    "action" => "whatsapp_msg"
                );
                $endpoint = "http://localhost/api/index.php/database";
                return $this->http->post($endpoint, $postBody);
            }
            return false;
        } catch (Exception $e) {
            return false;
        }
    }
}

//Verify token
