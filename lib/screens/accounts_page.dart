import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manpower_management_app/screens/accounts_details.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late CollectionReference _adminDetailsRef = _db.collection('admin_details');

  void _submitForm() async {
    // Retrieve the current user's email from the Firebase Authentication instance.
    String? userEmail = FirebaseAuth.instance.currentUser?.email;

    // Check if the current user's email is already in the database.
    QuerySnapshot querySnapshot = await _adminDetailsRef.where('email', isEqualTo: userEmail).get();

    if (querySnapshot.docs.isNotEmpty) {
      // Display an error message if the current user already exists in the database.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Admin account already exists for this user.')),
      );
    } else if (_nameController.text.isNotEmpty) {
      // Check if an admin with the same email already exists in the database.
      QuerySnapshot adminSnapshot = await _adminDetailsRef.where('email', isEqualTo: _emailController.text).get();

      if (adminSnapshot.docs.isNotEmpty) {
        // Display an error message if an admin with the same email already exists in the database.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Admin account already exists with this email.')),
        );
      } else {
        // Add a new record if the current user does not exist in the database.
        await _adminDetailsRef.add({
          'name': _nameController.text,
          'email': _emailController.text,
          'mobile': _mobileController.text,
          'role': _roleController.text,
          'address': _addressController.text,
        });
        _nameController.clear();
        _emailController.clear();
        _mobileController.clear();
        _roleController.clear();
        _addressController.clear();
      }
    }
  }

  void _updateAdmin(String id) async {
    await _adminDetailsRef.doc(id).update({
      'name': _nameController.text,
      'email': _emailController.text,
      'mobile': _mobileController.text,
      'role': _roleController.text,
      'address': _addressController.text,
    });
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _roleController.clear();
    _addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 6.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 6.0),
            TextFormField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            SizedBox(height: 6.0),
            TextFormField(
              controller: _roleController,
              decoration: InputDecoration(labelText: 'Role'),
            ),
            SizedBox(height: 6.0),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 6.0),
            ElevatedButton(
              child: Text('Save', style: TextStyle(color: Colors.white),),
              onPressed: () {
                _submitForm();
              },
            ),
            SizedBox(height: 5.0,),
            ElevatedButton(
              child: Text('Show admin details', style: TextStyle(color: Colors.white),),
              onPressed: () {
                User? user = FirebaseAuth.instance.currentUser;
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => AccountDetailsPage()
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}