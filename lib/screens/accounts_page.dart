import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_register.dart';

class AccountsPage extends StatelessWidget {
  final String name;
  final String email;
  final String password;

  AccountsPage({required this.name, required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: $email',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Password: **********',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to update details page
                    },
                    child: Text('Update Details', style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(width: 4.0,),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to register new admin page
                      Navigator.push(context, MaterialPageRoute(builder:
                          (context) => AdminRegister()
                      ));
                    },
                    child: Text('Register New Admin', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
