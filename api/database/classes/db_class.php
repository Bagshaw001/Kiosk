<?php
	require_once(__DIR__. "/../../utils/db_connection.php");


	class db_class extends db_connection{


		//=============================INSERT======================
		function create_account($user_id,$user_name,$phone_number,$email,$password){
			$user_id = $this->clean($user_id);
			$user_name = $this->clean($user_name);
			$phone_number = $this->clean($phone_number);
			$email = $this->clean($email);
			$password = $this->clean($password);

			$sql = "INSERT INTO `users`(`user_id`, `user_name`, `email`, `phone_number`, `password`)
			VALUE ('$user_id','$user_name', '$email','$phone_number','$password');";
			return $this->db_query($sql);
		}

		function create_store($store_id, $store_name,$store_country){
			$store_id = $this->clean($store_id);
			$store_name = $this->clean($store_name);
			$store_country = $this->clean($store_country);

			$sql = "INSERT INTO `stores` (`store_id`, `store_name`, `country`)
			VALUE ('$store_id','$store_name','$store_country');";
			return $this->db_query($sql);
		}

		function create_product($product_id,$store_id,$product_name,$product_description, $quantity, $currency, $price){
			$product_id = $this->clean($product_id);
			$store_id = $this->clean($store_id);
			$product_name = $this->clean($product_name);
			$product_description = $this->clean($product_description);
			$quantity = $this->clean($quantity);
			$currency = $this->clean($currency);
			$price = $this->clean($price);

			$sql = "INSERT INTO `products`(`product_id`,`store_id`, `product_name`,`product_description`,`quantity`,`currency`,`price`)
			VALUE ('$product_id','$store_id','$product_name', '$product_description', '$quantity', '$currency', '$price')";
			return $this->db_query($sql);
		}


		function add_store_manager($user_id, $store_id){
			$user_id = $this->clean($user_id);
			$store_id = $this->clean($store_id);

			$sql = "INSERT INTO `store_managers`(`user_id`, `store_id`)
			VALUE ('$user_id','$store_id')";
			return $this->db_query($sql);
		}

		function add_store_wallet($store_id,$name,$number,$network){
			$store_id = $this->clean($store_id);
			$name = $this->clean($name);
			$number = $this->clean($number);
			$network = $this->clean($network);

			$sql = "INSERT INTO `store_wallets`
			VALUE ('$store_id','$name','$number','$network')";
			return $this->db_query($sql);
		}


		function create_manager_invite($store_id,$token){
			$store_id = $this->clean($store_id);
			$token = $this->clean($token);

			$sql = "INSERT INTO `store_manager_invite` VALUE (`store_id`, `invite_token`)
			VALUE ('$store_id', '$token')";
			return $this->db_query($sql);
		}

		function store_forgot_password_token($user_id,$token){
			$user_id = $this->clean($user_id);
			$token = $this->clean($token);
			$sql = "INSERT INTO `password_tokens` VALUE ('$user_id', '$token')";
			return $this->db_query($sql);
		}

		function record_login($user_id){
			$user_id = $this->clean($user_id);
			$sql = "INSERT INTO `login_history`(`user_id`) VALUE ('$user_id')";
			return $this->db_query($sql);
		}


		function store_credential($api_key,$store_id,$platform,$bearer_token){
			$api_key = $this->clean($api_key);
			$store_id = $this->clean($store_id);
			$platform = $this->clean($platform);
			$bearer_token = $this->clean($bearer_token);
			$sql = "INSERT INTO `social_media_credentials`
			VALUE('$api_key', '$store_id','$platform','$bearer_token')";
			return $this->db_query($sql);
		}

		function store_email_verification_token($user_id,$token){
			$user_id = $this->clean($user_id);
			$token = $this->clean($token);
			$sql = "INSERT INTO `email_verification` VALUE ('$user_id', '$token')";
			return $this->db_query($sql);
		}

		function store_phone_verification_token($user_id,$token){
			$user_id = $this->clean($user_id);
			$token = $this->clean($token);
			$sql = "INSERT INTO `phone_verification` VALUE ('$user_id', '$token')";
			return $this->db_query($sql);
		}

		function add_customer($store_id,$customer_id,$customer_name,$customer_number){
			$store_id = $this->clean($store_id);
			$customer_id = $this->clean($customer_id);
			$customer_name = $this->clean($customer_name);
			$customer_number = $this->clean($customer_number);
			$sql = "INSERT INTO `customers`
			VALUE('$customer_id','$store_id','$customer_name','$customer_number')";
			return $this->db_query($sql);
		}

		function add_order($order_id,$customer_id,$product_id){
			$order_id = $this->clean($order_id);
			$customer_id = $this->clean($customer_id);
			$product_id = $this->clean($product_id);
			$sql = "INSERT INTO `orders`
			VALUE('$order_id', '$customer_id','$product_id')";
			return $this->db_query($sql);
		}


		function add_transaction($transaction_id,$currency,$amount,$date){
			$transaction_id = $this->clean($transaction_id);
			$currency = $this->clean($currency);
			$amount = $this->clean($amount);
			$date = $this->clean($date);
			$sql = "INSERT INTO `transactions`
			VALUE ('$transaction_id', '$amount','$currency','$date' )";
			return $this->db_query($sql);
		}

		function link_transaction_order($transaction_id,$order_id){
			$transaction_id = $this->clean($transaction_id);
			$order_id = $this->clean($order_id);
			$sql = "INSERT INTO `order_transactions`
			VALUE ('$transaction_id', '$order_id')";
			return $this->db_query($sql);
		}

		function add_transaction_withdrawal($transaction_id,$withdrawal_id){
			$transaction_id = $this->clean($transaction_id);
			$withdrawal_id = $this->clean($withdrawal_id);
			$sql = "INSERT INTO `withdrawal_transactions`
			VALUE ('$transaction_id', '$withdrawal_id')";
			return $this->db_query($sql);
		}

		//=============================SELECT======================

		function get_store_by_token($token){
			$token = $this->clean($token);
			$sql = "SELECT `store_id` FROM `store_manager_invite`
			WHERE `invite_token`='$token' AND `expiry_date` < CURRENT_TIMESTAMP";
			return $this->db_fetch_one($sql);
		}

		function login($email, $password){
			$email = $this->clean($email);
			$password = $this->clean($password);
			$sql = "SELECT `user_id` FROM `users` WHERE `email` = '$email' AND `password`='$password'";
			return $this->db_fetch_one($sql);
		}

		function get_user_by_email($email){
			$email = $this->clean($email);
			$sql = "SELECT * FROM `users` WHERE `email` = '$email'";
			return $this->db_fetch_one($sql);
		}

		// function get_store_available_balance($store_id){
		// 	$sql = "SELECT `account_balance` FROM `stores` WHERE `store_id`= '$store_id'";
		// 	return $this->db_fetch_one($sql);
		// }

		function get_store_by_id($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT * FROM `stores` WHERE `store_id`= '$store_id'";
			return $this->db_fetch_one($sql);
		}

		function get_user_by_id($user_id){
			$user_id = $this->clean($user_id);
			$sql = "SELECT * FROM `users` where `user_id` = '$user_id'";
			return $this->db_fetch_one($sql);
		}

		function get_user_password_token($user_id){
			$user_id = $this->clean($user_id);
			$sql = "SELECT * FROM `password_tokens` WHERE `user_id`='$user_id'";
			return $this->db_fetch_one($sql);
		}

		function get_user_by_password_token($token){
			$token = $this->clean($token);
			$sql = "SELECT * FROM `password_tokens` WHERE `token`= '$token'";
			return $this->db_fetch_one($sql);
		}


		function get_store_credential($store_id,$platform){
			$store_id = $this->clean($store_id);
			$platform = $this->clean($platform);
			$sql = "SELECT * FROM `social_media_credentials` WHERE `store_id` = '$store_id' AND `platform`='$platform'";
			return $this->db_fetch_all($sql);
		}


		function get_store_by_user_id($user_id){
			$user_id = $this->clean($user_id);
			$sql = "SELECT `store_id` FROM `store_managers` WHERE `user_id`='$user_id'";
			return $this->db_fetch_one($sql);
		}


		function get_store_wallets($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT * FROM `store_wallets` WHERE `store_id`='$store_id'";
			return $this->db_fetch_all($sql);
		}

		function get_store_wallet_by_number($store_id,$wallet_number){
			$store_id = $this->clean($store_id);
			$wallet_number = $this->clean($wallet_number);
			$sql = "SELECT * FROM `store_wallets` WHERE `store_id`='$store_id' AND `wallet_number`='$wallet_number'";
			return $this->db_fetch_one($sql);
		}

		function get_customer_by_number($store_id,$customer_id){
			$store_id = $this->clean($store_id);
			$customer_id = $this->clean($customer_id);
			$sql = "SELECT * FROM `customers`
			WHERE `store_id`='$store_id' AND `customer_id`='$customer_id'";
			return $this->db_fetch_one($sql);
		}

		function get_email_verification_token($user_id){
			$user_id = $this->clean($user_id);
			$sql = "SELECT `token` FROM `email_verification` WHERE `user_id` = '$user_id'";
			return $this->db_fetch_one($sql);
		}

		function get_phone_verification_token($user_id){
			$user_id = $this->clean($user_id);
			$sql = "SELECT `token` FROM `phone_verification` WHERE `user_id` = '$user_id'";
			return $this->db_fetch_one($sql);
		}

		function get_user_by_email_verification_token($token){
			$token = $this->clean($token);
			$sql = "SELECT * FROM `email_verification` WHERE `token`= '$token'";
			return $this->db_fetch_one($sql);
		}

		function get_user_by_phone_verification_token($token){
			$token = $this->clean($token);
			$sql = "SELECT * FROM `phone_verification` WHERE `token`= '$token'";
			return $this->db_fetch_one($sql);
		}

		function get_products($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT * FROM products where `store_id` = '$store_id'";
			return $this->db_fetch_all($sql);
		}


		function get_order_count($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT count(orders.order_id) AS order_count FROM `orders`
			JOIN products on products.product_id = orders.product_id
			JOIN stores on stores.store_id = products.store_id
			WHERE stores.store_id = '$store_id'";
			return $this->db_fetch_one($sql);
		}

		function get_revenue($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT sum(transactions.amount) as revenue FROM order_transactions
			JOIN orders on orders.order_id = order_transactions.order_id
			JOIN products on products.product_id = orders.product_id
			JOIN transactions on transactions.transaction_id = order_transactions.transaction_id
			WHERE products.store_id = '$store_id'";
			return $this->db_fetch_one($sql);
		}

		function get_customer_count($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT count(`customer_id`) AS customer_count FROM `customers`
			WHERE `store_id` = '$store_id'";
			return $this->db_fetch_one($sql);
		}

		function get_product_count($store_id){
			$store_id = $this->clean($store_id);
			$sql = "SELECT count(product_id) AS product_count FROM  products
			WHERE `store_id` = '$store_id'";
			return $this->db_fetch_one($sql);
		}

		//================================UPDATE ===============================================
		function reset_user_password($user_id,$new_p){
			$user_id = $this->clean($user_id);
			$new_p = $this->clean($new_p);
			$sql = "UPDATE `users` SET `password`='$new_p' WHERE `user_id` = '$user_id'";
			return $this->db_query($sql);
		}

		function update_email_verification($user_id, $verified = true){
			$user_id = $this->clean($user_id);
			$val = $verified ? 1 : 0;
			$sql = "UPDATE `users` SET `email_verified` = $val WHERE `user_id`='$user_id'";
			return $this->db_query($sql);
		}


		function update_phone_verification($user_id, $verified = true){
			$user_id = $this->clean($user_id);
			$val = $verified ? 1 : 0;
			$sql = "UPDATE `users` SET `number_verified` = $val WHERE `user_id`='$user_id'";
			return $this->db_query($sql);
		}

		function update_product($product_id,$product_name,$product_description, $quantity, $currency, $price){
			$price = $this->clean($price);
			$product_name = $this->clean($product_name);
			$product_description = $this->clean($product_description);
			$quantity = $this->clean($quantity);
			$currency = $this->clean($currency);
			$product_id = $this->clean($product_id);

			$sql = "UPDATE `products` SET
			`product_name`='$product_name', `product_description` = '$product_description',
			`quantity` = '$quantity', `currency` = '$currency',
			`price`='$price'
			 WHERE `product_id` = '$product_id'";
			//  echo $sql;
			 return $this->db_query($sql);
		}


		//=============================DELETE======================

		function remove_expired_invites(){
			$sql = "DELETE FROM `store_manager_invite` WHERE `expiry_date` > CURRENT_TIMESTAMP";
			return $this->db_query($sql);
		}


		function remove_email_token($user_id, $token){
			$token = $this->clean($token);
			$user_id = $this->clean($user_id);
			$sql = "DELETE FROM `email_verification` WHERE `user_id` = '$user_id' AND `token` = '$token'";
			return $this->db_query($sql);
		}

		function remove_phone_token($user_id, $token){
			$user_id = $this->clean($user_id);
			$token = $this->clean($token);
			$sql = "DELETE FROM `phone_verification` WHERE `user_id` = '$user_id' AND `token` = '$token'";
			return $this->db_query($sql);
		}


		function remove_password_token($token, $user_id){
			$token = $this->clean($token);
			$user_id = $this->clean($user_id);
			$sql = "DELETE FROM `password_tokens` WHERE `user_id`='$user_id' AND `token`='$token'";
			return $this->db_query($sql);
		}

	}
?>