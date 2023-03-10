<?php

	require_once(__DIR__."/../../utils/core.php");
	require_once(__DIR__."/../controllers/db_controller.php");

	function database(){
		$request = $_SERVER["REQUEST_METHOD"];

		if ($request == "POST"){
			if(!isset($_POST["action"])){
				echo " <action> required";
				die();
			}

			switch($_POST["action"]){
				case "create_account":
					$user_name = $_POST["user_name"];
					$phone_number = $_POST["phone_number"];
					$email = $_POST["email"];
					$password = encrypt($_POST["password"]);
					$store_name = $_POST["store_name"];
					$store_country = $_POST["store_country"];
					$user_id = generate_id();
					$store_id = generate_id();

					$success = create_account($user_id,$user_name,$phone_number,$email,$password);
					if ($success){
						$success = create_store($store_id,$store_name,$store_country);
						if ($success){
							$success = add_store_manager($user_id,$store_id);
						}else {
							$msg = "Failed to create a store";
						}
					} else {
						$msg = "Failed to create your user account";
					}

					if ($success){
						send_json(array(
							"msg" => "account created successfully",
							"data" => array("user_id"=> $user_id, "store_id"=> $store_id)
						));
					}else {
						send_json(array(
							"msg" => $msg
						),100);
					}

					die();
				case "accept_manager_invite":
					$user_name = $_POST["user_name"];
					$phone_number = $_POST["phone_number"];
					$email = $_POST["email"];
					$password = encrypt($_POST["password"]);
					$token = $_POST["token"];
					$user_id = generate_id();
					$store_id =get_store_by_token($token);

					$success = create_account($user_id,$user_name,$phone_number,$email,$password);
					$success = add_store_manager($user_id,$store_id);

					if($success){
						send_json(array("msg"=> "Collaborator added successfully"));
					}else {
						send_json(array("msg"=> "Failed to add collaborator"),100);
					}
					die();
				case "invite_manager":
					$store_id = $_POST["store_id"];
					$token = generate_id();

					remove_expired_invites();

					$success = create_manager_invite($store_id,$token);

					if ($success){
						send_json(array(
							"msg"=> "Invite token generated",
							"data" => array(
								"token" => $token
							)
							));

					}else {
						send_json(array(
							"msg" => "Failed to generate invite token. Try again"
						),100);
					}
					die();

				case "login":
					$email = $_POST["email"];
					$password = encrypt($_POST["password"]);

					$user_id = login($email, $password);

					if ($user_id){
						// TODO:: Add two factor authentication
						// steps - add column to user table to indicate subscription to 2fa
						// 	- if 2fa is enabled, generate a token and send to user
						// 	- Send response indicating 2fa redirect link
						// - link returns login results if 2fa link is the same
						record_login($user_id);
						$store_id = get_user_store_id($user_id);
						send_json(array(
							"msg" => "Login successful",
							"data" => array(
								"user_id" => $user_id,
								"store_id" =>$store_id ? $store_id : null
								)
						));
					}else {
						send_json(array("msg" => "The email and password combination is wrong"),100);
					}
					die();
				case "generate_forgot_password_token":
					$email = $_POST["email"];
					$user = get_user_by_email($email);
					if ($user){
						$user_id= $user["user_id"];

						//Return existing password token for user else generate a new one
						$token = get_user_password_token($user_id);
						if ($token){

						}else {
							$token = generate_id();
							store_forgot_password_token($user_id,$token);
						}


						//TODO:: Send email with link to token
						send_json(array("msg"=> "Check your email for a link to reset your password"));

					}else {
						send_json(array(
							"msg" => "No user exists with the provided email"
						),100);
					}
					die();
				case "reset_password":
					$token = $_POST["token"];
					$new_p = encrypt($_POST["password"]);

					$user_id = get_user_by_password_token($token);
					if ($user_id){

						reset_user_password($user_id,$new_p);
						remove_password_token($token,$user_id);

						send_json(array("msg" => "Successfully change password"));
					}else {
						send_json(array("msg" => "The token does not exist. Kindly request for a new one"),100);
					}
					die();
				case "subscribe_2fa": //TODO implement after adding 2fa column to users; Change login process
					$user_id = $_POST["user_id"];

					die();
				case "upload_product":
					$product_name = $_POST["product_name"];
					$product_description = $_POST["product_description"];
					$store_id = $_POST["store_id"];
					$variations = $_POST["product_variations"];
					$product_id = generate_id();

					$var_results = array();


					$success = create_product($product_id, $store_id,$product_name,$product_description);

					foreach ($variations as $index => $value) {
						$variation_id = generate_id();
						$p_success = add_product_variation($product_id,$variation_id,$value["price"],$value["currency"]);
						$var_results = array_merge($var_results, array($variation_id => $p_success ? "Success" : "Failed"));
					}

					send_json(array("product_id" => $product_id, "variations" => $var_results));

					die();
				case "add_product_variation":
					$currency = $_POST["currency"];
					$price = $_POST["price"];
					$details = $_POST["details_json"];
					$product_id = $_POST["product_id"];
					$variation_id = generate_id();

					$success = add_product_variation($product_id,$variation_id,$price,$currency);

					if ($success){
						send_json(array("msg" => "Variation added"));
					}else{
						send_json(array("msg" => "Something went wrong"),100);
					}
					die();
				case "store_credential":
					$api_key = $_POST["api_key"];
					$store_id = $_POST["store_id"];
					$platform = $_POST["platform"];
					$bearer_token = $_POST["bearer_token"];

					$success = store_credential($api_key,$store_id,$platform,$bearer_token);
					if ($success){
						send_json(array("msg"=> "Success"));
					}else {
						send_json(array("msg" => "The credential might already exist. Try again"),100);
					}
					die();
				case "get_social_media_key":
					$store = $_POST["store_id"];
					$platform = $_POST["platform"];

					$success= get_store_credential($store,$platform);
					if ($success){
						send_json(
							array(
								"api_key" => $success["api_key"],
								"token" => $success["bearer_token"]
							)
						);
					}else {
						send_json(array("msg" => "We don't have access to your $platform account"),100);
					}

					die();
				case "add_store_wallet":
					$name = $_POST["wallet_name"];
					$number = $_POST["wallet_number"];
					$network = $_POST["network"];
					$store_id = $_POST["store_id"];

					$success = add_store_wallet($store_id,$name,$number,$network);

					if($success){
						send_json(array("msg" => "Successfully added wallet"));
					}else {
						send_json(array("msg"=> "You may already have a wallet linked to your store"),100);
					}
					die();
				case "get_store_wallets":
					$store_id = $_POST["store_id"];

					$wallets = get_store_wallets($store_id);

					send_json(array("wallets" => $wallets));
				case "add_order_transaction":
					$order_id = generate_id();
					$variation = $_POST["variation_id"];
					$transaction_id = $_POST["transaction_id"];
					$amount = $_POST["transaction_amount"];
					$currency = $_POST["transaction_currency"];
					$transaction_date = $_POST["transaction_date"];
					$customer_number = $_POST["customer_number"];
					$customer_name = $_POST["customer_name"];

					//check if customer exists, else add them and get customer_id
					$customer_id = get_customer_by_number($store_id,$customer_number);
					if(! $customer_id){
						$customer_id = generate_id();
						add_customer($store_id,$customer_id,$customer_name,$customer_number);
					}

					//add order
					add_order($order_id,$customer_id,$variation);
					//Add and link transaction
					add_transaction($transaction_id,$currency,$amount,$transaction_date);
					link_transaction_order($order_id,$transaction_id);
					die();

				case "process_withdrawal":
					$manager_id = $_POST["user_id"];
					$amount = $_POST["amount"];
					$currency = $_POST["currency"];
					$store_id = $_POST["store_id"];
					$wallet_number = $_POST["wallet_number"];
					$date = $_POST["date"];

					//check if user is a collaborator for the store
					if(is_user_a_collaborator($store_id, $manager_id)){
						//if yes; check if wallet number exits for the store
						$is_wallet = confirm_store_wallet($store_id, $wallet_number);
						if($is_wallet){
							//if yes; check store has enough to withdraw
							$enough_balance = get_store_available_balance($store_id) >= $amount;
							if($enough_balance){
								$transaction_id = generate_id();

								add_transaction($transaction_id,$currency,$amount,$date);
								add_transaction_withdrawal($transaction_id,$wallet_number);
								send_json(array("msg"=> "Request processed"));
							}else {

						send_json(
							array("msg"=> "Store does not have enough balance"),100);
							}
						}else {

						send_json(
							array("msg"=> "Store does not have a wallet with matching details"),100);
						}
					}else {
						send_json(
							array("msg"=> "User is not a collaborator for the store"),100);
					}

					die();
				default:
					echo "No implementation for <". $_POST["action"] .">";
					}
					die();



		}else{
			echo "unsupported method";
			die();
		}
		echo "EOF";
		die();
	}

	database();
?>