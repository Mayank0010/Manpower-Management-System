import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateProductPage extends StatefulWidget {
  final String name;
  final String description;
  final String price;
  final String image;
  final String quantity;
  final String code;
  final DocumentReference reference;

  UpdateProductPage({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
    required this.code,
    required this.reference,
  });

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageController;
  late TextEditingController _quantityController;
  late TextEditingController _codeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _descriptionController = TextEditingController(text: widget.description);
    _priceController = TextEditingController(text: widget.price);
    _imageController = TextEditingController(text: widget.image);
    _quantityController = TextEditingController(text: widget.quantity);
    _codeController = TextEditingController(text: widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _quantityController,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter quantity';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _codeController,
                decoration: InputDecoration(
                  labelText: 'Code',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.reference.update({
                      'name': _nameController.text,
                      'description': _descriptionController.text,
                      'price': _priceController.text,
                      'image': _imageController.text,
                      'quantity': _quantityController.text,
                      'code': _codeController.text,
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Update Product', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    _quantityController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}
