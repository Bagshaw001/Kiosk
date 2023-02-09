<?php
	require_once(__DIR__. "/http_handler.php");
	require_once(__DIR__."/env_manager.php");

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
		return date("Y-m-d HH:mm");
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

	function upload_file($directory,$subdir,$tempname,$image){
		//check if the directory exists
		// echo "image $image";
		//Then upload the file into the directory
		$temp_id = generate_id();
		$ext = explode(".",$image); //file extension
		$ext = $ext[count($ext)-1]; //file extension
		$form_name = $temp_id.'.'. $ext;
		$folder = "../$directory/$subdir/".$form_name;

		//create folder if it does not exist
		if (!file_exists("../$directory/$subdir/")){
			mkdir("../$directory/$subdir/",0777);

			// echo("Folder created");
			move_uploaded_file($tempname,$folder);
			return $folder;
		}
		else{
			move_uploaded_file($tempname,$folder);
			return $folder;
		}
		return false;

	}


	function send_json($data, $response = 200){
		echo json_encode(array(
			"response" => $data,
			"statusCode"=> $response)
		);
	}
?>