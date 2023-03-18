import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/product_page.dart';
import 'package:manpower_management_app/screens/service_page.dart';
import 'package:manpower_management_app/screens/update_service_page.dart';

class service extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search for services...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
          ),
          SizedBox(height: 16.0),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:
                            (context) => ServicesPage()
                        ));
                      },
                      icon: Icon(Icons.add, color: Colors.white,),
                      label: Text('Add', style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('services').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final services = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    final service = services[index];
                    final name = service['name'];
                    final price = service['price'];
                    final image = service['image'];
                    final description = service['description'];
                    final reference = service.reference;

                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update or Delete Service'),
                              content: Text('What would you like to do with this service?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(builder:
                                        (context) => UpdateServicePage(
                                          name: name,
                                          price: price,
                                          image: image,
                                          description: description,
                                          reference: reference,
                                        )
                                    ));
                                  },
                                  child: Text('Update'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await reference.delete();
                                    Navigator.pop(context);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.shopping_basket),
                              title: Text(name),
                              subtitle: Text(description),
                              trailing: Text(price),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('services').where('name', isGreaterThanOrEqualTo: query).where('name', isLessThan: query + 'z').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final results = snapshot.data!.docs;
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              title: Text(result['name']),
              onTap: () {
                // do something when the result is tapped
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('services').where('name', isGreaterThanOrEqualTo: query).where('name', isLessThan: query + 'z').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final results = snapshot.data!.docs;
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              title: Text(result['name']),
              onTap: () {
                query = result['name'];
                showResults(context);
              },
            );
          },
        );
      },
    );
  }
}