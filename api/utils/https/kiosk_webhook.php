<?php
// $data =  file_get_contents("php://input");
// $data = json_decode($data, true);
// $data =json_encode($data);
// echo $data;
// die();

require_once(__DIR__."/../classes/chatbot.php");

$request = $_SERVER["REQUEST_METHOD"];
if($request == "GET"){ //Whatsapp endpoint verification
  $mode = $_REQUEST["hub_mode"];
  $challenge = $_REQUEST["hub_challenge"];
  $token = $_REQUEST["hub_verify_token"];
  http_response_code(200);
  echo $challenge;
}else { //data is being sent

// Set the URL to send the POST request to
  $data = file_get_contents("php://input");
  $data = json_decode($data, true);
  $object = $data["entry"][0]["changes"][0];
  $message = $object["value"]["messages"][0]["text"]["body"];
  // $encoded = urldecode($data);
  // $data = http_build_query($data);
  // print_r($data);


die();

// Set the headers for the request
$headers = array(
  'Content-Type: application/json',
  'Content-Length: ' . strlen($data)
);

// Send the POST request to the URL
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

// Output the response from the URL
echo $response;


}
