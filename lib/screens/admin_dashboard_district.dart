import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:manpower_management_app/screens/accounts_page_district.dart';
import 'package:manpower_management_app/screens/orders_page1.dart';
import 'package:manpower_management_app/screens/payment_history1.dart';
import 'package:manpower_management_app/screens/product_screen1.dart';
import 'package:manpower_management_app/screens/services1.dart';
import 'package:manpower_management_app/services/notification_page.dart';
import 'package:manpower_management_app/services/product_services_old.dart';
import 'package:manpower_management_app/services/workers_district.dart';


class AdminDashboardDistrict extends StatefulWidget {
  const AdminDashboardDistrict({Key? key}) : super(key: key);

  @override
  State<AdminDashboardDistrict> createState() => _AdminDashboardDistrictState();
}

class _AdminDashboardDistrictState extends State<AdminDashboardDistrict> {
  var numberOfEntries;
  var numberOfOrders;

  void getSize() async {
    FirebaseFirestore.instance.collection('admin_users').snapshots().listen((QuerySnapshot snapshot) {
      setState(() {
        numberOfEntries = snapshot.size;
      });
    });
    FirebaseFirestore.instance.collection('service_booking').snapshots().listen((QuerySnapshot snapshot) {
      setState(() {
        numberOfOrders = snapshot.size;
      });
    });
  }

  late List<charts.Series> _chartData;


  @override
  void initState() {
    super.initState();
    numberOfEntries = 0;
    numberOfOrders = 0;
    _chartData = [];
    _generateChartData();
    getSize();
  }


  List<charts.Series> _generateChartData() {
    var data = [
      {"date": DateTime(2022, 11, 11), "orders": 20},
      {"date": DateTime(2022, 11, 12), "orders": 15},
      {"date": DateTime(2022, 11, 13), "orders": 30},
      {"date": DateTime(2022, 11, 14), "orders": 25},
      {"date": DateTime(2022, 11, 15), "orders": 35},
      {"date": DateTime(2022, 11, 16), "orders": 10},
      {"date": DateTime(2022, 11, 17), "orders": 20},
    ];
    _chartData.add(
      charts.Series<Map<String, dynamic>, DateTime>(
        id: 'Orders',
        data: data,
        domainFn: (datum, index) => datum['date'] as DateTime,
        measureFn: (datum, index) => datum['orders'] as int,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (datum, index) => '${datum['orders']}',
      ),
    );

    return _chartData;
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
                      (context) => EditProfileDistrict()
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
                      (context) => WorkerListScreen1()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_suggest,
                  size: 22,
                ),
                title: const Text('Suggest Products/Services', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                  //(context) => AdminRegister()
                      (context) => ProductsAndServicesScreen1()
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
                _buildCard(title: 'Users', value: numberOfEntries.toString()),
                _buildCard(title: 'Employees', value: numberOfEntries.toString()),
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
            Center(
              child: ElevatedButton(
                  onPressed: _generateChartData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffF89669),
                ),
                  child: Text('Check Orders', style: TextStyle(color: Colors.white),),
              ),
            )
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