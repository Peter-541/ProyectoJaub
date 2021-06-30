

<?php
    $servername = "localhost";
    $username = "id17146976_selj";
    $password = "Q(lw%Y!5@_~Ftd3i";
    $dbname = "id17146976_testbd";
    $table = "Vuelos";

    $action = $_POST['action'];

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    if('CREATE_TABLE' == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table (
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            origen_v VARCHAR(30) NOT NULL,
            destino_v VARCHAR(30) NOT NULL,
            salida_v VARCHAR(30) NOT NULL
            )";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }

    if('GET_ALL' == $action){
        $dbdata = array();
        $sql = "SELECT id, origen_v, destino_v, salida_v FROM $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $dbdata[]=$row;
            }
            echo json_encode($dbdata);
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }

    if('ADD_VUE' == $action){
        $origen_v = $_POST['origen_v'];
        $destino_v = $_POST['destino_v'];
        $salida_v = $_POST['salida_v'];
        $sql = "INSERT INTO $table (origen_v, destino_v, salida_v) VALUES('$origen_v', '$destino_v', '$salida_v')";
        $result = $conn->query($sql);
        echo 'success';
        return;
    }

    if('UPDATE_VUE' == $action){
        $vue_id = $_POST['vue_id'];
        $origen_v = $_POST['origen_v'];
        $destino_v = $_POST['destino_v'];
        $salida_v = $_POST['salida_v'];
        $sql = "UPDATE $table SET origen_v = '$origen_v', destino_v = '$destino_v', salida_v = '$salida_v' WHERE id = $vue_id";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }

    if('DELETE_VUE' == $action){
        $vue_id = $_POST['vue_id'];
        $sql = "DELETE FROM $table WHERE id = $vue_id";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "error";
        }
        $conn->close();
        return;
    }
    
?>