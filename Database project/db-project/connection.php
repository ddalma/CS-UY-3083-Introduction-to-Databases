<?php
$servername = "localhost";
$dbusername = "root";
$dbpassword = "root" ;
$dbname = "learnlearn";
$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);	if(mysqli_connect_errno()){
		echo "Failed to connect: " .mysqli_connect_error();
	}

?>