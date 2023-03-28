import 'package:flutter/material.dart';

class CustomerDetails extends StatefulWidget {
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final List<Map<String, dynamic>> customerList = [
    {
      'name': 'Bob',
      'email': 'bob@example.com',
      'mobile': '555-5678',
      'photo': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Alice',
      'email': 'alice@example.com',
      'mobile': '555-1234',
      'photo': 'https://via.placeholder.com/150'
    },
    {
      'name': 'John',
      'email': 'john@example.com',
      'mobile': '555-4321',
      'photo': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Jane',
      'email': 'jane@example.com',
      'mobile': '555-8765',
      'photo': 'https://via.placeholder.com/150'
    },
  ];

  List<Map<String, dynamic>> filteredCustomers = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCustomers = customerList;
  }

  void filterCustomers(String query) {
    List<Map<String, dynamic>> filteredList = [];
    customerList.forEach((customer) {
      if (customer['name'].toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(customer);
      }
    });
    setState(() {
      filteredCustomers = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                filterCustomers(value);
              },
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                labelText: 'Search for a customer..',
                suffixIcon: Icon(Icons.search),
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
                itemCount: filteredCustomers.length,
                itemBuilder: (context, index) {
                  final customer = filteredCustomers[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) =>
                            CustomerDetailsPage(customer: customer),
                      ));
                    },
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(customer['photo']),
                        ),
                        title: Text(customer['name']),
                        subtitle: Text(customer['email']),
                        trailing: Text(customer['mobile']),
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


class CustomerDetailsPage extends StatelessWidget {
  final Map<String, dynamic> customer;

  CustomerDetailsPage({required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(customer['photo']),
            ),
            SizedBox(height: 16.0),
            Text(
              customer['name'],
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Email: ${customer['email']}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Mobile: ${customer['mobile']}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}