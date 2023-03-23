import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'date': '2022-03-08',
      'price': '59',
      'services': 'Car wash, oil change',
      'products': 'Engine oil, air filter',
      'discount': '10% off',
      'customer' : 'Alice',
      'worker' : 'Bob',
    },
    {
      'date': '2022-03-07',
      'price': '65',
      'services': 'Haircut',
      'products': '',
      'discount': '',
      'customer' : 'Alice',
      'worker' : 'Bob',
    },
    {
      'date': '2022-03-06',
      'price': '129',
      'services': 'Massage, facial',
      'products': '',
      'discount': '20% off',
      'customer' : 'Alice',
      'worker' : 'Bob',
    },
    {
      'date': '2022-01-12',
      'price': '1000',
      'services': 'Pest Control',
      'products': '',
      'discount': '',
      'customer' : 'Alice',
      'worker' : 'Bob',
    },
    {
      'date': '2023-03-15',
      'price': '505',
      'services': 'Cleaning',
      'products': '',
      'discount': '',
      'customer' : 'Alice',
      'worker' : 'Bob',
    },
    {
      'date': '2023-02-04',
      'price': '350',
      'services': 'Plumbing',
      'products': '',
      'discount': '',
      'customer' : 'Alice',
      'worker' : 'Bob',
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
              leading: Text(
                '${orders[index]['price']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              title: Text(
                orders[index]['services'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${orders[index]['date']}', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text('Products: ${orders[index]['products']}', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text('Discount: ${orders[index]['discount']}', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text('Customer: ${orders[index]['customer']}', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text('Worker: ${orders[index]['worker']}', style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
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
