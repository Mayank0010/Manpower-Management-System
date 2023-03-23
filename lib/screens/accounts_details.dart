import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final CollectionReference _adminDetailsRef =
  FirebaseFirestore.instance.collection('admin_details');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  void updateAdminDetails(DocumentSnapshot doc) async {
    await _adminDetailsRef.doc(doc.id).update({
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
        title: Text('Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            StreamBuilder<QuerySnapshot>(
              stream: _adminDetailsRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final adminDocs = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: adminDocs.length,
                      itemBuilder: (context, index) {
                        var admin = adminDocs[index];
                        return ListTile(
                          leading: Text(admin['role']),
                          title: Text(admin['name']),
                          subtitle: Text(admin['email']),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _nameController.text = admin['name'];
                              _emailController.text = admin['email'];
                              _mobileController.text = admin['mobile'];
                              _roleController.text = admin['role'];
                              _addressController.text = admin['address'];
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Update Admin Details'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              labelText: 'Name',
                                            ),
                                          ),
                                          TextField(
                                            controller: _emailController,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                            ),
                                          ),
                                          TextField(
                                            controller: _mobileController,
                                            decoration: InputDecoration(
                                              labelText: 'Mobile',
                                            ),
                                          ),
                                          TextField(
                                            controller: _roleController,
                                            decoration: InputDecoration(
                                              labelText: 'Role',
                                            ),
                                          ),
                                          TextField(
                                            controller: _addressController,
                                            decoration: InputDecoration(
                                              labelText: 'Address',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Update'),
                                        onPressed: () {
                                          updateAdminDetails(admin);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
