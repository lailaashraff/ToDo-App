import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/home/home_screen.dart';
import 'package:todo/my_theme.dart';

import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.36,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      CustomTextFormField(
                        text: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        myValidator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return 'Please enter email address';
                          }
                          final bool emailValid =
                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if(!emailValid){
                            return 'please enter a valid email address';
                          }
                        },
                      ),
                      CustomTextFormField(
                        text: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        myValidator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return 'Please enter password';
                          }
                          if(text.length<6){
                            return 'Please enter at least 6 characters';
                          }

                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyTheme.primaryLightColor
                          ),
                          onPressed: () {
                            login();
                          },
                          child: Text('Login',style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: MyTheme.whiteColor
                          ),),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void login() async{
    if(formKey.currentState?.validate()==true){

      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        print('LOGIN SUCCESS');
        Navigator.of(context).pushNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
