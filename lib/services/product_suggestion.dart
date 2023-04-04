import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WorkerProductsServices extends StatefulWidget {
  final String occupation;

  WorkerProductsServices({required this.occupation});

  @override
  _WorkerProductsServicesState createState() => _WorkerProductsServicesState();
}

class _WorkerProductsServicesState extends State<WorkerProductsServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products and Services for ${widget.occupation}'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Widget> productList = [];
          List<Widget> serviceList = [];

          snapshot.data!.docs.forEach((DocumentSnapshot document) {
            if (document['occupation'] == widget.occupation) {
              if (document['type'] == 'product') {
                productList.add(ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document['description']),
                ));
              } else if (document['type'] == 'service') {
                serviceList.add(ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document['description']),
                ));
              }
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Products:', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Column(children: productList),
                SizedBox(height: 20),
                Text('Services:', style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Column(children: serviceList),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
