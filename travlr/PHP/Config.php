<?php
    include_once('fix_mysql.inc.php');
    error_reporting(E_ERROR);
    $DBservername = urlencode($_POST["h"]);
    $DBusername = $_POST["u"];
    $DBpassword = $_POST["p"];
    $DBase = $_POST["d"];
    $DBExecution = $_POST["e"];
    function sendErrorMessage($code, $message) {
        $errorArray = array(array("error" => array("code" => $code, "description" => $message)));
        echo json_encode($errorArray);
        exit();
    }
    $conn = mysql_connect($DBservername, $DBusername, $DBpassword) or sendErrorMessage(mysql_errno(), mysql_error());
    $db = mysql_select_db($DBase) or sendErrorMessage(mysql_errno(), mysql_error());
    $resultArray = array();
    $select = mysql_query($DBExecution);
    if($select === FALSE) {
        sendErrorMessage(mysql_errno(), mysql_error());
    }
    while($row = mysql_fetch_array($select, MYSQL_ASSOC))
    {
        $resultArray[] = $row;
    }
    $myJSON = json_encode($resultArray);
    echo $myJSON;
    mysql_close($conn);
    ?>
