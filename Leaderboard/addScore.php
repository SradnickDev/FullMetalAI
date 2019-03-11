<?php

	include "connect.php";

	$name = mysqli_real_escape_string($conn, $_GET['name']);
	$map = mysqli_real_escape_string($conn, $_GET['map']);	
	$mod = mysqli_real_escape_string($conn, $_GET['mod']);
	$time = mysqli_real_escape_string($conn, $_GET['time']);
	$killcount = mysqli_real_escape_string($conn, $_GET['killcount']);
	$score = mysqli_real_escape_string($conn, $_GET['score']);
	
	
	$query = "INSERT INTO board (name,map,modi,time,killcount,score) VALUES ('$name' , '$map' , '$modi' , '$time' , '$killcount' , '$score' )";
	$result = mysqli_query($conn,$query) or die('Query failed: ' . mysqli_error());
?>