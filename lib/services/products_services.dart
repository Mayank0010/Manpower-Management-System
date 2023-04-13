import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Worker {
  final String name;
  final String occupation;

  Worker({required this.name, required this.occupation});
}

final List<Worker> workers = [  Worker(name: 'John', occupation: 'Plumber'),  Worker(name: 'Alice', occupation: 'Electrician'),  Worker(name: 'Bob', occupation: 'Carpenter'),];

class ProductsAndServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products and Services Suggestion'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ProductList(occupation: 'Plumber'),
            SizedBox(height: 20),
            Text(
              'Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ServiceList(occupation: 'Plumber'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final String occupation;

  ProductList({required this.occupation});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Column(
          children: snapshot.data!.docs.map((doc) {
            return ListTile(
              title: Text(doc['name']),
              trailing: Text('\Rs. ${doc['price']}'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(doc['name']),
                      content: Text('Product: ${doc['name']}\nPrice: \Rs. ${doc['price']}'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class ServiceList extends StatelessWidget {
  final String occupation;

  ServiceList({required this.occupation});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('services').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Column(
          children: snapshot.data!.docs.map((doc) {
            return ListTile(
              title: Text(doc['name']),
              trailing: Text('\Rs. ${doc['price']}'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(doc['name']),
                      content: Text('Service: ${doc['name']}\nPrice: \Rs. ${doc['price']}'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
