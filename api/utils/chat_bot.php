<?php
	require_once(__DIR__."/../utils/core.php");
	class chat_bot{
		private http_handler $http;


		function __construct(){
			$this->http = new http_handler();
		}

		function send_prompt($prompt){
			$response = $this->http->post("https://api.openai.com/v1/chat/completions",
			json_encode(array(
				'model' => 'gpt-3.5-turbo',
				'messages' => array(
					array(
						'role' => 'system',
						'content' => "You are a system to classify whatsapp and instagram messages into
						enquiry, unknown, order, catalog request and personal"
					),
					array(
						"role" => "assistant",
						"content" => "{type: 'catalog request', msg:'Do you have blue shoes',
							 reason: 'The message ask for the availablity of a product within the store inventory' }"
					),
					array(
						"role" => "system",
						"content" => "If a messsage is concern with mobile money, bank account or
						any other payment method, it is NOT an enquiry but an order"
					),
					array(
						"role" => "assistant",
						"content" => "'I want to buy one' is an order"
					),
					array(
					'role' => 'user',
					'content' => "classify the following text: >$prompt<
					You can only respond in the json format {type:category, reason: text, msg: previous message}.
					Any explanations for the category must be put in the reason section.
					You can't break this format rule"
				),
				))),array(
					'Content-Type: application/json',
					'Authorization: Bearer '. chat_token()
				)
		);
			return $response;

		}
	}
?>