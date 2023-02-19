<?php

/**
 * This function converts seconds to its equivalent in days
 */
function convertSecToDay($seconds)
{
    $dtF = new \DateTime('@0');
    $dtT = new \DateTime("@$seconds");
    return $dtF->diff($dtT)->format('%a days');
}

/**
 * This function calculates the expiry time of the token
 */
function expiryTime($days)
{
    // echo ($days);
    $exp_date = date('Y-m-d', strtotime('+' . $days));

    return $exp_date;
}
