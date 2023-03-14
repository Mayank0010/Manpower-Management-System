import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

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
          title: Text('Forgot Password'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed: (){

              },
            )
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              children: [
                SizedBox(height: 150.0,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Enter email address'),
                  onChanged: (value) {
                    setState(() {
                      value.trim();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 250.0,),
                    OutlinedButton(onPressed: () {},
                        child: Text('Continue', style: TextStyle(color: Colors.white),),
                      autofocus: true,
                    )
                  ],
                )
              ],
            ),
      ),
      ),
    );
  }
}