import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './users.dart';
import '../cart.dart';
import '../update.dart';
import 'Function/functions.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class Home extends StatefulWidget {
  final String? email;

  Home({
    required this.email,
  });

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  String search = "";
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    bool isUpdateAllowed = to();
    bool isDeleteAllowed = todelete();

    void initState() {
      // TODO: implement initState
      isDeleteAllowed = todelete();
      isUpdateAllowed = to();
      super.initState();
    }

    String? email = widget.email;

    var users = FirebaseFirestore.instance.collection("users").snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: () {
              if (email == "abrararshad32@gmail.com") {
                // fetchData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Users(email: email),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('You are unable to access this page!'),
                  ),
                );
              }
            },
            icon: Icon(Icons.person),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
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
      drawer: DrawerWidget(),
      body: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orange],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            searchBox(),
            SizedBox(height: 15),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: users,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final document = snapshot.data!.docs[index];
                        final data = document.data() as Map<String, dynamic>?;
                        var url = (data as Map<String, dynamic>)['image'];
                        var id = document.id;

                        TextEditingController nameController =
                            TextEditingController(
                                text: (data as Map<String, dynamic>)['name']);
                        String name = nameController.text.trim();
                        TextEditingController priceController =
                            TextEditingController(
                                text: (data as Map<String, dynamic>)['price']);
                        String price = priceController.text.trim();
                        TextEditingController descriptionController =
                            TextEditingController(
                                text: (data
                                    as Map<String, dynamic>)['description']);
                        String description = descriptionController.text.trim();

                        if (search.isEmpty ||
                            data['name']
                                .toString()
                                .contains(search.toLowerCase())) {
                          return Card(
                            color: Color.fromARGB(147, 196, 196, 196),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              tileColor: Colors.transparent,
                              enabled: isUpdateAllowed,
                              onTap: () {
                                if (isUpdateAllowed) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Update(
                                        name,
                                        description,
                                        price,
                                        id,
                                        url,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'You are unable to update any field!'),
                                    ),
                                  );
                                }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              leading: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: NetworkImage(url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(description),
                                  Text(
                                    '\$$price',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  if (isDeleteAllowed) {
                                    var collection = FirebaseFirestore.instance
                                        .collection('users');
                                    collection.doc(id).delete();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'You are unable to delete any field!'),
                                      ),
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
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
        color: Color.fromARGB(231, 196, 196, 196),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            search = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 20),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: 'Search',
        ),
      ),
    );
  }
}
