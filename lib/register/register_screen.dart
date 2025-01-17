import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

import '../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register';
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
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
                        text: 'UserName',
                        controller: nameController,
                        myValidator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return 'Please enter username';
                          }
                        },
                      ),
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
                      CustomTextFormField(
                        text: 'Confirm Password',
                        controller: confirmPasswordController,
                        isPassword: true,
                        myValidator: (text) {
                          if(text==null || text.trim().isEmpty){
                            return 'Please enter confirmation password';
                          }
                          if(text!=passwordController.text){
                            return "Passwords don't match";
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
                            register();
                          },
                          child: Text('Register',style: Theme.of(context).textTheme.titleSmall!.copyWith(
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

  void register() async{
    if(formKey.currentState?.validate()==true){

      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print('!!!!!!!!Registered!!!!!!!!!!');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
