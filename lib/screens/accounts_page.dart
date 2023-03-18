import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_register.dart';

class AccountsPage extends StatefulWidget {
  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final User? _user = FirebaseAuth.instance.currentUser;

  String? _name;
  String? _phoneNumber;
  String? _role;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user?.uid)
        .get();

    if (userData.exists) {
      setState(() {
        _name = userData.get('name');
        _phoneNumber = userData.get('mobile');
        _role = userData.get('role');
      });
    }
  }


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
              'Name: $_name',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Email: ${_user?.email ?? ""}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Phone Number: $_phoneNumber',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Role: $_role',
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
