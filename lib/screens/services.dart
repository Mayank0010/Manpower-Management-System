import 'package:flutter/material.dart';
import 'package:manpower_management_app/screens/service_page.dart';

class service extends StatefulWidget {
  @override
  _serviceState createState() => _serviceState();
}

class _serviceState extends State<service> {
  final List<String> items = List.generate(100, (index) => "Item $index");
  String _searchText = "";
  final List<CardData> cardList = [
    CardData(
      title: 'Appliance',
      subtitle: 'Install or repair home appliances, including refrigerators, ovens, and more.',
      imageUrl: 'https://www.shutterstock.com/image-vector/happy-servicemen-repairing-machines-home-260nw-1680158476.jpg',
    ),
    CardData(
      title: 'Shifting',
      subtitle: 'Help you move your belongings from one home to another',
      imageUrl: 'https://www.movingsolutions.in/blog/wp-content/uploads/2019/01/moving-solutions-general-pic.jpg',
    ),
    CardData(
      title: 'Cleaning',
      subtitle: 'Deep clean your home, including carpets, windows, and more',
      imageUrl: 'https://www.rslauctions.com/wp-content/uploads/2022/03/4.jpg',
    ),
    CardData(
      title: 'Cook',
      subtitle: 'Book a professional Cook, Chef for Daily Basis, Breakfast, Lunch, Dinner at Home. ',
      imageUrl: 'https://cloudkitchens.com/static/cloud-kitchens-8e43e46a69402745a44dc25ebf6013fd.jpg',
    ),
    CardData(
      title: 'Plumbing',
      subtitle: 'Fix leaky faucets, clogged toilets, and more',
      imageUrl: 'https://api.gharpedia.com/wp-content/uploads/2018/08/0602030005-01-Plumbers.jpg',
    ),
    CardData(
      title: 'Electricals',
      subtitle: 'Install lighting fixtures, repair faulty wiring, and more',
      imageUrl: 'https://b727754.smushcdn.com/727754/wp-content/uploads/2020/06/iStock-1165561132-res.jpg?lossy=0&strip=1&webp=1',
    ),
    CardData(
      title: 'Painting',
      subtitle: 'Paint the interior or exterior of your home',
      imageUrl: 'https://www.nobroker.in/blog/wp-content/uploads/2022/08/Painting-Services-In-Hebbal.jpg',
    ),
    CardData(
      title: 'Carpentry',
      subtitle: 'Build custom furniture, repair damaged cabinets, and more.',
      imageUrl: 'https://www.hnhmaintenance.com/wp-content/uploads/2022/04/Carpenter.jpg',
    ),
    CardData(
      title: 'Roofing',
      subtitle: 'Install or repair shingles, tiles, and other roofing materials.',
      imageUrl: 'https://www.mywaterfrontteam.com/uploads/1/1/8/9/118920650/editor/dji-0832.jpg?1605278061',
    ),
    CardData(
      title: 'Bathroom',
      subtitle: 'Install or repair toilets, sinks, showers, and more.',
      imageUrl: 'https://content.jdmagicbox.com/comp/def_content/bathroom-cleaning-services/hegdxmykka-bathroom-cleaning-services-3-g9if4.jpg?clr=',
    ),
    CardData(
      title: 'Pest Control',
      subtitle: 'Exterminate pests like ants, mice, and cockroaches',
      imageUrl: 'https://pestoff.com.sg/wp-content/uploads/2019/03/Thermal-Fogging-for-Residential-Property.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Services'),
        ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.white),
              child:TextField(
              // onChanged: (value) => _runFilter(value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding:const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                hintText: "Search a service",
                suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                filled: true,
                fillColor: Colors.white,
              ),
                onTap: () {
                  showSearch(context: context, delegate: CustomSearchDelegate());
                },
            ),
            )
          ),
          SizedBox(height: 16.0),
          Row(
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
              SizedBox(width: 4.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text('Update', style: TextStyle(color: Colors.white),),
                ),
              ),
              SizedBox(width: 4.0),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text('Delete', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Expanded(
              child: ListView.builder(
                itemCount: cardList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(cardList[index].imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(cardList[index].title,style:TextStyle(fontSize: 23),),
                            subtitle: Text(cardList[index].subtitle),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          )
        ],
      )
    );
  }
}

class CardData {
  final String title;
  final String subtitle;
  final String imageUrl;

  CardData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerms = [
    'product',
    'service',
    'user',
    'employee',
    'order',
    'verification',
    'payment',
    'history',
    'worker',
    'customer',
    'home',
    'cleaning'
  ];

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
    return
      IconButton(onPressed: () {
        close(context, null);
      }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in searchTerms) {
      if(item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in searchTerms) {
      if(item.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}