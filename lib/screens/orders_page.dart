import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
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

  List<Map<String, dynamic>> filteredOrders = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredOrders = orders;
  }

  void _filterOrders(value) {
    setState(() {
      filteredOrders = orders.where((order) => order['services'].toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: _searchController,
                onChanged: (value) => _filterOrders(value),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                  suffixIcon: Icon(Icons.search),
                  hintText: 'Search for order',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: ListTile(
                      leading: Text(
                        '${filteredOrders[index]['price']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      title: Text(
                        filteredOrders[index]['services'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${filteredOrders[index]['date']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Products: ${filteredOrders[index]['products']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Discount: ${filteredOrders[index]['discount']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Customer: ${filteredOrders[index]['customer']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Worker: ${filteredOrders[index]['worker']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
