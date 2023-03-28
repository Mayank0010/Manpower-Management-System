import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manpower_management_app/screens/accounts_details.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
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
  }

  Future<void> _getImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              InkWell(
                onTap: _getImage,
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
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                ),
              ),
              SizedBox(height: 16.0),
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
              SizedBox(height: 32.0),
              ElevatedButton(
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
              SizedBox(height: 10.0,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => AccountDetailsPage()
                ));
              }, child: Text('Show all admins', style: TextStyle(color: Colors.white),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
