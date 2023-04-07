<?php

/**
 * This file handles all the function that affect the
 */
require_once(__DIR__ . "/../../utils/core.php");
require_once(__DIR__ . "/../../utils/http_handler.php");
require("./facebook_api.php");

/**
 * This function make api calls to the instgram api
 */




class instagram_api
{
    public $http;
    public $facebook;
    function __construct()
    {
        $this->http = new http_handler();
        $facebook = new facebook_api();
        $this->facebook = $facebook;
    }

    //Check if the user has already facebook token from whatsapp
    function generateLoginUrl($store_id)
    {
        return $this->facebook->fb_generateLoginUrl($store_id, "instagram_basic,instagram_content_publish,instagram_manage_comments,instagram_manage_insights,instagram_manage_messages,pages_manage_metadata,pages_read_engagement,pages_messaging,pages_show_list", "page", "{'setup':{'channel':'IG_API_ONBOARDING' }}");
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

        return $this->facebook->fb_tryAndLoginWithFacbook($code, $business_id, "instagram");
    }

    /**
     * This function stores the credentials in the database
     */
    function store_credential($api_key, $store_id, $platform, $bearer_token, $business_id = null, $expiry_time = null)
    {
        return $this->facebook->fb_store_credential($api_key, $store_id, $platform, $bearer_token, $business_id = null, $expiry_time = null);
    }

    /**
     * This function `gets the users pages and details
     */
    function get_user_page($access_token)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/me/accounts";
            $post_body = array("access_token" => $access_token);
            return $this->http->get($endpoint, $post_body);
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function get the business account linked to the page id
     */
    function get_page_business_acct($page_id, $access_token)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $page_id;

            $post_body = array(
                "access_token" => $access_token,
                "fields" => "instagram_business_account"
            );
            return $this->http->get($endpoint, $post_body);
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function get the media id for that business
     */

    function get_account_media_id($page_id, $access_token)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $page_id . "/media";

            $post_body = array(
                "access_token" => $access_token,

            );
            return $this->http->get($endpoint, $post_body);
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function gets the page id 
     */
    function get_page_id($access_token, $user_id)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $user_id . "/accounts?access_token=" . $access_token;

            $response = $this->http->get($endpoint);
            return $response->data[0]->id;
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function gets the page access token
     */
    function get_page_access_token($page_id, $access_token)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $page_id . "?fields=access_token,access_token=" . $access_token;

            $response = $this->http->get($endpoint);
            return $response->access_token;
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function subscribe the page to the messaging
     * 
     */

    function subscribe_message($page_id, $access_token)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $page_id . "/subscribed_apps";
            $post_body = array(
                "subscribed_fields" => "messages",
                "access_token" => $access_token
            );

            $response = $this->http->post($endpoint, $post_body);

            if ($response->success = true) {
                return true;
            }

            return false;

            //code...
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function return the list of subscribe apps to that page
     */

    function check_subscribed_apps($page_id, $access_token)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $page_id . "/subscribed_apps";
            $post_body = array(
                "access_token" => $access_token
            );

            $response = $this->http->post($endpoint, $post_body);

            return $response;

            //code...
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function send text message to clients
     */

    function send_msg($page_access_token, $ig_scope_Id, $msg)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $ig_scope_Id . "/messages";

            $post_body = array(
                "recipient" => $ig_scope_Id,
                "message" => $msg,
                "access_token" => $page_access_token
            );

            return $this->http->post($endpoint, $post_body);
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function sends a reaction message to the client 
     */
    function reaction_msg($page_access_token, $ig_scope_Id, $msg, $msg_id)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $ig_scope_Id . "/messages";

            $post_body = array(
                "recipient" => $ig_scope_Id,
                "sender_action" => "react",
                "payload" => array(
                    "message_id" => $msg_id,
                    "reaction" => $msg
                ),
                "access_token" => $page_access_token
            );

            return $this->http->post($endpoint, $post_body);
        } catch (Exception $e) {
            return false;
        }
    }

    /**
     * This function unreact to a message
     */

    function unreact_msg($page_access_token, $ig_scope_Id,  $msg_id)
    {
        try {
            $endpoint = facebook_graph_domain() . facebook_version() . "/" . $ig_scope_Id . "/messages";

            $post_body = array(
                "recipient" => $ig_scope_Id,
                "sender_action" => "unreact",
                "payload" => array(
                    "message_id" => $msg_id,
                ),
                "access_token" => $page_access_token
            );

            return $this->http->post($endpoint, $post_body);
        } catch (Exception $e) {
            return false;
        }
    }
}

$test = new instagram_api;
echo ($test->generateLoginUrl("1188531992031899"));
//echo ($test-> accessToken("AQDNykIJubv2Sk_OKAhKYZT6Vmg2hE4QyDjRtlsyamY0Sliwl4O10RPIC9xrcnbJep80xwJpJcDACgw4gJgb2S31eVdKm0qo0qmZUtHLQVStwiGXSiedeutAMWnVOu5w9c70l_kYbZ_-WVOQKTfMTLqSHBLOt278Ck1fStFkqxBQCCZa3PgaMgJvWocH-vjn5mb6Tp7j7lD1pVPVGIrEf-fZB1vJaLE-MKyG4xGjQIYtLis-CN22qED9Lbqkda9YW_4WYZwKJUoc1cNn6k4g2SOFcPn4XUNls3hVNWMB1rtmvTwh-G_xx3240uBYe9ZKVnGrU7a3QuEYQDBm5tHICYVo9Hg7Sx6bFq7dkpBk6ktHNudbGucjCjBNskfApmfeTQOnk4BdMHhTBcgA6FjO_i_1", "1188531992031899"));
