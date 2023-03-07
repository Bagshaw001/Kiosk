<?php

//This function make the api request to facebook
function fb_api_Request($url)
{
    $cURLConnection = curl_init();

    curl_setopt($cURLConnection, CURLOPT_URL, $url);
    curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, TRUE);
    curl_setopt($cURLConnection, CURLOPT_SSL_VERIFYPEER, FALSE);

    $phoneList = curl_exec($cURLConnection);

    $jsonArrayResponse = json_decode($phoneList, true);

    // print_r($jsonArrayResponse);
    curl_close($cURLConnection);

    return array(
        "url" => $cURLConnection,
        "response" => $jsonArrayResponse
    );
}

//Request to the database

// function apiRequest($url)
// {
//     $cURLConnection = curl_init();

//     curl_setopt($cURLConnection, CURLOPT_URL, $url);
//     curl_setopt($cURLConnection, CURLOPT_RETURNTRANSFER, TRUE);
//     curl_setopt($cURLConnection, CURLOPT_SSL_VERIFYPEER, FALSE);

//     $phoneList = curl_exec($cURLConnection);

//     $jsonArrayResponse = json_decode($phoneList, true);

//     // print_r($jsonArrayResponse);
//     curl_close($cURLConnection);

//     return array(
//         "url" => $cURLConnection,
//         "response" => $jsonArrayResponse,
       
//     );
// }
