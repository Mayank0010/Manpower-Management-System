import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_register.dart';
import 'package:manpower_management_app/screens/home_screen.dart';
import 'package:manpower_management_app/services/forgot_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
            elevation: 0,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => HomeScreen()
                ));
              },
            )
        ),
        body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          SizedBox(height: 60),
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
                              'Admin Login',
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
                                  controller: emailController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      labelText: "Email",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? Colors.blueGrey : Colors.black
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      )
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    if (!value!.contains('@')) {
                                      return 'Please enter a valid email address';
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
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (value!.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          ],
                            ),

                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(width: 160.0,),
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
                                  color: Colors.white,
                                  ),),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    login();
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
                                  child: Text('LOGIN'),
                                ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Dont have an account?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder:
                                      (context) => AdminRegister()
                                  ));
                                },
                                child: Text(
                                  'Sign Up',
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

  /*
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
   */

  Future login() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),)
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );

      /*
      final userRef = FirebaseFirestore.instance.collection('admin_details').doc();
      final userData = await userRef.get();
      if (userData.exists && userData.data()!['role'] == 'district') {
        // Navigate to admin dashboard
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      }
       */

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Admin logged in!!')));
      Navigator.pop(context);

    } on FirebaseAuthException catch(e) {
      if(e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found with this email!!')));
        Navigator.pop(context);
      } else if(e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password did not match!!')));
        Navigator.pop(context);
      } else if(emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Enter your email or password!!')));
        Navigator.pop(context);
      }
    }
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
