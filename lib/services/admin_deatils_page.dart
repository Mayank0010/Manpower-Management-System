import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDetailsPage extends StatelessWidget {
  final String adminId;

  AdminDetailsPage({required this.adminId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Details'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('admin_users')
            .doc(adminId)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var adminData = snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('Name'),
                subtitle: Text(adminData['name']),
              ),
              ListTile(
                title: Text('Email'),
                subtitle: Text(adminData['email']),
              ),
              ListTile(
                title: Text('Mobile'),
                subtitle: Text(adminData['mobile']),
              ),
              ListTile(
                title: Text('Role'),
                subtitle: Text(adminData['role']),
              ),
            ],
          );
        },
      ),
    );
  }
}
