<?php
require("../utils/http_handler.php");

class statistics
{

    public $http;

    function __construct()
    {
        $http = new http_handler();
        $this->http = $http;
    }
    function total_monthly_orders()
    {
    }
}
