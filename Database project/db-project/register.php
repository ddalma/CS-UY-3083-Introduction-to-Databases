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
$userCheck = $conn->prepare("SELECT username FROM member WHERE username = ?");

//Get entered user information
$username = $_POST['user'];
$password = $_POST['pass'];
$verifypass = $_POST['verifypass'];
$firstname = $_POST['first'];
$lastname = $_POST['last'];
$zipcode = $_POST['zipcode'];

//Protect against SQL Injection
$username = stripslashes($username);
$password = stripslashes($password);
$verifypass = stripslashes($verifypass);
$firstname = stripslashes($firstname);
$lastname = stripslashes($lastname);
$zipcode = stripslashes($zipcode);

$userCheck->bind_param("s", $username);
$userCheck->execute();
$userCheck = $userCheck->num_rows;

if(strlen($zipcode) == 5 && ctype_digit($zipcode))
{
	if($userCheck == 0)
	{
		if($password == $verifypass)
		{
			$password = md5($password);
			$pStmt->bind_param("ssssd", $username, $password, $firstname, $lastname, $zipcode);
			$pStmt->execute();
			Session_start();
			$_Session['timeout'] = time();
			$_Session['status'] = 'authorized';
			header("Location: index.php");
		}
		else
			echo "Passwords do not match";
	}
	else
		echo "Username is taken";
}
else
	echo header("Location: signup.html");

//Executes query and if a result is found, log in and create session
$pStmt->close();
?>