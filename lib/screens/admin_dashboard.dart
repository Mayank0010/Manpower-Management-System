import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/available_workers.dart';
import 'package:manpower_management_app/screens/customers.dart';
import 'package:manpower_management_app/screens/orders_page.dart';
import 'package:manpower_management_app/screens/payment_history.dart';
import 'package:manpower_management_app/screens/product_screen.dart';
import 'package:manpower_management_app/screens/services.dart';
import 'package:manpower_management_app/services/admin_contact.dart';
import 'package:manpower_management_app/services/edit_profile.dart';
import 'package:manpower_management_app/services/notification_page.dart';
import 'package:manpower_management_app/services/products_services.dart';
import 'package:manpower_management_app/services/settings.dart';


class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var numberOfCustomerEntries = 0;
  var numberOfWorkerEntries = 0;
  var numberOfOrders = 0;

  void getSize() async {
    FirebaseFirestore.instance.collection('user_users').snapshots().listen((QuerySnapshot snapshot) {
      setState(() {
        numberOfCustomerEntries = snapshot.size;
      });
    });
    FirebaseFirestore.instance.collection('worker_users').snapshots().listen((QuerySnapshot snapshot) {
      setState(() {
        numberOfWorkerEntries = snapshot.size;
      });
    });
    FirebaseFirestore.instance.collection('service_booking').snapshots().listen((QuerySnapshot snapshot) {
      setState(() {
        numberOfOrders = snapshot.size;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: const Text('Admin Dashboard', style: TextStyle(
          color: Colors.white,
        ),),
      ),
        actions: [
          /*
          IconButton(
              onPressed: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
              icon: const Icon(Icons.search, color: Colors.white,)
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => AdminScreen()
              ));
            },
          ),
           */

          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white,),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:
                  (context) => NotificationsPage()
              ));
            },
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
              DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/im2.png'),
                        fit: BoxFit.fitHeight
                    ),
                  //color: Theme.of(context).primaryColor,
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
                title: const Text('Account', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => EditProfile()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.domain_verification,
                  size: 22,
                ),
                title: const Text('Workers', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => AvailableWorkersWidget()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 22,
                ),
                title: const Text('Customers', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => CustomerDetails()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.production_quantity_limits,
                  size: 22,
                ),
                title: const Text('Products', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => ProductScreen()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home_repair_service,
                  size: 22,
                ),
                title: const Text('Services', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => service()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_suggest,
                  size: 22,
                ),
                title: const Text('Suggest Products/Services', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => ProductsAndServicesScreen()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.contact_page,
                  size: 22,
                ),
                title: const Text('Contact', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => ContactPage()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.room_service,
                  size: 22,
                ),
                title: const Text('Orders', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
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
                title: const Text('Payment History', style: TextStyle(
                    fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
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
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => SettingsPage()
                  ));
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
                _buildCard(title: 'Users', value: numberOfCustomerEntries.toString()),
                _buildCard(title: 'Employees', value: numberOfWorkerEntries.toString()),
                _buildCard(title: 'Orders', value: numberOfOrders.toString()),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Top Orders',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('service_booking')
                  .orderBy('serviceTitle', descending: true).limit(6)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((
                      doc) => '${doc['serviceTitle']} \nPrice: ${doc['price']}')
                      .toList(),
                );
              },
            ),
            SizedBox(height: 32),
            Text(
              'Top Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('services').orderBy(
                  'name', descending: true).limit(6).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((
                      doc) => '${doc['name']}\nPrice: ${doc['price']}')
                      .toList(),
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
              stream: FirebaseFirestore.instance.collection('products').orderBy(
                  'name', descending: true).limit(6).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((
                      doc) => '${doc['name']}\nPrice: ${doc['price']}')
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffFBA013),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableList({required List<String> items}) {
    return Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 280,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffFBA013),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              items[index],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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