<?php
	$host ="HOSTNAME";
	$user = "DBUSERNAME";
	$password = "DBPASSWORD";
	$dbName = "DBNAME";

	$conn = mysqli_connect($host,$user,$password,$dbName) or die("Failed to Connect to : " . mysqli_error());
	mysqli_select_db($conn,$dbName) or die('Failed to access database');
	
?>