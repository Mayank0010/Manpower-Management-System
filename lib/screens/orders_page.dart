import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'date': '2022-03-08',
      'price': '59.99',
      'services': 'Car wash, oil change',
      'products': 'Engine oil, air filter',
      'discount': '10% off'
    },
    {
      'date': '2022-03-07',
      'price': '34.99',
      'services': 'Haircut',
      'products': '',
      'discount': ''
    },
    {
      'date': '2022-03-06',
      'price': '129.99',
      'services': 'Massage, facial',
      'products': '',
      'discount': '20% off'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Container(
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (ctx, index) {
          return Card(
            child: ListTile(
              leading: Text('${orders[index]['price']}'),
              title: Text(orders[index]['services']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${orders[index]['date']}'),
                  Text('Products: ${orders[index]['products']}'),
                  Text('Discount: ${orders[index]['discount']}'),
                ],
              ),
            ),
          );
        },
      ),
      ),
    );
  }
}
