import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/service_page.dart';
import 'package:manpower_management_app/screens/update_service_page.dart';

class service extends StatefulWidget {

  @override
  State<service> createState() => _serviceState();
}

class _serviceState extends State<service> {
  String _query = '';
  Future<List<QueryDocumentSnapshot>>? _futureServices;

  @override
  void initState() {
    super.initState();
    _futureServices = _getServices('');
  }

  Future<List<QueryDocumentSnapshot>> _getServices(String query) async{
    final firestore = FirebaseFirestore.instance;
    final servicesRef = firestore.collection('services');
    final snapshot = await servicesRef.get();

    final services = snapshot.docs
        .where((service) =>
    service['name'].toLowerCase().contains(query.toLowerCase()) ||
        service['description'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return services;
  }

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
              padding: const EdgeInsets.all(14.0),
              child: Theme(
                data: Theme.of(context).copyWith(splashColor: Colors.white),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _query = value;
                      _futureServices = _getServices(_query);
                    });
                  },
                  //style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                    hintText: "Search a service",
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              )),
          SizedBox(height: 10.0),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
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
            child: FutureBuilder<List<QueryDocumentSnapshot>>(
              future: _futureServices,
              builder: (BuildContext context,
                  AsyncSnapshot<List<QueryDocumentSnapshot>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final services = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    final service = services[index];
                    final name = service['name'];
                    final price = service['price'];
                    final image = service['image'];
                    final description = service['description'];
                    final code = service['code'] ?? '';
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
                                          code: code,
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