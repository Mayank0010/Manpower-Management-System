import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetailsPage1 extends StatefulWidget {
  @override
  _AccountDetailsPage1State createState() => _AccountDetailsPage1State();
}

class _AccountDetailsPage1State extends State<AccountDetailsPage1> {
  final CollectionReference _adminDetailsRef =
  FirebaseFirestore.instance.collection('admin_users');
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  List<String> _roleOrder = [    'Country Administrator',    'State Administrator',    'District Administrator',    'Local Administrator'  ];

  int _getRoleWeight(String role) {
    return _roleOrder.indexOf(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Details'),
        backgroundColor: Color(0xffF89669),
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
                      List<QueryDocumentSnapshot> adminDocs = snapshot.data!.docs;
                      adminDocs.sort((doc1, doc2) {
                        int weight1 = _getRoleWeight(doc1['role']);
                        int weight2 = _getRoleWeight(doc2['role']);
                        return weight1.compareTo(weight2);
                      });
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: adminDocs.length,
                        itemBuilder: (context, index) {
                          var admin = adminDocs[index];
                          return Card(
                            child: ListTile(
                              title: Text(admin['name']),
                              subtitle: Text(admin['role']),
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
