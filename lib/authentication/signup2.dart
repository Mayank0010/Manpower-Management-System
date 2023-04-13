import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class SignupPage1 extends StatefulWidget {
  @override
  _SignupPage1State createState() => _SignupPage1State();
}

class _SignupPage1State extends State<SignupPage1> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final String _role = 'District Administrator';

  bool isObscure = true;

  String hashPassword(String password) {
    // Hash the password using SHA-256
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);

    // Convert the digest to a string and return it
    return digest.toString();
  }

  Future<void> _signupUser() async {
    try {
      String hashedPassword = hashPassword(_passwordController.text);
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      String userId = userCredential.user!.uid;
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String mobile = _mobileController.text.trim();
      String role = _role;

      await FirebaseFirestore.instance.collection('admin_users').doc(userId).set({
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
        'password': hashedPassword,
      });

      // Clear the form after signup
      _nameController.clear();
      _emailController.clear();
      _mobileController.clear();
      _passwordController.clear();

      // Send a text message with the login credentials
      TwilioFlutter twilioFlutter = TwilioFlutter(
        accountSid: 'AC0c0e16fcdf859334bcd6d07347109234',
        authToken: '98092d157d8865648af7040c4f835683',
        twilioNumber: '+15855361374',
      );
      String message = 'Your login credentials are:\nEmail: $email\nPassword: ${_passwordController.text}';
      await twilioFlutter.sendSMS(
        toNumber: '+91'+mobile,
        messageBody: message,
      );


      // Show a snackbar message to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup successful!'),
          duration: Duration(seconds: 3),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Signup failed: ';
      if (e.code == 'weak-password') {
        errorMessage += 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage += 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage += 'The email address is invalid.';
      } else {
        errorMessage += 'An error occurred, please try again later.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('District Admin Signup'),
        backgroundColor: Color(0xffF89669),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value!.length < 2) {
                      return 'Name must be at least 2 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value!.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller:_mobileController,
                  decoration: InputDecoration(labelText: 'Mobile'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value!.length != 10) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
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
                  ),
                  obscureText: isObscure,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value!.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signupUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffF89669),
                  ),
                  child: Text('Signup', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
