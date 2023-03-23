<?php

/**
 * This file handles all the function that affect the
 */
require_once(__DIR__ . "/../../utils/core.php");
require_once(__DIR__ . "/../../utils/http_handler.php");
require(__DIR__ . "/facebook_api.php");

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
        return $this->facebook->fb_generateLoginUrl($store_id, "instagram_basic,instagram_content_publish,instagram_manage_comments,instagram_manage_insights,instagram_manage_messages,pages_manage_metadata,pages_read_engagement,", "page", "{'setup':{'channel':'IG_API_ONBOARDING' }}");
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
}
