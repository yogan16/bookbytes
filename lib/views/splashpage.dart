import 'dart:async';
import 'dart:convert';
import 'package:bookbytes/shared/myserverconfig.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'mainpage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    checkandlogin();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "BOOKBYTES",
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircularProgressIndicator(),
              Text(
                "Version 0.1",
                style: TextStyle(
                  fontSize: 24,
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  checkandlogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    bool rem = (prefs.getBool('rem')) ?? false;
    if (rem) {
      http.post(
          Uri.parse("${MyServerConfig.server}/bookbytes/php/login_user.php"),
          body: {"email": email, "password": password}).then((response) {
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          if (data['status'] == "success") {
            User user = User.fromJson(data['data']);
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainPage(
                              userdata: user,
                            ))));
          } else {
            User user = User(
                userid: "0",
                useremail: "unregistered@email.com",
                username: "Unregistered",
                userdatereg: "",
                userpassword: "");
            Timer(
                const Duration(seconds: 3),
                () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainPage(
                              userdata: user,
                            ))));
          }
        }
      });
    } else {
      User user = User(
          userid: "0",
          useremail: "unregistered@email.com",
          username: "Unregistered",
          userdatereg: "",
          userpassword: "");
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (content) => MainPage(
                        userdata: user,
                      ))));
    }
  }
}
