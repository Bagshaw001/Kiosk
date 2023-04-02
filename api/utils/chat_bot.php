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
						enquiry, unknown, order, catalog_request and personal"
					),
					array(
						"role" => "assistant",
						"content" => "'Do you have black tops' is an enquiry"
					),
					array(
						"role" => "system",
						"content" => "If a messsage is concern with mobile money, bank account or any other payment method, it is NOT an enquiry but an order"
					),
					array(
						"role" => "assistant",
						"content" => "'I want to buy one' is an order"
					),
				array(
				'role' => 'user',
				'content' => "classify the following text: >$prompt<
				Caveats:
					-If  the text is a query. Add another json field 'product_name' for the name of the
					product that the enquiry is about.
					-If the text is an enquiry but about multiple items or the product is a plural (like 'phones','shoes'),
					then change the type to a catalgoue_request
					-If  the response is an order.Add more json fields for information about the product
					including product_name and quantity
				You can only respond in the json format {\"type\":\"category\", \"reason\": \"text\"}.
				Any explanations for the category must be put in the reason section. You can't break this format rule

				"
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