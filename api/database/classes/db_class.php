<?php
require_once(__DIR__ . "/../../utils/db_connection.php");


class db_class extends db_connection
{


	//=============================INSERT======================
	function create_account($user_id, $user_name, $phone_number, $email, $password)
	{
		$sql = "INSERT INTO `users`(`user_id`, `user_name`, `email`, `phone_number`, `password`)
			VALUE ('$user_id','$user_name', '$email','$phone_number','$password');";
		return $this->db_query($sql);
	}

	function create_store($store_id, $store_name, $store_country)
	{
		$sql = "INSERT INTO `stores` (`store_id`, `store_name`, `country`)
			VALUE ('$store_id','$store_name','$store_country');";
		return $this->db_query($sql);
	}

	function create_product($product_id, $store_id, $product_name, $product_description)
	{
		$sql = "INSERT INTO `products`(`product_id`,`store_id`, `product_name`,`product_description`)
			VALUE ('$product_id','$store_id','$product_name', '$product_description')";
		return $this->db_query($sql);
	}

	function add_product_variation($product_id, $variation_id, $price, $currency)
	{
		$sql = "INSERT INTO `product_variations` (`product_id`, `variation_id`, `price`, `currency`)
			VALUE ('$product_id', '$variation_id', '$price', '$currency')";
		return $this->db_query($sql);
	}

	function add_store_manager($user_id, $store_id)
	{
		$sql = "INSERT INTO `store_managers`(`user_id`, `store_id`)
			VALUE ('$user_id','$store_id')";
		return $this->db_query($sql);
	}

	function add_store_wallet($store_id, $name, $number, $network)
	{
		$sql = "INSERT INTO `store_wallets`
			VALUE ('$store_id','$name','$number','$network')";
		return $this->db_query($sql);
	}


	function create_manager_invite($store_id, $token)
	{
		$sql = "INSERT INTO `store_manager_invite` (`store_id`, `invite_token`)
			VALUE ('$store_id', '$token')";
		return $this->db_query($sql);
	}

	function store_forgot_password_token($user_id, $token)
	{
		$sql = "INSERT INTO `password_tokens` VALUE ('$user_id', '$token')";
		return $this->db_query($sql);
	}

	function record_login($user_id)
	{
		$sql = "INSERT INTO `login_history`(`user_id`) VALUE ('$user_id')";
		return $this->db_query($sql);
	}


	function store_credential($api_key, $store_id, $platform, $bearer_token)
	{
		$sql = "INSERT INTO `social_media_credentials`
			VALUE('$api_key', '$store_id','$platform','$bearer_token')";
		return $this->db_query($sql);
	}

	function add_customer($store_id, $customer_id, $customer_name, $customer_number)
	{
		$sql = "INSERT INTO `customers`
			VALUE('$customer_id','$store_id','$customer_name','$customer_number')";
		return $this->db_query($sql);
	}

	function add_order($order_id, $customer_id, $variation_id)
	{
		$sql = "INSERT INTO `orders`
			VALUE('$order_id', '$customer_id','$variation_id')";
		return $this->db_query($sql);
	}


	function add_transaction($transaction_id, $currency, $amount, $date)
	{
		$sql = "INSERT INTO `transactions`
			VALUE ('$transaction_id', '$amount','$currency','$date' )";
		return $this->db_query($sql);
	}

	function link_transaction_order($transaction_id, $order_id)
	{
		$sql = "INSERT INTO `order_transactions`
			VALUE ('$transaction_id', '$order_id')";
		return $this->db_query($sql);
	}

	function add_transaction_withdrawal($transaction_id, $withdrawal_id)
	{
		$sql = "INSERT INTO `withdrawal_transactions`
			VALUE ('$transaction_id', '$withdrawal_id')";
		return $this->db_query($sql);
	}

	function add_schedule_post($post_id, $caption, $time_to_post)
	{

		$sql = "INSERT INTO `scheduled_posts`( `post_id`,`caption`, `time_to_post`)
		 VALUES ('$post_id','$caption','$time_to_post')";

		return $this->db_query($sql);
	}

	//=============================SELECT======================

	function get_store_by_token($token)
	{
		$sql = "SELECT `store_id` FROM `store_manager_invite`
			WHERE `invite_token`='$token' AND `expiry_date` < CURRENT_TIMESTAMP";
		return $this->db_fetch_one($sql);
	}

