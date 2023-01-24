<?php
	require_once(__DIR__."/vendor/autoload.php");
	require_once(__DIR__."/../utils/env_manager.php");

	//facebook array
	$creds = array(
		"app_id" => facebook_app_id(),
		"app_secret" => facebook_app_secret(),
		"default_graph_version"=> "v3.2",
		"persistent_data_handler" => "session"
	);

	$facebook = new Facebook\Facebook($creds);
	$helper = $facebook->getRedirectLoginHelper();
	$oauth = $facebook->getOAuth2Client();
	$permissions = [
		"public_profile",
		"instagram_basic",
		"pages_show_list",
	];

	function facebook_login(){
		$url = $helper->getLoginUrl(facebook_redirect_url(),$permissions);
		header("Location: $url");
	}

	function facebook_get_user_access_token(){
		try{
			$token = $helper->getAccesToken();
			//switch shortlived access token for long lived access token
			if (!$token->isLongLived()){
				try{
					$token = $oauth->getLongLivedAccessToken($token);
				} catch (Facebook\Exceptions\FacebookSDKException $e){

				}
			}
			return (string) $token;
		} catch (Facebook\Exceptions\FacebookResponseException $e){

		} catch (Facebook\Exceptions\FacebookSDKException $e){

		}

		return $null;
	}







?>