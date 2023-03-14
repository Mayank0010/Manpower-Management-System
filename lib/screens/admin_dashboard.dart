import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/accounts_page.dart';
import 'package:manpower_management_app/screens/orders_page.dart';
import 'package:manpower_management_app/screens/payment_history.dart';
import 'package:manpower_management_app/screens/product-page.dart';
import 'package:manpower_management_app/screens/product_page.dart';
import 'package:manpower_management_app/screens/product_screen.dart';
import 'package:manpower_management_app/screens/services.dart';
import 'package:manpower_management_app/screens/worker_verification.dart';


class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {

  int _currentIndex = 0;
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
                      (context) => AccountsPage(name: 'John Doe', email: 'johndoe@example.com', password: 'password123')
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
                      (context) => ProductScreen()
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
                      (context) => service()
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
                  Icons.verified,
                  size: 22,
                ),
                title: const Text('Worker Verification', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => WorkerVerificationPage()
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
              ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 22,
                ),
                title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Roboto'),),
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
            _buildScrollableList(
              items: [
                'Order 1',
                'Order 2',
                'Order 3',
                'Order 4',
                'Order 5',
                'Order 6',
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Top Services',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildScrollableList(
              items: [
                'Service 1',
                'Service 2',
                'Service 3',
                'Service 4',
                'Service 5',
                'Service 6',
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Top Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildScrollableList(
              items: [
                'Product 1',
                'Product 2',
                'Product 3',
                'Product 4',
                'Product 5',
                'Product 6',
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        backgroundColor: Color(0xffFBA013),
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Orders',
          ),
        ],
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
    return Container(
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