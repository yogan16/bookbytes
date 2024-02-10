<?php
include_once("dbconnect.php");

$cartId = $_POST['cart_id'];
$status = $_POST['status'];

$sqlUpdateStatus = "UPDATE tbl_carts SET cart_status = '$status' WHERE cart_id = '$cartId'";
if ($conn->query($sqlUpdateStatus) === TRUE) {
    $response = array('status' => 'success', 'message' => 'Status updated successfully');
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'message' => 'Failed to update status');
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>
