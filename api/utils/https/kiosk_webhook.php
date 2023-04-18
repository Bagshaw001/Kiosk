<?php
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
  // $data["action"] = "incoming_whatsapp";

  $object = $data["entry"][0]["changes"][0];
  // $message = $object["value"]["messages"][0]["text"]["body"];
  // $number = $object["value"]["metadata"]["phone_number_id"];

  $payload = array(
    "action" => "incoming_whatsapp",
    "message" => json_encode($object),
  );

// Send the POST request to the URL
$ch = curl_init("137.184.228.209/kiosk/api/index.php/messenger");
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
// curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$response = curl_exec($ch);
curl_close($ch);

// Output the response from the URL
echo $response;


}
