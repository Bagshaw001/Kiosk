<?php
	require_once(__DIR__."/../classes/db_class.php");

	function create_account($user_id,$user_name,$phone_number,$email,$password){
		$db = new db_class();
		return $db->create_account($user_id,$user_name,$phone_number,$email,$password);
	}

	function create_store($store_id,$store_name,$store_country){
		$db = new db_class();
		return $db->create_store($store_id,$store_name,$store_country);
	}

	function create_product($product_id,$store_id,$product_name,$product_description, $quantity, $currency, $price){
		$db = new db_class();
		return $db->create_product($product_id,$store_id,$product_name,$product_description, $quantity, $currency, $price);
	}


	function add_store_manager($user_id,$store_id){
		$db = new db_class();
		return $db->add_store_manager($user_id,$store_id);
	}


	function add_store_wallet($store_id,$name,$number,$network){
		$db = new db_class();
		return $db->add_store_wallet($store_id, $name,$number, $network);
	}

	function create_manager_invite($store_id,$token){
		$db = new db_class();
		return $db->create_manager_invite($store_id,$token);
	}

	function store_credential($api_key,$store_id,$platform,$bearer_token){
		$db = new db_class();
		return $db->store_credential($api_key,$store_id,$platform,$bearer_token);
	}

	function store_email_verification_token($user_id,$token){
		$db = new db_class();
		return $db->store_email_verification_token($user_id,$token);
	}

	function store_phone_verification_token($user_id,$token){
		$db = new db_class();
		return $db->store_phone_verification_token($user_id,$token);
	}

	function get_store_by_token($token){
		$db = new db_class();
		return $db->get_store_by_token($token);
	}

	function get_store_credential($store_id, $platform){
		$db = new db_class();
		return $db->get_store_credential($store_id,$platform);
	}

	function remove_expired_invites(){
		$db = new db_class();
		return $db->remove_expired_invites();
	}

	function login($email,$password){
		$db = new db_class();
		$res = $db->login($email,$password);
		if ($res){
			return $res["user_id"];
		}
		return null;
	}

	function record_login($user_id){
		$db = new db_class();
		return $db->record_login($user_id);
	}


	function get_user_by_email($email){
		$db = new db_class();
		return $db->get_user_by_email($email);
	}

	function get_user_store_id($user_id){
		$db = new db_class();
		$res = $db->get_store_by_user_id($user_id);
		if ($res){
			return $res["store_id"];
		}
		return null;
	}

	function get_user_password_token($user_id){
		$db = new db_class();
		$res = $db->get_user_password_token($user_id);
		if ($res){
			return $res["token"];
		}
		return null;
	}

	function get_user_by_password_token($token){
		$db = new db_class();
		$res = $db->get_user_by_password_token($token);
		if($res){
			return $res["user_id"];
		} else {
			return false;
		}
	}

	function get_email_verification_token($user_id){
		$db = new db_class();
		return $db->get_email_verification_token($user_id);
	}

	function get_phone_verification_token($user_id){
		$db = new db_class();
		return $db->get_phone_verification_token($user_id);
	}

	function get_store_wallets($store_id){
		$db = new db_class();
		return $db->get_store_wallets($store_id);
	}

	function confirm_store_wallet($store_id,$wallet_number){
		$db = new db_class();
		$exists = $db->get_store_wallet_by_number($store_id,$wallet_number);
		return $exists ? true : false;
	}

	function get_store_available_balance($store_id){
		$db = new db_class();
		return $db->get_store_by_id($store_id)["account_balance"];
	}

	function get_store_by_id($store_id){
		$db = new db_class();
		return $db->get_store_by_id($store_id);
	}

	function get_user_by_id($user_id){
		$db = new db_class();
		return $db->get_user_by_id($user_id);
	}

	function get_customer_by_number($store_id,$customer_number){
		$db = new db_class();
		return $db->get_customer_by_number($store_id,$customer_number);
	}

	function remove_password_token($token,$user_id){
		$db = new db_class();
		return $db->remove_password_token($token,$user_id);
	}

	function reset_user_password($user_id,$new_p){
		$db = new db_class();
		return $db->reset_user_password($user_id,$new_p);
	}


	function store_forgot_password_token($user_id,$token){
		$db = new db_class();
		return $db->store_forgot_password_token($user_id,$token);
	}

	function add_customer($store_id,$customer_id,$customer_name,$customer_number){
		$db = new db_class();
		return $db->add_customer($store_id,$customer_id,$customer_name,$customer_number);
	}


	function add_order($order_id,$customer_id, $product_id){
		$db = new db_class();
		return $db->add_order($order_id,$customer_id,$product_id);
	}

	function add_transaction($transaction_id,$currency,$amount,$date){
		$db = new db_class();
		return $db->add_transaction($transaction_id,$currency,$amount,$date);
	}

	function is_user_a_collaborator($store_id,$user_id){
		$db = new db_class();
		return $db->get_store_by_user_id($user_id)["store_id"] == $store_id;
	}

	function is_email_token_valid($token){
		$db = new db_class();
		if ($db->get_user_by_email_verification_token($token)) {
			return true;
		}
		return false;
	}

	function is_phone_token_valid($token){
		$db = new db_class();
		if ($db->get_user_by_phone_verification_token($token)) {
			return true;
		}
		return false;
	}

	function confirm_email_verification($token){
		$db = new db_class();

		$user_id = $db->get_user_by_email_verification_token($token)["user_id"];

		$db->update_email_verification($user_id);
		$db->remove_email_token($user_id,$token);
	}

	function confirm_phone_verification($token){
		$db = new db_class();

		$user_id = $db->get_user_by_phone_verification_token($token)["user_id"];

		$db->update_phone_verification($user_id);
		$db->remove_phone_token($user_id,$token);
		return true;
	}

	function link_transaction_order($transaction_id,$order_id){
		$db = new db_class();
		return $db->link_transaction_order($transaction_id,$order_id);
	}


	function add_transaction_withdrawal($transaction_id,$withdrawal_id){
		$db = new db_class();
		return $db->add_transaction_withdrawal($transaction_id,$withdrawal_id);
	}


	function get_products($store_id){
		$db = new db_class();
		return $db->get_products($store_id);
	}

	function update_product($product_id,$product_name,$product_description, $quantity, $currency, $price){
		$db = new db_class();
		return $db->update_product($product_id,$product_name,$product_description, $quantity, $currency, $price);
	}


?>