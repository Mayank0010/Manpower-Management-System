import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final CollectionReference _adminDetailsRef =
  FirebaseFirestore.instance.collection('admin_users');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Flexible(
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _adminDetailsRef.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final adminDocs = snapshot.data!.docs;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: adminDocs.length,
                        itemBuilder: (context, index) {
                          var admin = adminDocs[index];
                          return Card(
                            child: ListTile(
                              title: Text(admin['name']),
                              subtitle: Text(admin['email']),
                              trailing: Text(admin['role']),
                            ),
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
