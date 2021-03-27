import 'package:buyit/models/products.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _pricecontroller = TextEditingController();

  TextEditingController _categorycontroller = TextEditingController();

  TextEditingController _descriptioncontroller = TextEditingController();

  TextEditingController _locationcontroller = TextEditingController();

  @override
  void dispose() {
    _namecontroller.dispose();
    _pricecontroller.dispose();
    _categorycontroller.dispose();
    _descriptioncontroller.dispose();
    _locationcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[700],
          title: Text('Tech Market'),
        ),
        body: Form(
          key: _globalKey,
          child: ListView(
            children: [
              SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tech Market - Add product',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _namecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'value is empty';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Product name',
                    prefixIcon: Icon(
                      Icons.ac_unit,
                      color: Colors.cyan[800],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _pricecontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'value is empty';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Price',
                    prefixIcon: Icon(
                      Icons.money_off_csred_rounded,
                      color: Colors.cyan[800],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _categorycontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'value is empty';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Category',
                    prefixIcon: Icon(
                      Icons.category,
                      color: Colors.cyan[800],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _descriptioncontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'value is empty';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'description',
                    prefixIcon: Icon(
                      Icons.description,
                      color: Colors.cyan[800],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _locationcontroller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'value is empty';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'location',
                    prefixIcon: Icon(
                      Icons.location_off,
                      color: Colors.cyan[800],
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: RaisedButton(
                    child: Text(
                      'Add product',
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Colors.amber[600],
                    onPressed: () async {
                      if (_globalKey.currentState.validate()) {
                        var current_user =
                            await FirebaseAuth.instance.currentUser();
                        try {
                          Firestore.instance.collection('products').add({
                            'product_name': _namecontroller.text,
                            'product_price': _pricecontroller.text,
                            'product_description': _descriptioncontroller.text,
                            'product_categoty': _categorycontroller.text,
                            'owner': {
                              'uid': current_user.uid,
                              'email': current_user.email
                            },
                            'product_path_location': _locationcontroller.text,
                          });
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
