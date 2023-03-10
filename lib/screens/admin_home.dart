import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/orders_page.dart';
import 'package:manpower_management_app/screens/product_page.dart';
import 'package:manpower_management_app/screens/product_screen.dart';
import 'package:manpower_management_app/screens/services.dart';
import 'package:manpower_management_app/screens/worker_verification.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
        child: const Text('Admin Dashboard', style: TextStyle(
          color: Colors.white,
        ),),
      ),
      actions: [
        IconButton(onPressed: (){
          showSearch(context: context, delegate: CustomSearchDelegate());
        },
            icon: const Icon(Icons.search, color: Colors.white,))
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
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
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
          title: const Text('Account'),
          onTap: () {
            // Update the state of the app
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
              ListTile(
                leading: Icon(
                  Icons.production_quantity_limits,
                  size: 22,
                ),
                title: const Text('Products'),
                onTap: () {
                  // Update the state of the app
                  // Then close the drawer
                  Navigator.push(context, MaterialPageRoute(builder:
                  //(context) => AdminRegister()
                      (context) => ProductsPage()
                  ));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.home_repair_service,
                  size: 22,
                ),
                title: const Text('Services'),
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
                title: const Text('Orders'),
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
                title: const Text('Worker Verification'),
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
                title: const Text('Payment History'),
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
                title: const Text('Logout'),
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
      body: Wrap(
        children:
        [
          Image(
              image: AssetImage('assets/images/10.jpg')
          ),
        Container(
          height: 10,
        ),
        Row(
          children: [
            Card(
              shadowColor: Colors.orange,
            elevation: 12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 140,
                  width:113,
                  child: Center(child: Text('Users', style: TextStyle(fontWeight: FontWeight.w500, fontFamily:'Roboto'),))
              ),
            ),
          ),
            Card(
              shadowColor: Colors.orange,
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 140,
                    width:113,
                    child: Center(child: Text('Workers', style: TextStyle(fontWeight: FontWeight.w500, fontFamily:'Roboto'),))
                ),
              ),
            ),
            Card(
              shadowColor: Colors.orange,
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 140,
                    width:113,
                    child: Center(child: Text('Orders', style: TextStyle(fontWeight: FontWeight.w500, fontFamily:'Roboto'),))
                ),
              ),
            )
    ],
        ),
          Container(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 270,
              width: 104,
              color: Colors.red,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
                  shadowColor: Colors.orange,
                  elevation: 12,
                  color: Colors.orange.shade400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Services', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Colors.white),),
                      Text('Cleaning', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                      Text('Car Wash', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                      Text('Plumbing', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 270,
              width: 104,
              color: Colors.red,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
                  shadowColor: Colors.orange,
                  elevation: 12,
                  color: Colors.orange.shade400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Users', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Colors.white),),
                      Text('User 1', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                      Text('User 2', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                      Text('User 3', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 270,
              width: 104,
              color: Colors.red,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Card(
                  shadowColor: Colors.orange,
                  elevation: 12,
                  color: Colors.orange.shade400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Workers', style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Roboto', color: Colors.white),),
                      Text('Worker 1', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                      Text('Worker 2', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                      Text('Worker 3', style: TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Roboto', color: Colors.white),),
                    ],
                  ),
                ),
              ),
            ),
          )
    ],
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
    'customer'
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