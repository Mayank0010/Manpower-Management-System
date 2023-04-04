import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manpower_management_app/authentication/signup1.dart';
import 'package:manpower_management_app/authentication/signup3.dart';
import 'package:manpower_management_app/screens/accounts_details.dart';

class EditProfileCountry extends StatefulWidget {
  @override
  _EditProfileCountryState createState() => _EditProfileCountryState();
}

class _EditProfileCountryState extends State<EditProfileCountry> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  File? _image;
  //bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    User? user = _auth.currentUser;
    DocumentSnapshot userData =
    await _db.collection('admin_users').doc(user!.uid).get();
    _nameController.text = userData['name'];
    _emailController.text = userData['email'];
    _mobileController.text = userData['mobile'];
    _roleController.text = userData['role'];
    _stateController.text = userData['state'] ?? '';
    _pincodeController.text = userData['pincode'] ?? '';
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImageToStorage() async {
    if (_image != null) {
      final ref = _storage.ref().child(
          'profile_pictures/${_auth.currentUser!.uid}');
      final task = ref.putFile(_image!);
      final snapshot = await task.whenComplete(() {});
      final url = await snapshot.ref.getDownloadURL();
      return url;
    }
    return '';
  }

  Future<void> _showChangePasswordDialog() async {
    final email = _emailController.text;
    await _auth.sendPasswordResetEmail(email: email);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Change Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("An email has been sent to $email with instructions on how to change your password."),
            ],
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'create_state_admin':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage2()),
        );
        break;
      case 'show_all_admin':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountDetailsPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Create State Admin"),
                value: "create_admin",
              ),
              PopupMenuItem(
                child: Text("Show All Admins"),
                value: "show_admins",
              ),
            ],
            onSelected: (value) {
              if (value == "create_admin") {
                // TODO: implement create state admin functionality
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => SignupPage2()
                ));

              } else if (value == "show_admins") {
                // TODO: implement show all admins functionality
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => AccountDetailsPage()
                ));
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Choose an option"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _getImage(ImageSource.camera);
                            },
                            child: Text("Take Photo"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _getImage(ImageSource.gallery);
                            },
                            child: Text("Choose from Gallery"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                    Icons.camera_alt,
                    size: 40,
                  )
                      : null,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(
                  labelText: 'Role',
                ),
              ),
/*
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
              ),
               */
              SizedBox(height: 10.0),
              TextFormField(
                controller: _pincodeController,
                decoration: InputDecoration(
                  labelText: 'Pincode',
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'State',
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final imageUrl = await _uploadImageToStorage();
                        await _db
                            .collection('admin_users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update
                          ({
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'mobile': _mobileController.text,
                          'role': _roleController.text,
                          'pincode': _pincodeController.text,
                          'state': _stateController.text,
                          'profile_picture': imageUrl,
                        });
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                          content: Text('Changes Saved!!'),
                          backgroundColor: Colors.orange,

                        ));
                      },
                      child: Text('Save Changes', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _showChangePasswordDialog();
                      },
                      child: Text(
                        'Change Password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
