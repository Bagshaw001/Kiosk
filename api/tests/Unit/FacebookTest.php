<?php
/**
 * Test for the Facebook class
 */
require_once(__DIR__ . "/../../facebook/classes/facebook_api.php");

class FacebookTest extends \PHPUnit\Framework\TestCase
{


    public function testLoginUrl()
    {
        $test = new facebook_api();

        $loginUrl = $test->fb_generateLoginUrl("TEST", "TEST");

        $this->assertIsString($loginUrl);
    }

    public function testAccessToken()
    {
        $test = new facebook_api();

        $loginUrl = $test->fb_accessToken("TEST", "TEST");

        $this->assertIsBool($loginUrl);
    }
}
