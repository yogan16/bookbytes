<?php
include_once("dbconnect.php");

// Assuming you have received the data in the URL parameters
$totalAmount = $_GET['amount'];
$refNumber = $_GET['refNumber'];
$date = $_GET['date'];
$status = $_GET['status'];
$userid = $_GET['userid'];

$sqlInsertReceipt = "INSERT INTO tbl_orders (buyer_id, refNum, order_total, order_date, order_status) VALUES ('$userid', '$refNumber', '$totalAmount', '$date', '$status')";

if ($conn->query($sqlInsertReceipt) === TRUE) {
    $response = array('status' => 'success', 'message' => 'Receipt data inserted successfully');
    echo json_encode($response);
} else {
    $response = array('status' => 'failed', 'message' => 'Error inserting data: ' . $conn->error);
    echo json_encode($response);
}

$conn->close();
?>
