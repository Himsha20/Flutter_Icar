import 'package:flutter/material.dart';
import 'package:icar/DialogBox/errorDialog.dart';
import 'package:icar/DialogBox/loadingDialog.dart';
import 'package:icar/HomeScreen.dart';
import 'package:icar/widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width,
            _screenHeight =MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                    'images/login.png',
                  height: 270.0,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      isObsecure: false,
                  data:Icons.person,
                    controller: _emailController,
                    hintText: 'Email',
                  ),
                  CustomTextField(
                    isObsecure: true,
                    data:Icons.lock,
                    controller: _passwordController,
                    hintText: 'Password',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery
                     .of(context)
                  .size
                  .width*0.5,
              child: ElevatedButton(
                onPressed: (){
                  _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty
                      ? _login()
                      :showDialog(
                      context: context,
                      builder: (con){
                         return ErrorAlertDialog(
                           message: 'Please Write The Required Info For Login',
                         );
                      });
                },
                child: Text('Log In',style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  void _login() async{
    showDialog(
        context: context,
        builder:(con){
              return  LoadingAlertDialog(
                message :'Please Wait',
              );
        });
    User? currentUser;

    await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
    ).then((auth) {
        currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(context: context, builder:(con){
         return ErrorAlertDialog(
           message:error.message.toString(),
         );
      });
    });
    if(currentUser !=null){
      Navigator.pop(context);
      Route newRoute = MaterialPageRoute(builder: (context)=>HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
    else{
      print("error");
    }
  }
}
