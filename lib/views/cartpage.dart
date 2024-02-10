// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:bookbytes/models/cart.dart';
import 'package:bookbytes/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../shared/myserverconfig.dart';
import 'billscreen.dart';

class CartPage extends StatefulWidget {
  final User user;

  const CartPage({Key? key, required this.user}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> cartList = [];
  double total = 0.0;
  List<List<Cart>> _groupedCartItems = [];

  @override
  void initState() {
    super.initState();
    loadUserCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartList.isEmpty
          ?const Center(child: Text("No Data"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _groupedCartItems.length,
                    itemBuilder: (context, sellerIndex) {
                      final sellerCart = _groupedCartItems[sellerIndex];
                      final seller = sellerCart.first.sellerId!;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "Seller: $seller",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true, 
                            itemCount: sellerCart.length, 
                            itemBuilder: (context, cartIndex) {
                              final cartItem = sellerCart[cartIndex];

                              return ListTile(
                                title: Text(cartItem.bookTitle.toString()),
                                subtitle: Text("RM ${cartItem.bookPrice.toString()}"),
                                leading: const Icon(Icons.sell),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () => _decrementQuantity(cartItem),
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(cartItem.cartQty.toString()),
                                    IconButton(
                                      onPressed: () => _incrementQuantity(cartItem),
                                      icon: const Icon(Icons.add),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "PAYMENT DETAILS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Items:",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "${calculateTotalItems()}",
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          )
                        ],
                      ),
                      const Divider(
                        height: 16,
                        color: Colors.grey,
                      ), 

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Sub Total:",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "RM ${calculateSubtotal().toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 16,
                        color: Colors.grey,
                      ), 

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Delivery Fees:",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            "RM ${(recalculateTotal() - calculateSubtotal()).toStringAsFixed(2)}",
                            style: const TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 16,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TOTAL: RM ${total.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                   
                              List<Cart> cartCopy = List.from(cartList);

                              await Future.forEach(cartCopy, (Cart cartItem) async {
                                await _updateCartItem(cartItem);
                              });

                              // Navigate to BillScreen
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (content) => BillScreen(
                                    user: widget.user,
                                    totalprice: total,
                                  ),
                                ),
                              );
                            },
                            child: Text("CHECKOUT"),
                          ),


                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
  loadUserCart() async {
    try {
      String userid = widget.user.userid.toString();
      final response = await http.get(
        Uri.parse("${MyServerConfig.server}/bookbytes/php/load_cart.php?userid=$userid"),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          cartList.clear();
          total = 0.0;
          data['data']['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));
            total += double.parse(v['book_price']) * int.parse(v['cart_qty']);
          });
          _groupCartItems();
          total = recalculateTotal();
          setState(() {});
        } else {
          Navigator.of(context).pop();
        }
      }
    } catch (error) {
      print("Error loading user cart: $error");
    }
  }

  _incrementQuantity(Cart cartItem) async {
    _updateQuantity(cartItem, int.parse(cartItem.cartQty!) + 1);
  }

  _decrementQuantity(Cart cartItem) async {
    int currentQuantity = int.parse(cartItem.cartQty!);
    if (currentQuantity > 1) {
      _updateQuantity(cartItem, currentQuantity - 1);
    } else {
      _showRemoveItemDialog(cartItem);
    }
  }

  void _showRemoveItemDialog(Cart cartItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Remove Item?"),
        content: const Text("Are you sure you want to remove this item from your cart?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _deleteCartItem(cartItem);
              Navigator.pop(context);
            },
            child: const Text("Remove"),
          )
        ],
      ),
    );
  }

  _updateQuantity(Cart cartItem, int newQuantity) async {
    setState(() {
      cartItem.cartQty = newQuantity.toString();
      total = recalculateTotal();
    });

    await _updateCartQuantity(cartItem.cartId!, cartItem.cartQty!);
  }

  _updateCartQuantity(String cartId, String newQuantity) async {
    try {
      await http.post(
        Uri.parse("${MyServerConfig.server}/bookbytes/php/update_cart_qty.php"),
        body: {
          "cart_id": cartId,
          "cart_qty": newQuantity,
        },
      );

      await loadUserCart();
    } catch (error) {
      print("Error updating cart quantity: $error");
    }
  }
  _updateCartItem(Cart cartItem) {
    try {
      // Update status to Delivered for the specific item
      http.post(
        Uri.parse("${MyServerConfig.server}/bookbytes/php/update_cart_status.php"),
        body: {
          "cart_id": cartItem.cartId,
          "status": "Delivered",
        },
      );

      // Clear the entire cart locally
      setState(() {
        cartList.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cart cleared"), backgroundColor: Colors.green,),
      );
    } catch (error) {
      print("Error Cart: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred"), backgroundColor: Colors.red,),
      );
    }
  }

  _deleteCartItem(Cart cartItem) async {
    try {
      final response = await http.post(
        Uri.parse("${MyServerConfig.server}/bookbytes/php/delete_cart_item.php"),
        body: {
          "cart_id": cartItem.cartId,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          cartList.remove(cartItem);
          total = recalculateTotal();
        });
        await loadUserCart();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to remove item"), backgroundColor: Colors.red,),
        );
      }
    } catch (error) {
      print("Error deleting cart item: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred"), backgroundColor: Colors.red,),
      );
    }
  }
  double calculateSubtotal() {
    double subtotal = 0.0;

    _groupedCartItems.forEach((sellerCart) {
      sellerCart.forEach((item) {
        subtotal += double.parse(item.bookPrice!) * int.parse(item.cartQty!);
      });
    });

    return subtotal;
  }
  
  double recalculateTotal() {
    double newTotal = 0.0;

    _groupedCartItems.forEach((sellerCart) {
      double sellerSubtotal = 0.0;

      sellerCart.forEach((item) {
        sellerSubtotal += double.parse(item.bookPrice!) * int.parse(item.cartQty!);
      });
      newTotal += sellerSubtotal + 10.0;

    });

    return newTotal;
  }
 int calculateTotalItems() {
    int totalItems = 0;
    _groupedCartItems.forEach((sellerCart) {
      sellerCart.forEach((item) {
        totalItems += int.parse(item.cartQty!);
      });
    });
    return totalItems;
  }

  void _groupCartItems() {
    _groupedCartItems = [];
    final groupedMap = <String, List<Cart>>{};
    cartList.forEach((item) {
      groupedMap.putIfAbsent(item.sellerId!, () => []).add(item);
    });
    _groupedCartItems = groupedMap.values.toList();
  }
}
