import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/authentication/admin_login.dart';
import 'package:manpower_management_app/screens/accounts_page.dart';
import 'package:manpower_management_app/screens/accounts_page_country.dart';
import 'package:manpower_management_app/screens/accounts_page_district.dart';
import 'package:manpower_management_app/screens/accounts_page_state.dart';
import 'package:manpower_management_app/screens/available_workers.dart';
import 'package:manpower_management_app/screens/customers.dart';
import 'package:manpower_management_app/screens/orders_page.dart';
import 'package:manpower_management_app/screens/payment_history.dart';
import 'package:manpower_management_app/screens/product-page.dart';
import 'package:manpower_management_app/screens/product_page.dart';
import 'package:manpower_management_app/screens/product_screen.dart';
import 'package:manpower_management_app/screens/product_screen1.dart';
import 'package:manpower_management_app/screens/services.dart';
import 'package:manpower_management_app/screens/services1.dart';
import 'package:manpower_management_app/screens/worker_verification.dart';
import 'package:manpower_management_app/services/edit_profile.dart';


class AdminDashboardCountry extends StatefulWidget {
  const AdminDashboardCountry({Key? key}) : super(key: key);

  @override
  State<AdminDashboardCountry> createState() => _AdminDashboardCountryState();
}

class _AdminDashboardCountryState extends State<AdminDashboardCountry> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: const Text('Admin Dashboard', style: TextStyle(
          color: Colors.white,
        ),),
      ),
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
              icon: const Icon(Icons.search, color: Colors.white,)),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {},
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 25, // Changing Drawer Icon Size
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations
                  .of(context)
                  .openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white, //desired color
        ),
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/im2.png'),
                        fit: BoxFit.fitHeight
                    )
                  //color: Colors.orange,
                ),
                child: Text('', style: TextStyle(
                  color: Colors.white,
                ),),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box,
                  size: 22,
                ),
                title: const Text('Account', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                  //(context) => AdminRegister()
                      (context) => EditProfileCountry()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.room_service,
                  size: 22,
                ),
                title: const Text('Orders', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => Orders()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.payment,
                  size: 22,
                ),
                title: const Text('Payment History', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => PaymentHistoryList()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 22,
                ),
                title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCard(title: 'Users', value: '120'),
                _buildCard(title: 'Employees', value: '15'),
                _buildCard(title: 'Orders', value: '450'),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Top Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('service_booking').orderBy('serviceTitle', descending: true).limit(6).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((doc) => 'Title: ${doc['serviceTitle']} \nPrice: ${doc['price']}').toList(),
                );
              },
            ),
            SizedBox(height: 32),
            Text(
              'Top Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('services').orderBy('name', descending: true).limit(6).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((doc) => 'Name: ${doc['name']}\nPrice: ${doc['price']}').toList(),
                );
              },
            ),
            SizedBox(height: 32),
            Text(
              'Top Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('products').orderBy('name', descending: true).limit(6).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((doc) => 'Name: ${doc['name']}\nPrice: ${doc['price']}').toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String value}) {
    return Card(
      color: Color(0xffFBA013),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white)),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableList({required List<String> items}) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white60,
            margin: EdgeInsets.only(right: 16),
            child: Card(
              color: Color(0xffFBA013),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(items[index], style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerms = [
    'product',
    'service',
    'user',
    'employee',
    'order',
    'verification',
    'payment',
    'history',
    'worker',
    'customer',
    'home',
    'cleaning'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(onPressed: () {
        close(context, null);
      }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in searchTerms) {
      if(item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in searchTerms) {
      if(item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}