<?php

require_once (__DIR__."/../vendor/autoload.php");


$dotenv = Dotenv\Dotenv::createUnsafeImmutable(__DIR__);
$dotenv->load();


/**Returns a boolean to indicate whether the current environ
 * is on localhost or on the remove server
 * true => remove server
 * false => localhost
 */
function is_env_remote(){
	return getenv("SERVER") == "REMOTE";
}

/**Returns the databse name for the current environment */
function db_name(){
	return getenv("DB_NAME");
}

/**Returns the databse username for the current environment */
function db_username(){
	return getenv("DB_USERNAME");
}

/**Returns the databse password for the current environment */
function db_pass(){
	return getenv("DB_PASSWORD");
}

/**Returns the baseurl for the server */
function server_base_url(){
	return getenv("SERVER_BASE_URL");
}

/**Returns the databse server for the current environment */
function db_server(){
	return getenv("DB_SERVER");
}

/**Returns the app username for triggered mails */
function email_username(){
	return getenv("EMAIL_USERNAME");
}

/**Returns the app password for triggered mails */
function email_password(){
	return getenv("EMAIL_PASSWORD");
}

/** Returns the url for webhook of slack channel - Platform-monitoring */
function slack_webhook_monitoring(){
	return getenv("SLACK_PLATFORM_MONITORING_URL");
}

/** Returns the url for webhook of slack channel - Platform-monitoring-claims */
function slack_webhook_claims(){
	return getenv("SLACK_PLATFORM_MONITORING_CLAIMS_URL");
}

/**
 * Returns the url for webhook of slack channel - platform-monitoring-logs
 */
function slack_webhook_logs(){
	return getenv("SLACK_PLATFORM_MONITORING_LOGS_URL");
}

/** Returns the url for webhook of slack channel - Platform-monitoring-withdrawals */
function slack_webhook_withdrawals(){
	return getenv("SLACK_PLATFORM_MONITORING_WITHDRAWALS_URL");
}

/**Returns the paybox token */
function paybox_token(){
	return getenv("PAYBOX_BEARER_TOKEN");
}
?>