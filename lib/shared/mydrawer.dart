// ignore_for_file: avoid_print

import 'package:bookbytes/views/cartpage.dart';
import 'package:bookbytes/views/loginpage.dart';
import 'package:bookbytes/views/registrationpage.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../views/profilepage.dart';


class MyDrawer extends StatefulWidget {
  final String page;
  final User userdata;

  const MyDrawer({Key? key, required this.page, required this.userdata})
      : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            currentAccountPicture: const CircleAvatar(
              foregroundImage: AssetImage('assets/images/1.jpg'),
              backgroundColor: Colors.white,
            ),
            accountName: Text(widget.userdata.username.toString()),
            accountEmail: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.userdata.useremail.toString()),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text('Book List'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.money_rounded),
            title: const Text('Purchase'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('My Cart'),
            onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(user:widget.userdata),
                    ),
                  );
                },
          ),
          const Divider(
            color: Colors.blueGrey,
          ),
          ExpansionTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('My Account'),
            children: [
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.app_registration_rounded),
                title: const Text('Register'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.manage_accounts),
                title: const Text('Manage'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(user: widget.userdata,),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
