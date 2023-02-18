<?php
	require_once(__DIR__."/../../api/database/controllers/db_controller.php");
	$token = $_GET["token"];

	if (!$token){
		echo "You need a password reset token to access this page";
		die();
	}else {
		$user_id = get_user_by_password_token($token);
		if (!$user_id){
			echo "You password token may have expired. Request another one from the login terminal";
			die();
		}

	}
?>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Kiosk - Password Reset</title>

</head>
<body>

	<form method="post" onsubmit="return on_reset(this)">
		<label for="">New password</label>
		<input type="password" name="password"><br>
		<span id="pass_error" style="display:none;">Your passwords do not match</span><br>


		<label for="">Confirm password</label>
		<input type="password" name="confirm_password">
		<span id="c_pass_error"style="display:none;">Your passwords do not match</span>
		<br>

		<button type="submit">Reset Password</button>
	</form>


	<script>



//Make http requests with paraterms type(POST/GET), endpoint,payload and onload function
function send_request(type, payload,  onload){
	var xhr = new XMLHttpRequest();
	// Open the connection
	xhr.open(type, "http://137.184.228.209/kiosk/api/index.php/database");
	// Set up a handler for when the task for the request is complete
	xhr.onload =  function () {
		if (xhr.readyState == XMLHttpRequest.DONE) {
			if (onload != null){
				onload(xhr.response);
			}
		 }
	 };
	 xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

	 // Send the data.
		xhr.send(payload);
}

function url_params(key){
	url = window.location.search.substr(1);
	params = url.split("&");
	params.forEach(element => {
		pair = element.split("=");
		element_key = pair[0];
		if(element_key= key){
			value = pair[1];
		}
	});

	return value;
}


		function on_reset(form){
			event.preventDefault();

			var password = form.password.value;
			var c_password = form.confirm_password.value;
			var error = document.getElementById("pass_error");
			var c_error = document.getElementById("c_pass_error");

			if (password != c_password){
					error.style = "display:block";
					c_error.style = "display:block";

				return false;
			}else {
					error.style = "display:none";
					c_error.style = "display:none";
			}

			var token = url_params("token");

			var payload ="action=reset_password" +"&password=" + password +"&token=" + token;

			send_request("POST",payload, (response)=> {
				alert(response);
			});
		}


	</script>

</body>
</html>