import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/admin_dashboard.dart';
import 'package:manpower_management_app/screens/admin_dashboard_country.dart';
import 'package:manpower_management_app/screens/admin_dashboard_district.dart';
import 'package:manpower_management_app/screens/admin_dashboard_state.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference adminDetails =
    FirebaseFirestore.instance.collection('admin_users');
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Administration Role'),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false, // disables back button
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _signOut,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: StreamBuilder<DocumentSnapshot>(
          stream: adminDetails.doc(user!.uid).snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error fetching admin role.');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final adminRole = snapshot.data!.get('role').toLowerCase();
            final adminName = snapshot.data!.get('name');
            final availableRoles = ['local administrator', 'district administrator', 'state administrator', 'country administrator'];

            if (!availableRoles.contains(adminRole)) {
              return Text('You do not have permission to access this page.');
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                    'Welcome,  $adminName',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xffF6A611)),
                  ),
                Center(
                  child: Text(
                    'Select your role',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffF6A611)),
                  ),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        tileColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Center(
                          child: Text(
                            'Local Administrator',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (adminRole == 'local administrator') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboard()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('You do not have permission to access this page.'),
                            ));
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Center(
                          child: Text(
                            'District Administrator',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (adminRole == 'district administrator') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboardDistrict()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('You do not have permission to access this page.'),
                            ));
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title:
                        Center(
                          child: Text(
                            'State Administrator',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (adminRole == 'state administrator') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboardState()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('You do not have permission to access this page.'),
                            ));
                          }
                        },
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        tileColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        title: Center(
                          child: Text(
                            'Country Administrator',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          if (adminRole == 'country administrator') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminDashboardCountry()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('You do not have permission to access this page.'),
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: Text('Logout', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      //primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}