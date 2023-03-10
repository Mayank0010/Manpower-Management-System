import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:manpower_management_app/screens/admin_dashboard.dart';
import 'package:manpower_management_app/screens/admin_home.dart';
import 'package:manpower_management_app/screens/home_screen.dart';
import 'package:manpower_management_app/services/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff62E756), Color(0xff22ADCB)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => HomeScreen()
                ));
              },
            )
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 40),
              child: Text(
                'Admin Sign In',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                prefixIcon: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.email)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  icon: Icon(
                                    isObscure ?
                                      Icons.visibility_off : Icons.visibility
                                  )
                                ),
                                prefixIcon: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.lock)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 200.0,),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context) => ForgotPassword()
                                  ));
                                },
                                child: Text('Forgot Password',
                                  style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline,
                                  color: Colors.blueGrey,
                                  ),),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 60,
                                width: 340,
                                child: ElevatedButton(
                                  child: Text(
                                    'Login',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xffCDF3FB),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)),
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontStyle: FontStyle.normal)),
                                  onPressed: () {
                                    login();
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> login() async {
    if(passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      Response response = await post(
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : 'eve.holt@reqres.in',
            'password' : 'cityslicka'
          });
      if(response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blank Field Not Allowed.")));
    }
  }
}



