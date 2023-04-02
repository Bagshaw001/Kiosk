

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
?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Kiosk - Product upload</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>

<body>

	<style>
		body{
			padding: 1em;
		}
		form > input{
			display: block;
			margin-bottom: 1em;
			border-radius: 3px;
		}
		button {
			margin: 1em;

		}

		.row{
			width: 60%;
		}


	</style>

<h3>Kiosk - Product upload</h3>


		<form method='post' action='./proc.php' enctype='multipart/form-data'>
	<label for="">File upload</label>
		<input type="file" name="images" alt="">


		<?php
		$user_id = $_GET["user_id"];
		echo "<input type='hidden' name='user_id' value='$user_id'>";

		?>
		<label for="product_name">Product Name</label>
		<input type="text" name="product_name">

		<label for="product_description">Product Description</label>
		<input type="text" name="product_description">
		<input type="hidden" name="type" value="product">

		<div class="row">

			<div class="col">
				<label for="price">Price</label>
				<input type="text" name="price">
			</div>

			<div class="col">

				<label for="quantity">Quantity</label>
				<input type="text" name="quantity">
			</div>


		</div>
		<button class="btn btn-primary" type="submit">Submit</button>
	</form>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script>
		function product_upload(upload,type){
			event.preventDefault();
			alert(upload.images);
			if(type == "new"){
				//new product upload
			}else {
				//edit product upload
			}

			return false;

		}
	</script>

</body>

</html>