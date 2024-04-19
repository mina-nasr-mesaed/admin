
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/Button.dart';
import '../widget/constasts.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        elevation: 0,
      ),
      body: Form(
        key: _key,
        child: Container(
          color: Color.fromRGBO(255, 255, 255, 1),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Donor',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/logo.png',
                width: 250,
                height: 250,
              ),
              SizedBox(height: 10),
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: '',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: validateEmail,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: kPrimarycolor,
                autocorrect: true,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.password),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimarycolor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimarycolor),
                  ),
                  labelText: 'Email Adress',
                  labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: validatePassword,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                cursorColor: kPrimarycolor,
                autocorrect: true,
                decoration: InputDecoration(
                  //suffixIcon: Icon(Icons.password),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: kPrimarycolor,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kPrimarycolor),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                ),
              ),
              Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CustomButton(
                text: 'Login',
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      errorMessage = '';
                      Navigator.pushReplacementNamed(context,'Home');
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.message!;
                    }

                    setState(() {});
                  }

                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Text(
                    'Dont have an account?',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 4),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'Resgister');
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: kPrimarycolor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-Mail address is required';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invaild E-Mail Adrdress format .';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
    password must be at least 8 characters,
    include an uppercase letter,number and symbol
  ''';
  return null;
}
