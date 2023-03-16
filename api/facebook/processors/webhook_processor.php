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
}
