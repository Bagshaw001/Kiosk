<?php
	require_once(__DIR__. "/http_handler.php");
	require_once(__DIR__."/env_manager.php");
	require_once(__DIR__."/chat_bot.php");

//start session
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

//for header redirection
ob_start();




	//========================== helpful functions ==========================

	function encrypt(string $string){
		return md5($string );
	}

	function shorten($string, $max_char = 256){
		return mb_strimwidth($string,0,$max_char,"...");
	}


	function get_current_date(){
		return date("Y-m-d\TH:i:s");
	}

	function format_string_as_date_fn($date_str){
		return (new DateTime($date_str))->format('d M Y');
	}

	function format_string_as_time_fn($string){
		return (new DateTime($string))->format('h:m A');
	}

	function generate_id(){
		return encrypt(get_current_date().time() . random_bytes((55)));
	}

	function upload_file($tempname,$image){
		//check if the directory exists
		// echo "image $image";
		//Then upload the file into the directory
		$temp_id = generate_id();
		$ext = explode(".",$image); //file extension
		$ext = $ext[count($ext)-1]; //file extension
		$form_name = $temp_id.'.'. $ext;
		$folder = "/var/www/html/kiosk/api/database/uploads/$form_name";

		//create folder if it does not exist
		if (!file_exists("/var/www/html/kiosk/api/database/uploads")){
			mkdir("/var/www/html/kiosk/api/database/uploads");

			// echo("Folder created");
		// 	move_uploaded_file($tempname,$folder);
		// 	return $folder;
		}
		// else{
			move_uploaded_file($tempname,$folder);
			return $folder;
		// }
		// return false;

	}


	function send_json($data, $response = 200){
		echo json_encode(array(
			"response" => $data,
			"statusCode"=> $response)
		);
	}

	function trigger_email($address,$action,$data = null){
		$http = new http_handler();
		$body =array(
			"action"=> $action,
			"email"=> $address
		);

		if($data != null){
			$body = array_merge($body,$data);
		}

		$http->post(
			""."http://localhost/kiosk/api/index.php/messenger",
			$body
		);
	}


/**
 * This function converts seconds to its equivalent in days
 */
function convertSecToDay($seconds)
{
    if ($seconds == null) {
        return false;
    }
    $dtF = new \DateTime('@0');
    $dtT = new \DateTime("@$seconds");
    return $dtF->diff($dtT)->format('%a days');
}

/**
 * This function calculates the expiry time of the token
 */
function expiryTime($days)
{
    // echo ($days);

    if ($days == false) {
        return false;
    }
    $exp_date = date('Y-m-d', strtotime('+' . $days));

    return $exp_date;
}

?>