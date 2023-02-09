<?php



	class http_handler {

		private function http_request($url, $request_type, $body = null ,array $header = null){

			$curl = curl_init();


			// Add header to curl request if one is given
			if ($header != null){
				curl_setopt_array($curl, array(CURLOPT_HTTPHEADER => $header));
			}

			// Add body to curl request if one is given
			if ($body != null){
				curl_setopt_array($curl, array(CURLOPT_POSTFIELDS => $body));
			}

			curl_setopt_array($curl, array(
				CURLOPT_URL => $url,
				CURLOPT_RETURNTRANSFER => true,
				CURLOPT_ENCODING => '',
				CURLOPT_MAXREDIRS => 10,
				CURLOPT_TIMEOUT => 0,
				CURLOPT_FOLLOWLOCATION => true,
				CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
				CURLOPT_CUSTOMREQUEST => $request_type,

			));


			//execute request
			$response = curl_exec($curl);
			curl_close($curl);

			return $response;
		}

		function get($url,$body = null, $header = null) {
			return $this->http_request($url,"GET", body: $body, header: $header);
		}


		function post($url, $body, $header = null){
			return $this->http_request($url,"POST", body: $body, header: $header);
		}
	}


?>