<?php

/**
 * Review this code for the instagram login
 */
	// require_once(__DIR__."/vendor/autoload.php");
	// require_once(__DIR__."/../utils/env_manager.php");
	// require_once(__DIR__."/../utils/define.php");
	// require_once(__DIR__."/../utils/http_handler.php");

	// //facebook array
	// $creds = array(
	// 	"app_id" => facebook_app_id(),
	// 	"app_secret" => facebook_app_secret(),
	// 	"default_graph_version"=> "v3.2",
	// 	"persistent_data_handler" => "session"
	// );

	// $facebook = new Facebook\Facebook($creds);
	// $helper = $facebook->getRedirectLoginHelper();
	// $oauth = $facebook->getOAuth2Client();
	// $permissions = [
	// 	"public_profile",
	// 	"instagram_basic",
	// 	"pages_show_list",
	// ];

	// function facebook_login(){
	// 	$url = $helper->getLoginUrl(facebook_redirect_url(),$permissions);
	// 	header("Location: $url");
	// }

	// function facebook_get_user_access_token(){
	// 	try{
	// 		$token = $helper->getAccesToken();
	// 		//switch shortlived access token for long lived access token
	// 		if (!$token->isLongLived()){
	// 			try{
	// 				$token = $oauth->getLongLivedAccessToken($token);
	// 			} catch (Facebook\Exceptions\FacebookSDKException $e){

	// 			}
	// 		}
	// 		return (string) $token;
	// 	} catch (Facebook\Exceptions\FacebookResponseException $e){

	// 	} catch (Facebook\Exceptions\FacebookSDKException $e){

	// 	}

	// 	return null;
	// }


	// //returns the instagram account id for the user who has completed the facebook
	// // oauth process
	// function get_instagram_account_id($accessToken){
	// 	//to access the instagram account id of a user, we use their oauth access token to obtain
	// 	//their facebook account info (important attribute being page id). Using the page
	// 	//id, we can call another endpoint to obtain the associated instagram account id
	// 	$endpoint = FACEBOOK_ENDPOINT_BASE. "me/accounts?access_token=$accessToken";

	// 	$http = new http_handler();
	// 	$response = $http->get($endpoint);
	// 	$response = json_decode($response,true)["data"];

	// 	$page_id = $response[0]["id"];


	// 	$insta_endpoint = FACEBOOK_ENDPOINT_BASE. "$page_id?fields=instagram_business_account&access_token=$accessToken";

	// 	$insta_response =  $http->get($insta_endpoint);
	// 	$insta_response = json_decode($insta_response,true);
	// 	$instagram_id = $insta_response["instagram_business_account"]["id"];

	// }





?>