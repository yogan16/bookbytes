<?php
//error_reporting(0);
include_once("dbconnect.php");
$userid = $_GET['userid'];
$sqllodcart = "SELECT * FROM `tbl_carts` INNER JOIN tbl_books ON tbl_carts.book_id = tbl_books.book_id WHERE tbl_carts.buyer_id = '$userid' AND tbl_carts.cart_status = 'New'";
$result = $conn->query($sqllodcart);

if ($result->num_rows > 0) {
    $cartlist["carts"] = array();
    while ($row = $result->fetch_assoc()) {
        $cart = array();
        $cart['cart_id'] = $row['cart_id'];
        $cart['seller_id'] = $row['seller_id'];
        $cart['book_id'] = $row['book_id'];
        $cart['cart_qty'] = $row['cart_qty'];
        $cart['cart_status'] = $row['cart_status'];
        $cart['cart_date'] = $row['cart_date'];
        $cart['book_title'] = $row['book_title'];
        $cart['book_price'] = $row['book_price'];
        $cart['book_qty'] = $row['book_qty'];
        $cart['book_status'] = $row['book_status'];
        array_push( $cartlist["carts"],$cart);
    }
    $response = array('status' => 'success', 'data' => $cartlist);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}


function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>