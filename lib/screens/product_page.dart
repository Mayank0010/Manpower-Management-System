import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var imageController = TextEditingController();
  var descController = TextEditingController();
  var quantityController = TextEditingController();
  var codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
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
                    'Add a new product',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product name';
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
                        return 'Please enter product price';
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
                        return 'Please enter a product image';
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
                        return 'Please enter a product description';
                      }
                      return null;
                    },
                    maxLines: 2,
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a product quantity';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 26.0),
                  TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Code',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a code';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 26.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add product logic here
                      try {
                        FirebaseFirestore.instance.collection('products').add({
                          'name': nameController.text,
                          'price': priceController.text,
                          'image': imageController.text,
                          'description': descController.text,
                          'quantity': quantityController.text,
                          'code': codeController.text,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Product added successfully')),
                        );
                        nameController.clear();
                        priceController.clear();
                        imageController.clear();
                        descController.clear();
                        quantityController.clear();
                        codeController.clear();
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to add product')),
                        );
                      }
                    },
                    child: Text('Add Product', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),),
          ),
        ),
      ),
    );
  }
}