	function login($email, $password)
	{
		$sql = "SELECT `user_id` FROM `users` WHERE `email` = '$email' AND `password`='$password'";
		return $this->db_fetch_one($sql);
	}

	function get_user_by_email($email)
	{
		$sql = "SELECT * FROM `users` WHERE `email` = '$email'";
		return $this->db_fetch_one($sql);
	}

	function get_store_available_balance($store_id)
	{
		$sql = "SELECT `account_balance` FROM `stores` WHERE `store_id`= '$store_id'";
		return $this->db_fetch_one($sql);
	}

	function get_user_password_token($user_id)
	{
		$sql = "SELECT * FROM `password_tokens` WHERE `user_id`='$user_id'";
		return $this->db_fetch_one($sql);
	}

	function get_user_by_password_token($token)
	{
		$sql = "SELECT * FROM `password_tokens` WHERE `token`= '$token'";
		return $this->db_fetch_one($sql);
	}


	function get_store_credential($store_id, $platform)
	{
		$sql = "SELECT * FROM `social_media_credentials` WHERE `store_id` = '$store_id' AND `platform`='$platform'";
		return $this->db_fetch_all($sql);
	}


	function get_store_by_user_id($user_id)
	{
		$sql = "SELECT `user_id` FROM `store_managers` WHERE `user_id`='$user_id'";
		return $this->db_fetch_one($sql);
	}


	function get_store_wallets($store_id)
	{
		$sql = "SELECT * FROM `store_wallets` WHERE `store_id`='$store_id'";
		return $this->db_fetch_all($sql);
	}

	function get_store_wallet_by_number($store_id, $wallet_number)
	{
		$sql = "SELECT * FROM `store_wallets` WHERE `store_id`='$store_id' AND `wallet_number`='$wallet_number'";
		return $this->db_fetch_one($sql);
	}

	function get_customer_by_number($store_id, $customer_id)
	{
		$sql = "SELECT * FROM `customers`
			WHERE `store_id`='$store_id' AND `customer_id`='$customer_id'";
		return $this->db_fetch_one($sql);
	}

	function get_schedule_post($post_id)
	{
		$sql = "SELECT `post_id`, `caption`, `time_to_post` FROM `scheduled_posts` 
		WHERE `post_id`= '$post_id' ";

		return $this->db_fetch_one($sql);
	}

	function get_total_orders($store_id)
	{
		$sql = "SELECT COUNT(*) FROM `order_transactions`,`orders` WHERE orders.order_id = order_transactions.order_id AND orders.store_id ='$store_id'";

		return $this->db_fetch_all($sql);
	}

	function get_total_sales($store_id)
	{
		$sql = "SELECT `total_funds` FROM `store_account` WHERE `store_id`= '$store_id'";
		return $this->db_fetch_one($sql);
	}

	function get_total_customers($store_id)
	{
		$sql = "SELECT COUNT(*) FROM `customers` WHERE `store_id` = '$store_id'";
		return $this->db_fetch_all($sql);
	}

	function get_total_products($store_id)
	{
		$sql = "SELECT COUNT(*)FROM `products` WHERE `store_id` = '$store_id'";
		return $this->db_fetch_all($sql);
	}


	//How to know the total sales per product
	function get_sales_per_product()
	{
	}

	//COUNT for the monthly orders function 

	//This query works tested
	//This query is under review
	function get_order_month($store_id)
	{
		$sql = "SELECT * from `orders`
			WHERE MONTH(order_date)=MONTH(now())
			AND YEAR(order_date)=YEAR(now()) AND `store_id`='$store_id' ";

		return $this->db_fetch_all($sql);
	}

	//================================UPDATE ===============================================
	function reset_user_password($user_id, $new_p)
	{
		$sql = "UPDATE `users` SET `password`='$new_p' WHERE `user_id` = '$new_p'";
		return $this->db_query($sql);
	}


	//=============================DELETE======================

	function remove_expired_invites()
	{
		$sql = "DELETE FROM `store_manager_invite` WHERE `expiry_date` > CURRENT_TIMESTAMP";
		return $this->db_query($sql);
	}


	function remove_password_token($token, $user_id)
	{
		$sql = "DELETE FROM `password_tokens` WHERE `user_id`='$user_id' AND `token`='$user_id'";
		return $this->db_query($sql);
	}

	function remove_schedule_post($post_id)
	{
		$sql = "DELETE FROM `scheduled_posts` WHERE `post_id`= '$post_id'";
		return $this->db_query($sql);
	}
}
