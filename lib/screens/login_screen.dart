import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buyit/services/auth.dart';
import 'adminHome.dart';
import 'loading.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();
  bool is_admin = false;
  bool loading = false;

  final adminerror = ' ';
  var error_message = '';

  @override
  void dispose() {
    _emailcontroller.dispose();

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
                  SizedBox(height: 40),
                  Column(
                    children: [
                      Image(image: AssetImage('images/icons/buy.png')),
                      Text(
                        'Tech Market',
                        style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
                      ),
                      // Text(
                      //   'بيع واشتري اونلاين',
                      //   style: TextStyle(
                      //       fontFamily: 'Pacifico',
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                  SizedBox(height: 70),
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
                          if (_globalKey.currentState.validate()) {
                            setState(() => loading = true);

                            try {
                              final authResult = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailcontroller.text,
                                      password: _passwordcontroller.text);
                              setState(() => loading = false);
                              if (is_admin == true) {
                                if (_passwordcontroller.text == 'admin1234') {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              AdminHome()));
                                } else {
                                  setState(() => error_message =
                                      "wrong password for admin");
                                }
                              } else {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Home()));
                              }
                            } catch (e) {
                              setState(() => loading = false);
                              setState(() => error_message = e.code);

                              // Scaffold.of(context).showSnackBar(
                              //     SnackBar(content: Text(e.toString())));
                            }
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                  SizedBox(height: 40),
                  Row(
                    children: [
                      Text(
                        ' * don\'t have an account ?    ',
                        style: TextStyle(fontSize: 17),
                      ),
                      // like the (a) thing in html ************
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'SignupScreen');
                        },
                        child: Text(
                          'sign up ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            setState(() => is_admin = true);
                          },
                          child: Text(
                            'i\'m an trader',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: is_admin
                                    ? Colors.cyan[50]
                                    : Colors.blue[800]),
                          ),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            setState(() => is_admin = false);
                          },
                          child: Text(
                            'i\'m a buyer',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: is_admin
                                    ? Colors.blue[800]
                                    : Colors.cyan[50]),
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }
}
