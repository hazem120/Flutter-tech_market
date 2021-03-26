import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.cyan[300]),
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
            ListTile(
              title: Text(
                'Edit product - عدل منتج',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {},
            ),
            Divider(color: Colors.black),
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
        backgroundColor: Colors.cyan,
        title: Text('TechMarket'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 90),
        child: Column(),
      ),
    );
  }
}
