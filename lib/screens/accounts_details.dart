import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountDetailsPage extends StatefulWidget {
  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final CollectionReference _adminDetailsRef =
  FirebaseFirestore.instance.collection('admin_users');

  List<String> _roleOrder = [
    'Country Administrator',
    'State Administrator',
    'District Administrator',
    'Local Administrator'
  ];

  int _getRoleWeight(String role) {
    return _roleOrder.indexOf(role);
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _adminDetailsRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> adminDocs = snapshot.data!.docs;
                    adminDocs.sort((doc1, doc2) {
                      int weight1 = _getRoleWeight(doc1['role'].toUpperCase());
                      int weight2 = _getRoleWeight(doc2['role'].toUpperCase());
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
                            subtitle: Text(admin['role'].toUpperCase()),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
