<?php

/**
 * Test for the Facebook class
 */
require_once(__DIR__ . "/../../facebook/classes/catalog.php");

class CatalogTest extends \PHPUnit\Framework\TestCase
{

    public function testUploadCatalog()
    {
        $test = new catalog();
        $catalog = $test->upload_product("Test123", "phone", "new phone", "in stock", "new", "14 USD", "https://www.facebook.com/facebook_t_shirt", "https://www.facebook.com/facebook_t_shirt", "NIKE", "10", "");
        $this->assertIsBool($catalog);
    }
}
