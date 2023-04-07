<?php

require_once(__DIR__ . "/../../utils/http_handler.php");
require_once(__DIR__ . "/../../utils/env_manager.php");
/**
 * This page is used to validate the webhook
 */
$http = new http_handler();

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
    //Handles incomming messages
    // Takes raw data from the request
    $json = file_get_contents('php://input');

    // Converts it into a PHP object
    $data = json_decode($json);

    // print_r($data->entry[0]->changes[0]->value->messages[0]->text->body);
    $bus_id = $data->entry[0]->id;
    $phone_id = $data->entry[0]->changes[0]->value->metadata->phone_number_id;
    $display_number =  $data->entry[0]->changes[0]->value->metadata->phone_number_id;
    $contact_name = $data->entry[0]->changes[0]->value->contacts[0]->profile->name;
    $msg_from = $data->entry[0]->changes[0]->value->messages[0]->from;
    $timestamp = $data->entry[0]->changes[0]->value->messages[0]->timestamp;
    $msg_body = $data->entry[0]->changes[0]->value->messages[0]->text->body;
    $msg_id =  $data->entry[0]->changes[0]->value->messages[0]->text->id;








    // send the data to the database and save them
}
