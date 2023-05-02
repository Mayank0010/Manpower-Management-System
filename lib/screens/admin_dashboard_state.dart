import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/accounts_page_state.dart';
import 'package:manpower_management_app/screens/orders_page1.dart';
import 'package:manpower_management_app/screens/payment_history1.dart';
import 'package:manpower_management_app/screens/product_screen1.dart';
import 'package:manpower_management_app/screens/services1.dart';
import 'package:manpower_management_app/services/notification_page.dart';
import 'package:manpower_management_app/services/workers_state.dart';


class AdminDashboardState extends StatefulWidget {
  const AdminDashboardState({Key? key}) : super(key: key);

  @override
  State<AdminDashboardState> createState() => _AdminDashboardStateState();
}

class _AdminDashboardStateState extends State<AdminDashboardState> {
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
        backgroundColor: Color(0xffF89669),
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
                      (context) => EditProfileStates()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.production_quantity_limits,
                  size: 22,
                ),
                title: const Text('Products', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                  //(context) => AdminRegister()
                      (context) => ProductScreen1()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home_repair_service,
                  size: 22,
                ),
                title: const Text('Services', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => service1()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.work,
                  size: 22,
                ),
                title: const Text('Available Workers', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => WorkerListScreen()
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
                      (context) => Orders1()
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
                      (context) => PaymentHistoryList1()
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
              stream: FirebaseFirestore.instance.collection('service_booking').orderBy('serviceTitle', descending: true).limit(6).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((doc) => '${doc['serviceTitle']} \nPrice: ${doc['price']}').toList(),
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
              stream: FirebaseFirestore.instance.collection('services').orderBy('name', descending: true).limit(6).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return _buildScrollableList(
                  items: snapshot.data!.docs.map((doc) => '${doc['name']}\nPrice: ${doc['price']}').toList(),
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
                  items: snapshot.data!.docs.map((doc) => '${doc['name']}\nPrice: ${doc['price']}').toList(),
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
        color: Color(0xffF89669),
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
              color: Color(0xffF89669),
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