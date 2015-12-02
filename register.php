<?php
$servername = "localhost";
$dbusername = "root";
$dbpassword = "" ;
$dbname = "meetup";
$conn = new mysqli($servername, $dbusername, $dbpassword, $dbname);
if(!$conn) 
{
	die("Unable to connect to database");
}

//Prepared statement to query, protects against SQL Injection
$pStmt = $conn->prepare("INSERT into member (username, password, firstname, lastname, zipcode) VALUES (?,?,?,?,?)");

//Get user information
$username = $_POST['user'];
$password = $_POST['pass'];
$firstname = $_POST['first'];
$lastname = $_POST['last'];
$zipcode = $_POST['zip'];

//Protect against SQL Injection
$username = stripslashes($username);
$password = stripslashes($password);
$firstname = stripslashes($firstname);
$lastname = stripslashes($lastname);
$zipcode = stripslashes($zipcode);
$username = mysql_real_escape_string($username);
$password = mysql_real_escape_string($password);
$firstname = mysql_real_escape_string($firstname);
$lastname = mysql_real_escape_string($lastname);
$zipcode = mysql_real_escape_string($zipcode);

//Replaces ? with entered user information
$pStmt->bind_param("ss", $username, $password, $firstname, $lastname, $zipcode);

//Executes query and if a result is found, log in and create session
pStmt->execute();
if($pStmt->fetch())
{
	Session_start();
	$_Session['timeout'] = time();
	$_Session['status'] = 'authorized';
	echo "You have been registered";
	header("Location: index.php");
}
else
	return "Unable to register, please try again";

$pStmt->close();
?>