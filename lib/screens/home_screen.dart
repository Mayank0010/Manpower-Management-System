import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_login.dart';
import 'package:manpower_management_app/authentication/admin_register.dart';
import 'package:manpower_management_app/authentication/auth.dart';
import 'package:manpower_management_app/authentication/employee_signup.dart';
import 'package:manpower_management_app/authentication/regstier.dart';
import 'package:manpower_management_app/authentication/login.dart';
import 'package:manpower_management_app/screens/admin_home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffF89669), Color(0xff91EBFF)])
        ),
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/im4.png', height: 400, width: 350,),
            Text('Order Services/Products', style: TextStyle(fontWeight: FontWeight.w600),),
            Text('Lets use our platform to order any service or product.', style: TextStyle(fontWeight: FontWeight.w400),),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:
                            //(context) => AdminRegister()
                            (context) => Auth()
                        ));
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(15)),
                        foregroundColor: Colors.black,
                          backgroundColor: Colors.blue,
                        side: BorderSide(color: Colors.black26),
                        padding: EdgeInsets.symmetric(vertical: 10)
                      ),
                      child: Text('Login', style: TextStyle(color: Colors.white),)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}