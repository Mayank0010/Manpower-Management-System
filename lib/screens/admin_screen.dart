import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/admin_dashboard.dart';
import 'package:manpower_management_app/screens/admin_dashboard1.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false, // disables back button
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select an option:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Center(
              child: DropdownButton<String>(
                value: null,
                hint: Center(child: Text('Select your role: ')),
                onChanged: (value) {
                  switch (value) {
                    case 'CEO':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDashboard()),
                      );
                      break;
                    case 'CMO':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDashboard1()),
                      );
                      break;
                    case 'CTO':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDashboard1()),
                      );
                      break;
                  }
                },
                items: <String>[
                  'CEO',
                  'CMO',
                  'CTO',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
