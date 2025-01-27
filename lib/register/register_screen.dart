import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/login/login_screen.dart';
import 'package:todo/models/my_user.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/authentication_provider.dart';
import 'package:todo/toast_utils.dart';

import '../dialog_utils.dart';
import '../home/home_screen.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'lolo12');

  var emailController = TextEditingController(text: 'lolo@route.com');

  var passwordController = TextEditingController(text: '123456');

  var confirmPasswordController = TextEditingController(text: '123456');

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
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery
                    .of(context)
                    .size
                    .height * 0.07
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SafeArea(
                  child: Text('Register account', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.36,
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
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Please enter username';
                          }
                        },
                      ),
                      CustomTextFormField(
                        text: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        myValidator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Please enter email address';
                          }
                          final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(text);
                          if (!emailValid) {
                            return 'please enter a valid email address';
                          }
                        },
                      ),
                      CustomTextFormField(
                        text: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        myValidator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Please enter password';
                          }
                          if (text.length < 6) {
                            return 'Please enter at least 6 characters';
                          }
                        },
                      ),
                      CustomTextFormField(
                        text: 'Confirm Password',
                        controller: confirmPasswordController,
                        isPassword: true,
                        myValidator: (text) {
                          if (text == null || text
                              .trim()
                              .isEmpty) {
                            return 'Please enter confirmation password';
                          }
                          if (text != passwordController.text) {
                            return "Passwords don't match";
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.primaryLightColor),
                          onPressed: () {
                            register();
                          },
                          child: Text(
                            'Register',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Have an account?',
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(LoginScreen.routeName);
                              },
                              child: Text(
                                'Login',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                    color: MyTheme.primaryLightColor),
                              ))
                        ],
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

  void register() async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context, 'Loading...');

      try {
        final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser user = MyUser(id: credential.user!.uid,
            email: emailController.text,
            username: nameController.text);
        var authProvider = Provider.of<AuthenticationProvider>(context,listen: false);
        authProvider.updateUser(user);
        await FirebaseUtils.addUserToFireBase(user);

        DialogUtils.hideDialog(context);
        ToastUtils.showToast(toastMessage: 'Registered Successfully',
            toastColor: Theme.of(context).primaryColor);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

        // DialogUtils.showDialogMessage(context,
        //     message: 'Registered Successfully', posActionName: "ok",
        //     posAction: () {
        //     });

        print('!!!!!!!!Registered!!!!!!!!!!');
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(context);

        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          DialogUtils.showDialogMessage(context,
            message: "The password provided is too weak.", canDismiss: true,
          );
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          DialogUtils.showDialogMessage(context,
              message: "The account already exists for that email.",
              canDismiss: true
          );
        }
      } catch (e) {
        DialogUtils.hideDialog(context);
        print(e.toString());
        DialogUtils.showDialogMessage(context,
          message: e.toString(), canDismiss: true,
        );
      }
    }
  }
}
