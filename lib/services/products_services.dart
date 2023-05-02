import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsAndServicesScreen extends StatefulWidget {
  @override
  State<ProductsAndServicesScreen> createState() => _ProductsAndServicesScreenState();
}

class _ProductsAndServicesScreenState extends State<ProductsAndServicesScreen> {
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
                        builder: (context) => ProductCarousel(),
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
                        builder: (context) => ServiceCarousel(),
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FutureBuilder<List<Widget>>(
          future: _buildCarouselItems(snapshot.data!.docs),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
              items: snapshot.data!,
            );
          },
        );
      },
    );
  }

  Future<List<Widget>> _buildCarouselItems(
      List<QueryDocumentSnapshot> docs) async {
    List<Widget> items = [];

    for (var doc in docs) {
      final String workerCode = doc['code'];

      // Retrieve all worker users whose occupation matches the code field in the product document
      final QuerySnapshot workerUsersQuerySnapshot =
      await FirebaseFirestore.instance
          .collection('worker_users')
          .where('occupation', isEqualTo: workerCode)
          .get();

      List<String> workerNames = [];

      for (var workerDoc in workerUsersQuerySnapshot.docs) {
        workerNames.add(workerDoc['name']);
      }

      if (workerNames.isEmpty) {
        continue; // Skip this product if no matching worker users are found
      }

      String workerNamesString = workerNames.join(', ');

      items.add(
        Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(doc['name']),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${doc['name']}'),
                          SizedBox(height: 10),
                          Text('Price: \Rs. ${doc['price']}'),
                          SizedBox(height: 10),
                          Text('Workers: $workerNamesString'),
                        ],
                      ),
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
        ),
      );
    }

    return items;
  }
}


class ServiceCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('services').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return FutureBuilder<List<Widget>>(
          future: _buildCarouselItems(snapshot.data!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
              items: snapshot.data!,
            );
          },
        );
      },
    );
  }

  Future<List<Widget>> _buildCarouselItems(QuerySnapshot snapshot) async {
    List<Widget> items = [];

    for (var doc in snapshot.docs) {
      final String workerCode = doc['code'];

      // Retrieve the worker users whose occupation matches the code field in the product document
      final QuerySnapshot workerUsersQuerySnapshot =
      await FirebaseFirestore.instance
          .collection('worker_users')
          .where('occupation', isEqualTo: workerCode)
          .get();

      if (workerUsersQuerySnapshot.docs.isEmpty) {
        continue; // Skip this product if no matching worker user is found
      }

      List<String> workerNames = workerUsersQuerySnapshot.docs.map((doc) => doc['name'].toString()).toList();

      items.add(
        Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(doc['name']),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Product: ${doc['name']}'),
                          SizedBox(height: 10),
                          Text('Price: \Rs. ${doc['price']}'),
                          SizedBox(height: 10),
                          Text('Workers: ${workerNames.join(', ')}'),
                        ],
                      ),
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
        ),
      );
    }

    return items;
  }
}
