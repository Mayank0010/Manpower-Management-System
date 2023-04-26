import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDetails extends StatefulWidget {
  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  List<DocumentSnapshot<Map<String, dynamic>>> availableCustomers = [];
  List<DocumentSnapshot<Map<String, dynamic>>> searchedCustomers = [];

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  void _fetchCustomers() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('user_users').get();
    setState(() {
      availableCustomers = List.from(querySnapshot.docs);
      searchedCustomers = List.from(querySnapshot.docs);
    });
  }

  void _filterCustomers(String value) {
    setState(() {
      searchedCustomers = availableCustomers
          .where((customer) =>
          customer
              .data()!['name']
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: 'Search for customer..',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              onChanged: (value) => _filterCustomers(value),
            ),
          ),
          Expanded(
            child: searchedCustomers.isEmpty
                ? Center(child: Text('No customers found'))
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: searchedCustomers.length,
                itemBuilder: (context, index) {
                  final customer = searchedCustomers[index].data();

                  return InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            CustomerDetailsPage(customer: searchedCustomers[index]),
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(customer!['name']),
                        subtitle: Text(customer!['email']),
                        trailing: Icon(Icons.arrow_forward),
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

class CustomerDetailsPage extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> customer;

  CustomerDetailsPage({required this.customer});

  @override
  _CustomerDetailsPageState createState() => _CustomerDetailsPageState();
}

class _CustomerDetailsPageState extends State<CustomerDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  late String name;
  late String email;
  late String mobile;
  late String age;
  late String address;
  late String state;
  late String pincode;
  late String country;

  @override
  void initState() {
    super.initState();
    final customerData = widget.customer.data()!;
    name = customerData['name'];
    email = customerData['email'];
    mobile = customerData['mobile'];
    age = customerData['age'];
    address = customerData['address'];
    state = customerData['state'];
    pincode = customerData['pincode'];
    country = customerData['country'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: name,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: email,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: mobile,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                  ),
                  onSaved: (value) => mobile = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: age,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Age',
                  ),
                  onSaved: (value) => age = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an age';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: address,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Address',
                  ),
                  onSaved: (value) => address = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: state,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'State',
                  ),
                  onSaved: (value) => state = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a state';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: pincode,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Pincode',
                  ),
                  onSaved: (value) => pincode = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a pincode';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  initialValue: country,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Country',
                  ),
                  onSaved: (value) => country = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a country';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
