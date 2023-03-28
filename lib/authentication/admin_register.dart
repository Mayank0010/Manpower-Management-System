import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_login.dart';
import 'package:manpower_management_app/screens/admin_screen.dart';
import 'package:manpower_management_app/screens/home_screen.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({Key? key}) : super(key: key);

  @override
  _AdminRegisterState createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var roleController = TextEditingController();
  var passwordController = TextEditingController();

  bool isObscure = true;

  String hashPassword(String password) {
    // Hash the password using SHA-256
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);

    // Convert the digest to a string and return it
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode myFocusNode = new FocusNode();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffF89669), Color(0xff27f985)])
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => HomeScreen()
              ));
            },
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Center(
                            child: Image.asset(
                              'assets/images/icons8-admin-64.png',
                              height: 64,
                              width: 64,
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              'Admin Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 33,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: nameController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: "Name",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? Colors.blueGrey : Colors.black
                                      ),
                                      prefixIcon: Icon(Icons.account_box),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? Colors.blueGrey : Colors.black
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: mobileController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: "Mobile Number",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? Colors.blueGrey : Colors.black
                                      ),
                                      prefixIcon: Icon(Icons.mobile_friendly),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter mobile number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  controller: roleController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: "Role",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? Colors.blueGrey : Colors.black
                                      ),
                                      prefixIcon: Icon(Icons.message),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter role';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  obscureText: isObscure,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? Colors.blueGrey : Colors.black
                                      ),
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),

                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  signup();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xffF89669),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: Text('SIGNUP'),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Have an account?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context) => AdminLogin()
                                  ));
                                },
                                child: Text(
                                  'Login',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                style: ButtonStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future signup() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );

    try {
      String hashedPassword = hashPassword(passwordController.text);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      ).then((value) {
        FirebaseFirestore.instance.collection('admin_users').doc(value.user?.uid)
            .set({"name": nameController.text,
                  "email": value.user?.email,
                  "mobile": mobileController.text,
                  "role": roleController.text,
                  "password": hashedPassword,
            });
        Navigator.push(context, MaterialPageRoute(builder:
            (context) => AdminScreen()
        ));
      });
    } on FirebaseAuthException catch(e) {
      if(emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Enter your email or password!!')));
        Navigator.pop(context);
      }
    }
  }
}
