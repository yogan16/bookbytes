import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/mydrawer.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  final User userdata;

  const MainPage({Key? key, required this.userdata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BookBytes',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to BookBytes',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              userdata.username ?? 'Guest',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(
        page: "books",
        userdata: userdata,
      ),
    );
  }
}
