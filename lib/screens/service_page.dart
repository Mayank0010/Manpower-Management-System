import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var imageController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Add a new service',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Service Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a service name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter service price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter service image';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: descController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter service description';
                      }
                      return null;
                    },
                    maxLines: 2,
                  ),
                  SizedBox(height: 26.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add product logic here
                      try {
                        FirebaseFirestore.instance.collection('services').add({
                          'name': nameController.text,
                          'price': priceController.text,
                          'image': imageController.text,
                          'description': descController.text,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Service added successfully')),
                        );
                        nameController.clear();
                        priceController.clear();
                        imageController.clear();
                        descController.clear();

                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add service')),
                        );
                      }
                    },
                    child: Text('Add Service', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
