import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.indigo[400]),
                child: Image(image: AssetImage('images/icons/manage.png')),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'Add product - اضف منتج',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'addProduct');
                },
              ),
              Divider(color: Colors.black),
              SizedBox(height: 20),
              // ListTile(
              //   title: Text(
              //     'Edit product - عدل منتج',
              //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              //   ),
              //   onTap: () {
              //     Navigator.pushNamed(context, 'editProduct');
              //   },
              // ),
              //Divider(color: Colors.black),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'View orders  - اعرض الطلبات',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('TechMarket'),
          actions: [
            FlatButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, 'LoginScreen');
              },
              color: Colors.indigo[500],
              child: Text(
                'logout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Text('Loading');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  child: Center(
                    child: SpinKitWave(
                      color: Colors.cyan[400],
                      size: 50,
                    ),
                  ),
                );
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return new Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          Image.asset(document['product_path_location']),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              document['product_description'],
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.start,
                            children: [
                              // FlatButton(
                              //   textColor: const Color(0xFF6200EE),
                              //   onPressed: () {
                              //     // Perform some action
                              //   },
                              //   child: const Text(
                              //     'Edit',
                              //     style: TextStyle(fontSize: 18),
                              //   ),
                              // ),
                              FlatButton(
                                textColor: const Color(0xFF6200EE),
                                onPressed: () {
                                  Firestore.instance
                                      .collection('products')
                                      .document(document.documentID)
                                      .delete();
                                  // Perform some action
                                },
                                child: const Text(
                                  'delete',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ));
  }
}
