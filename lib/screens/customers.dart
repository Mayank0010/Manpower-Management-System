import 'package:flutter/material.dart';

class CustomerDetails extends StatelessWidget {
  final List<Map<String, dynamic>> customerList = [
    {      'name': 'John Doe',      'email': 'johndoe@example.com',      'mobile': '555-1234',      'photo': 'https://via.placeholder.com/150'    },
    {      'name': 'Jane',      'email': 'jane@example.com',      'mobile': '555-5678',      'photo': 'https://via.placeholder.com/150'    },
    {      'name': 'Alice',      'email': 'alice@example.com',      'mobile': '555-5678',      'photo': 'https://via.placeholder.com/150'    },
    {      'name': 'Bob',      'email': 'bob@example.com',      'mobile': '555-5678',      'photo': 'https://via.placeholder.com/150'    },
    //add more customers here
   ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Customer Details'),
    ),
    body: ListView.builder(
      itemCount: customerList.length,
      itemBuilder: (context, index) {
        final customer = customerList[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(customer['photo']),
            ),
            title: Text(customer['name']),
            subtitle: Text(customer['email']),
            trailing: Text(customer['mobile']),
          ),
        );
      },
    ),
  );
}
}
