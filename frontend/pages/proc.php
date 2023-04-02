
<?php

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


$submitted_code = $_GET["code"];
$generated_code = $submitted_code;
//get code
// verify that code is the same
if ($submitted_code != $generated_code){
	echo "Authentication Error";
	die();
}
//if form submit go to previous page
if (isset($_POST["product_name"]) && isset($_POST["product_description"])){

	require_once(__DIR__."/../../api/utils/core.php");
	require_once(__DIR__."/../../api/database/controllers/db_controller.php");


	$files = $_FILES;
	$name = $_POST["product_name"];
	$desc = $_POST["product_description"];
	$price = $_POST["price"];
	$qty = $_POST["quantity"];
	$images = $_FILES["images"];
	$user_id = $_GET["user_id"];
	var_dump($images);
	var_dump($_POST);
	var_dump($_FILES);
	$store_id = get_store_by_user_id($user_id)["store_id"];
	$date = get_current_date();
	foreach ($images as $current) {
		$media_id = generate_id();
		$location = upload_file(__DIR__."/../../api/database","uploads",$current["tmp_name"],$current["name"]);
		echo "$location \n";
		add_product_image($media_id,$product_id,$user_id,$location,$date);
	}

	if(isset($_GET["product_id"])){
		$product_id = $_GET["product_id"];
		update_product($product_id,$store_id,$name,$desc,$qty,"GHS",$price);
	}else {
		$product_id = generate_id();
		create_product($product_id,$store_id,$name,$desc,$qty,"GHS",$price);
		//upload and save image

		//for each file, upload and save
	}
	// header("Location:javascript://history.go(-1)");

	die();
}