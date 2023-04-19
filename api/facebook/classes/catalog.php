<?php

/**
 * This file handles all the function that affect the
 */

require_once(__DIR__ . "/../../utils/http_handler.php");


/**
 * This function make api App script to update the google sheet
 */




class catalog
{

    public $http;

    function __construct()
    {
        $http = new http_handler();
        $this->http = $http;
    }

    function upload_product(
        $prod_id,
        $prod_title,
        $prod_description,
        $availbility,
        $prod_condition,
        $prod_price,
        $prod_link,
        $image_link,
        $prod_brand,
        $quantity_to_sell_on_facebook,
        $sale_price_effective_date,
        $google_product_category = null,
        $fb_product_category = null,
        $sale_price = null,
        $item_group_id = null,
        $prod_gender = null,
        $prod_color = null,
        $prod_size = null,
        $age_group = null,
        $prod_material = null,
        $prod_pattern = null,
        $prod_shipping = null,
        $prod_shipping_weight = null

    ) {;
        $endpoint = "https://script.google.com/macros/s/AKfycbwKtgmHAA4CDmbQ9eeykFNNefH75YaAsob2uMw_Y33PXcWVPfVauqJSfe1zwYm6Di5xwA/exec";

        $post_body = array(
            "id" => $prod_id,
            "title" => $prod_title,
            "description" => $prod_description,
            "availability" => $availbility, //pass an enumerator as the value
            "condition" => $prod_condition,
            "price" => $prod_price,
            "link" => $prod_link,
            "image_link" => $image_link,
            "brand" => $prod_brand,
            "google_product_category" => $google_product_category,
            "fb_product_category" => $fb_product_category,
            "quantity_to_sell_on_facebook" => $quantity_to_sell_on_facebook,
            "sale_price" => $sale_price,
            "sale_price_effective_date" => $sale_price_effective_date,
            "item_group_id" => $item_group_id,
            "gender" => $prod_gender,
            "color" => $prod_color,
            "size" => $prod_size,
            "age_group" => $age_group,
            "material" => $prod_material,
            "pattern" => $prod_pattern,
            "shipping" => $prod_shipping,
            "shipping_weight" => $prod_shipping_weight
        );

        $response = $this->http->post($endpoint, $post_body);

        if ($response == "Success") {

            return true;
        }
        return false;
    }
}

// echo ("Test");
// $test = new catalog();
// echo ($test->upload_product("Test123", "phone", "new phone", "in stock", "new", "14 USD", "https://www.facebook.com/facebook_t_shirt", "https://www.facebook.com/facebook_t_shirt", "NIKE", "10", ""));
