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
$pStmt = $conn->prepare("SELECT g_name FROM interest,group, groupinterest WHERE g_id = (Select g_id FROM groupinterest where intr_name like %?%)");

//Get the interest that the user would like to view
$interestChosen = $_Post['selectedInterest'];

$pStmt->bind_param("ss", $interestChosen);
$pStmt->execute();

//Displays all groups related to interest in a table
echo "<table>"
while($row = mysqli_fetch_assoc($pStmt))
{
	echo "<tr>";
	echo <td>" . $row['g_name'] . "</td>;
	<echo "</tr>";
}
echo </table>;
$conn->close();

?>