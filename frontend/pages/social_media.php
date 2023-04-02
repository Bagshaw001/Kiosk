

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
?>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Kiosk - Social Media Post</title>
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

<h3>Kiosk - Social media post upload</h3>


		<form method='post' action='./proc.php' enctype='multipart/form-data'>
	<label for="">Images To Post</label>
		<input type="file" name="images" alt="" multiple>


		<?php
		$user_id = $_GET["user_id"];
		echo "<input type='hidden' name='user_id' value='$user_id'>";

		?>
		<input type="hidden" name="type" value="post">


		<label for="product_name">Select Account</label>
		<select name="account">
			<option value="1">Instagram - Account Name</option>
			<option value="2">Instagram - Account Name</option>
			<option value="3">Instagram - Account Name</option>
		</select>

		<label for="product_description">Post Caption</label>
		<input type="text" name="post_caption" class="form-control">

		<label for="post_date">Date To Post</label>
		<input type="date" name="post_date" class="form-control">


		<label for="post_date">Time To Post</label>
		<input type="time" name="post_time" class="form-control">


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