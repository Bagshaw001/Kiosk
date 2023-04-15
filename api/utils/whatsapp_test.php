<?php
require_once(__DIR__."/../facebook/classes/whatsapp_api.php");

$token = "EAAQ49qswcpsBAFsIw55Wh84U3Mb8XcvU8h45qCXvEYJ2MlZC3JnDg3hg9ZBzZBEgAlRDZAXhZBjVTDzCTQgWkJ4EUrDFsimaYuKZBg6lF9SKyYlhVXDWb9rln8K6C9R0K4pID9QvKr1q4oy7mRkZCsGZAckWNwxQc1BhfHt2SSmB3rbfgxU3ZAdp5ifpHXMQ1ZBK5UGs2uHG8ccfbqZBfZBkPwJl9xRVo7oCZCRwZD";
$number = "233559582518";
$meta = new whats_app_api();
$result = $meta->get_linked_numbers($meta->get_account_id(),$token);
var_dump($result);
die();
// $ch = curl_init();
// curl_setopt($ch, CURLOPT_URL, 'https://graph.facebook.com/v15.0/105467232450445/messages');
// curl_setopt($ch, CURLOPT_POST, 1);
// curl_setopt($ch, CURLOPT_POSTFIELDS, "{ 'messaging_product': 'whatsapp', 'to': '233559582518', 'type': 'template', 'template': { 'name': 'hello_world', 'language': { 'code': 'en_US' } } }");
// curl_setopt($ch, CURLOPT_HTTPHEADER, array(
//     "Authorization: Bearer $token",
//     // 'Authorization: Bearer EAAQ49qswcpsBAIoUZA4n53qMZCQYvB6VNdQbOG2kwe2xJudzq9qhXCIpMrk7wEwsWEMKjvNLqBeEj7xDh0cvkwW0F68u22V3PR1JCVo096bfZBZAUxrHw7wFqB1AYG8Br7hkSYrCfeNN0Tssm6blH71XySQmw9nt7B0mktiCrVNtOhgZAm1rTTuK7c3G5kHCoEZBXQemUETypNPlZAJ3oY0Bys0GSW73BYZD',
//     'Content-Type: application/json'
// ));

$result = curl_exec($ch);

curl_close($ch);

?>
