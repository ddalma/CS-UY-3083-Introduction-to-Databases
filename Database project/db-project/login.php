<?php
$servername = "localhost";
$dbusername = "root";
$dbpassword = "root" ;
$dbname = "meetup";
$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);
if(!$conn) 
{
	die("Unable to connect to database");
}

//Prepared statement to query, protects against SQL Injection
$pStmt = $conn->prepare("SELECT * FROM member WHERE username = ? AND password = ?");

//Get username and password
$username = $_POST['user'];
$password = $_POST['pass'];

//Protect against SQL Injection
$username = stripslashes($username);
$password = stripslashes($password);

//Replaces ? with username and password
$pStmt->bind_param("ss", $username, $password);

//Executes query and if a result is found, log in and create session
$pStmt->execute();
if($pStmt->fetch())
{
	Session_start();
	$_Session['timeout'] = time();
	$_Session['status'] = 'authorized';
	header("Location: index.php");
}
else
{
	header("Location: login.html");
	$response = "Incorrect username or password";
}

$pStmt->close();
?>