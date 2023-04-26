import 'package:carousel_slider/carousel_slider.dart';
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
              'Products and Services',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductCarousel(
                          occupation: 'Plumber',
                        ),
                      ),
                    );
                  },
                  child: Text('Suggest a Product', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceCarousel(
                          occupation: 'Plumber',
                        ),
                      ),
                    );
                  },
                  child: Text('Suggest a Service', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class ProductCarousel extends StatelessWidget {
  final String occupation;

  ProductCarousel({required this.occupation});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return CarouselSlider(
          options: CarouselOptions(
            height: 500,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              // TODO: add code to update the position indicator
            },
          ),
          items: snapshot.data!.docs.map((doc) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(doc['name']),
                          content: Text(
                              'Product: ${doc['name']}\nPrice: \Rs. ${doc['price']}'),
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
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(doc['name']),
                          SizedBox(height: 10),
                          Image.network(
                            doc['image'],
                            height: 300,
                            width: 300,
                          ),
                          SizedBox(height: 10),
                          Text('\Rs. ${doc['price']}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class ServiceCarousel extends StatelessWidget {
  final String occupation;

  ServiceCarousel({required this.occupation});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('services').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return CarouselSlider(
          options: CarouselOptions(
            height: 500,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            enableInfiniteScroll: true,
            onPageChanged: (index, reason) {
              // TODO: add code to update the position indicator
            },
          ),
          items: snapshot.data!.docs.map((doc) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(doc['name']),
                          content: Text(
                              'Product: ${doc['name']}\nPrice: \Rs. ${doc['price']}'),
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
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(doc['name']),
                          SizedBox(height: 10),
                          Image.network(
                            doc['image'],
                            height: 300,
                            width: 300,
                          ),
                          SizedBox(height: 10),
                          Text('\Rs. ${doc['price']}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
