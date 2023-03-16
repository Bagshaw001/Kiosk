<?php

require_once(__DIR__ . "/../vendor/autoload.php");
if (session_status() === PHP_SESSION_NONE) {
	session_start();
}


$dotenv = Dotenv\Dotenv::createUnsafeImmutable(__DIR__);
$dotenv->load();


/**Returns a boolean to indicate whether the current environ
 * is on localhost or on the remove server
 * true => remove server
 * false => localhost
 */
function is_env_remote()
{
	return getenv("SERVER") == "REMOTE";
}

/**Returns the databse name for the current environment */
function db_name()
{
	return getenv("DB_NAME");
}

/**Returns the databse username for the current environment */
function db_username()
{
	return getenv("DB_USERNAME");
}

/**Returns the databse password for the current environment */
function db_pass()
{
	return getenv("DB_PASSWORD");
}

/**Returns the baseurl for the server */
function server_base_url()
{
	return getenv("SERVER_BASE_URL");
}

/**Returns the databse server for the current environment */
function db_server()
{
	return getenv("DB_SERVER");
}

/**Returns the app username for triggered mails */
function email_username()
{
	return getenv("EMAIL_USERNAME");
}

/**Returns the app password for triggered mails */
function email_password()
{
	return getenv("EMAIL_PASSWORD");
}

/** Returns the url for webhook of slack channel - Platform-monitoring */
function slack_webhook_monitoring()
{
	return getenv("SLACK_PLATFORM_MONITORING_URL");
}

/** Returns the url for webhook of slack channel - Platform-monitoring-claims */
function slack_webhook_claims()
{
	return getenv("SLACK_PLATFORM_MONITORING_CLAIMS_URL");
}

/**
 * Returns the url for webhook of slack channel - platform-monitoring-logs
 */
function slack_webhook_logs()
{
	return getenv("SLACK_PLATFORM_MONITORING_LOGS_URL");
}

/** Returns the url for webhook of slack channel - Platform-monitoring-withdrawals */
function slack_webhook_withdrawals()
{
	return getenv("SLACK_PLATFORM_MONITORING_WITHDRAWALS_URL");
}

/**Returns the paybox token */
function paybox_token()
{
	return getenv("PAYBOX_BEARER_TOKEN");
}

/**Returns the Facebook version */
function facebook_version()
{
	return getenv("FB_GRAPH_VERSION");
}

/**Returns the Redirect url */
function redirect_url()
{
	return getenv("REDIRECT_URL");
}


/**
 * Returns the Facebook graph domain
 */
function facebook_graph_domain()
{
	return getenv("FB_GRAPH_DOMAIN");
}

/**
 * Returns the Facebook main domain
 */
function facebook_main_domain()
{
	return getenv("FB_MAIN_DOMAIN");
}


function fb_app_id()
{
	return getenv("FB_APP_ID");
}

function fb_app_secret()
{
	return getenv("FB_APP_SECRET");
}

function webhook_verify_token()
{
	return getenv("VERIFY_TOKEN");
}
function chat_token()
{
	return getenv("CHAT_GPT_KEY");
}
