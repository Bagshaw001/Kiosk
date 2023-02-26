<?php

require("../utils/http_handler.php");

/**
 * This class deals with all function handling post
 */
class post
{

    public $http;

    function __construct()
    {
        $this->http = new http_handler();
    }

    function schedule_post($post_id, $time_to_post, $caption)
    {

        $post_body = array(
            "action" => "schedule_post",
            "post_id" =>     $post_id,
            "caption" => $caption,
            "time_to_post" => $time_to_post
        );
        return  $this->http->post("localhost/kiosk/api/index.php/database", $post_body);
    }

    function delete_schedule_post($post_id)
    {
        $post_body = array(
            "action" => "delete_schedule_post",
            "post_id" => $post_id

        );
        return  $this->http->post("localhost/kiosk/api/index.php/database", $post_body);
    }

    function get_schedule_post($post_id)
    {
        $post_body = array(
            "action" => "get_schedule_post",
            "post_id" => $post_id

        );
        return  $this->http->post("localhost/kiosk/api/index.php/database", $post_body);
    }
}
