<?php

require("../utils/http_handler.php");
require("../utils/env_manager.php");

/**
 * This class handles all the clients withdrawal request
 */
class client_withdraw
{
    public $http;
    function __construct()
    {

        $this->http = new http_handler();
    }



    //This function process the withdrawal for both mobile money and card

    function withdraw($currency, $amount, $mobile_network = null, $mobile_number = null, $mode, $bank_code = null, $bank_account = null)
    {

        $url = "https://paybox.com.co/transfer";

        $header = array(
            "Authorization" => "Bearer " . paybox_token()
        );

        if (strtolower($mode) == "mobile money") {


            $post_body = array(
                'currency' => $currency, 'amount' => $amount, 'mode' => $mode, 'mobile_network' => $mobile_network, 'mobile_number' => $mobile_number
            );

            $http_req = json_decode($this->http->post($url, $post_body, $header));

            if ($http_req["status"] == "Success") {
                // Make the http request to the database to store the transaction data
                return true;
            }

            return false;
        } elseif (strtolower($mode) == "card") {

            $post_body = array(
                'currency' => $currency, 'amount' => $amount, 'mode' => $mode, 'bank_code' => $bank_code, 'bank_account' => $bank_account
            );

            $http_req = json_decode($this->http->post($url, $post_body, $header));

            if ($http_req["status"] == "Success") {
                // Make the http request to the database to store the transaction data
                return true;
            }

            return false;
        }
    }
}
