<?php

require_once(__DIR__ . "/../../utils/http_handler.php");
require_once(__DIR__ . "/../../utils/env_manager.php");
/**
 * This page is used to validate the webhook
 */


if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET["hub_challenge"])  && isset($_GET["hub_mode"])) {
        if ($_GET["hub_verify_token"] == webhook_verify_token()) {
            //send a post request with the challenge value attached

            header('Content-Type: text/plain');

            // Send the response message to the sender
            echo $_GET["hub_challenge"];
        } else {
            http_response_code(400);
        }
    } else {
        http_response_code(400);
    }
} elseif ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $http = new http_handler();
    //Handles incomming messages
    // Takes raw data from the request
    $json = file_get_contents('php://input');

    // Converts it into a PHP object
    $data = json_decode($json);

    // print_r($data->entry[0]);

    //add database function


    switch ($data) {
            // quick reply
        case isset($data->message->quick_reply):

            $sender = $data->sender->id;
            $recipient = $data->recipient->id;
            $timestamp = $data->timestamp;
            $msg = $data->message->text;
            $mid = $data->message->mid;

            $post_body =  array(
                "sender" => $sender,
                "recipient" => $recipient,
                "timestamp" => $timestamp,
                "msg" => $msg,
                "mid" => $mid,
                "type" => "quick_reply"
            );
            $endpoint = "http://localhost/api/index.php/database";

            return  $http->post($endpoint, $post_body);




            //reply to an existing message
        case isset($data->message->reply_to):
            print_r($data);
            $sender = $data->sender->id;
            $recipient = $data->recipient->id;
            $timestamp = $data->timestamp;
            $msg = $data->message->text;
            $cur_mid = $data->message->mid;
            $reply_mid = $data->message->reply_to->mid;

            $post_body =  array(
                "sender" => $sender,
                "recipient" => $recipient,
                "timestamp" => $timestamp,
                "msg" => $msg,
                "mid" => $cur_mid,
                "reply_mid" => $reply_mid,
                "type" => "reply_to"
            );

            return $http->post("http://localhost/api/index.php/database", $post_body);



            //message with only attachment
        case isset($data->messaging[0]->message):
            print_r($data);
            $sender = $data->messaging[0]->sender->id;
            $recipient = $data->messaging[0]->recipient->id;
            $timestamp = $data->messaging[0]->timestamp;
            $msg = null;
            $mid = $data->messaging[0]->message->mid;
            $att_type = $data->messaging[0]->message->attachments[0]->type;
            $att_payload = $data->messaging[0]->message->attachments[0]->payload->url;

            $post_body =  array(
                "sender" => $sender,
                "recipient" => $recipient,
                "timestamp" => $timestamp,
                "msg" => $msg,
                "mid" => $mid,
                "att_type" => $att_type,
                "att_payload" => $att_payload,
                "type" => "attachment_pnly"
            );

            return $http->post("http://localhost/api/index.php/database", $post_body);


            //message with both attachment and text attached to it
        case isset($data->object):
            // $page_id = $data->entry[0]->id;
            // $time =  $data->entry[0]->time;
            // print_r($data->entry[0]->messaging[0]->sender->id);
            $sender = $data->entry[0]->messaging[0]->sender->id;
            $recipient = $data->entry[0]->messaging[0]->recipient->id;
            $timestamp = $data->entry[0]->messaging[0]->timestamp;
            $msg = $data->entry[0]->messaging[0]->message->text;
            $mid = $data->entry[0]->messaging[0]->message->mid;
            $att_type = $data->entry[0]->messaging[0]->message->attachments[0]->type;
            $att_payload = $data->entry[0]->messaging[0]->message->attachments[0]->payload->url;
            $att_title = $data->entry[0]->messaging[0]->message->attachments[0]->payload->title;

            $post_body =  array(
                "sender" => $sender,
                "recipient" => $recipient,
                "timestamp" => $timestamp,
                "msg" => $msg,
                "mid" => $mid,
                "att_type" => $att_type,
                "att_payload" => $att_payload,
                "att_title" => $att_title,
                "type" => "attachment_only",
                "action" => "instagram_msg"
            );
            // print_r($http->post('http://localhost/api/index.php/database', $post_body));
            $endpoint = "http://localhost/api/index.php/database";

            return  print_r($http->post($endpoint, $post_body));

        default:
            send_json(array("msg" => "Component Implementation unavailable"));
    }





    // send the data to the database and save them
}
