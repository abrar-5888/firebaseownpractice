import 'package:cloud_firestore/cloud_firestore.dart';
import '../cart.dart';
import '../update.dart';
import 'Function/functions.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String searc = "";
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance.collection("users").snapshots();
    TextEditingController searchController = TextEditingController();

    void dispose() {
      searchController.dispose(); // Dispose the TextEditingController
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Practice"),
        actions: [
          IconButton(
            onPressed: () {
              signout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            searchBox(),
            SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final document = snapshot.data!.docs[index];
                        final data = document.data();
                        // final urll = snapshot.data;
                        var url = (data as Map<String, dynamic>)['image'];
                        var id = document.id;

                        TextEditingController namee = TextEditingController(
                            text: (data as Map<String, dynamic>)['name']);
                        String nameee = namee.text.trim();
                        TextEditingController pricee = TextEditingController(
                            text: (data as Map<String, dynamic>)['price']);
                        String priceee = pricee.text.trim();
                        TextEditingController descriptionn =
                            TextEditingController(
                                text: (data
                                    as Map<String, dynamic>)['description']);
                        String descriptionnn = descriptionn.text.trim();

                        if (searc.isEmpty) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: ListTile(
                              onTap: () {
                                print('${url}');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Update(nameee,
                                          descriptionnn, priceee, id, url)),
                                );
                              },
                              trailing: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  iconSize: 15,
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection('users');
                                    collection.doc(id).delete();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(nameee),
                              leading: Container(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  '${url}',
                                  height: 80,
                                  width: 80,
                                ),
                                // : Container()
                              ),
                              subtitle: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(data['description']),
                                      Text(data['price']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (data['name']
                            .toString()
                            .contains(searc.toLowerCase())) {
                          return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                            ),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Update(nameee,
                                          descriptionnn, priceee, id, url)),
                                );
                              },
                              trailing: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                height: 30,
                                width: 30,
                                child: IconButton(
                                  iconSize: 15,
                                  onPressed: () {
                                    var collection = FirebaseFirestore.instance
                                        .collection('users');
                                    collection.doc(id).delete();
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              title: Text(nameee),
                              leading: Container(
                                height: 80,
                                width: 80,
                                child: Image.network(
                                  '${url}',
                                  height: 80,
                                  width: 80,
                                ),
                                // : Container()
                              ),
                              subtitle: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(data['description']),
                                      Text(data['price']),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onTap: () {
          print('workin');
        },
        onChanged: (value) {
          print('Working');
          setState(() {
            searc = value;
          });
        },
        decoration: const InputDecoration(
          hoverColor: Colors.yellow,
          prefixIcon: Icon(Icons.search),
          prefixIconColor: Colors.black,
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 20),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          border: InputBorder.none,
          hintText: 'Search',
        ),
      ),
    );
  }
}
