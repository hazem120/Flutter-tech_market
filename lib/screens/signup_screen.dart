import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/auth.dart';
import 'package:flutter/services.dart';
import 'loading.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();
  bool loading = false;
  var error_message = '';
  @override
  void dispose() {
    _emailcontroller.dispose();
    _namecontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(

            // double height = MediaQuery.of(context).size.height;
            // sizedbox( height: height*.04)
            backgroundColor: Colors.cyan[50],
            body: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  SizedBox(height: 70),
                  Column(
                    children: [
                      Image(image: AssetImage('images/icons/buy.png')),
                      Text(
                        'Buy It',
                        style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                      )
                    ],
                  ),
                  SizedBox(height: 70),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: TextFormField(
                  //     controller: _namecontroller,
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'value is empty';
                  //       }
                  //     },
                  //     decoration: InputDecoration(
                  //       hintText: 'Enter your name',
                  //       prefixIcon: Icon(
                  //         Icons.person_rounded,
                  //         color: Colors.cyan[800],
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(25),
                  //           borderSide: BorderSide(color: Colors.black)),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: _emailcontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'value is empty';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(
                          Icons.email,
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
                      controller: _passwordcontroller,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'value is empty';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.vpn_key,
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
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.cyan[300],
                        onPressed: () async {
                          // global key validate ...

                          if (_globalKey.currentState.validate()) {
                            setState(() => loading = true);
                            try {
                              final authResult = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: _emailcontroller.text,
                                      password: _passwordcontroller.text);
                              setState(() => loading = false);

                              Navigator.pushNamed(context, 'LoginScreen');
                            } catch (e) {
                              setState(() => loading = false);
                              setState(() => error_message = e
                                  .code); // as we use this then we don't need the snack bar and the builder

                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text(e.code())));
                            }
                          }
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),

                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        error_message,
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
