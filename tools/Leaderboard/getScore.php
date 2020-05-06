<?php
	 include "connect.php";
	 
	 $query = "SELECT * FROM board ORDER BY score DESC";
	 $result = mysqli_query($conn,$query) or die("Query failed: " . mysqli_error());
	 
	 $resultLength = mysqli_num_rows($result); 
	 
	 for($i = 0;$i < $resultLength;$i++)
	 {
		$row = mysqli_fetch_array($result);
		echo $row['name'] . "," . $row['map'] . "," . $row['modi'] . "," . $row['time'] . "," . $row['killcount'] . "," . $row['score'] . "\n";
	 }
?>