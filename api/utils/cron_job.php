<?php
	require_once(__DIR__."/../database/controllers/db_controller.php");
	$path = '/var/www/html/kiosk/api/utils/say_hi.php ';//."'say cheese'";
	// One minute from now
	
	$time_to_post = (date("i")+1)." ".date("H")." ".date("d")." ".date("m")." 2 ";
	$command = "$time_to_post curl localhost/kiosk/api/utils/post_instagram.php";
	echo "Command: $command\n";

// $res = exec('crontab -l');
$res = exec("echo '$command' | crontab -",$output);
if($res){
	echo "success ";
	echo $res;

}else {
	echo "Fail ";
	var_dump($output);
	echo "\n";
	var_dump($res);
}

// exec("crontab -l");
?>