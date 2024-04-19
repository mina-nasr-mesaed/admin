
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/Button.dart';
import '../widget/constasts.dart';

class Resgister extends StatefulWidget {
  @override
  _ResgisterState createState() => _ResgisterState();
}

class _ResgisterState extends State<Resgister> {
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            elevation: 0,
            leading: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded),
                iconSize: 23,
                autofocus: true,
                color: Color.fromRGBO(26, 26, 26, 1),
              ),
            ),
          ),
          body: Form(
            key: _key,
            child: Container(
                width: double.infinity,
                color: Color.fromRGBO(255, 255, 255, 1),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 90),
                child: ListView(children: [
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
                  // email
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
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
                        labelText: 'EMAIL ADRESS',
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                      ),
                      onChanged: (text) {},
                    ),
                  ),
                  SizedBox(height: 20,),
                  // password
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: validatePassword,
                      controller: passowrdController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
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
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.4)),
                      ),
                      onChanged: (text) {},
                    ),
                  ),

                  //
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(errorMessage,style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: 'SIGN UP',
                      onTap: () async {
                        if (_key.currentState!.validate()) {
                          try{
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passowrdController.text
                            );
                            errorMessage = '';
                            Navigator.pushReplacementNamed(context,'Home');
                          }on FirebaseAuthException catch (error){
                            errorMessage = error.message!;
                          }

                          setState(() {});
                        }
                      }),
                ])),
          ),
        ));
  }


}

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-Mail address is required';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if(!regex.hasMatch(formEmail)) return 'Invaild E-Mail Adrdress format .';

  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  String pattern = r'^(?=.*?[A-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex =RegExp(pattern);
  if(!regex.hasMatch(formPassword))
    return '''
    password must be at least 8 characters,
    include an uppercase letter,number and symbol
  ''';
    return null;
}