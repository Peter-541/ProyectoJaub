

<?php
    $servername = "localhost";
    $username = "id17146976_selj";
    $password = "Q(lw%Y!5@_~Ftd3i";
    $dbname = "id17146976_testbd";
    $table = "login_flutter";

    $action = $_POST['action'];

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

 

    if('ADD_USE' == $action){
        $name = $_POST['name'];
        $email = $_POST['email'];
        $pass = $_POST['pass'];
        $sql = "INSERT INTO $table (name, email, pass) VALUES('$name', '$email', '$pass')";
        $result = $conn->query($sql);
        echo 'success';
        return;
    }


    if('LOG_USE' == $action){
      	$email = $_POST["email"];
    	$pass = $_POST["pass"];


	$sql = "SELECT * FROM login_flutter WHERE email LIKE '$email' and pass LIKE '$pass'";
//$query = "SELECT * FROM login_flutter WHERE email LIKE '$email'";
 $result = $conn->query($sql);
        echo 'success';
        return;
//	$res = mysqli_query($conn,$query);
//	$data = mysqli_fetch_array($res);

	// data[0] = id, data[1] = name, data[2] = email, data[3] = pass
/*	if ($data[2] >= 1) {
		//account exists
		$query = "SELECT * FROM login_flutter WHERE pass LIKE '$pass'";
		$res = mysql_query($conn,$query);
		$data = mysqli_fetch_array($res);

		if ($data[3] == $pass) {
			//password matched
			$resarr = array();
			array_push($resarr,array("name"=>$data['1'],"email"=>$data['2'],"pass"=>$data['3'],));
 	echo json_encode(array("result"=> $resarr));
		} else {
			//incorrect password
			echo "false";
		}

	} else {
		//account not exists, Create a new account
//	echo	json_encode("No tienes una cuenta");
	}*/
	
    }
   

?>