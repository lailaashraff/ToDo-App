import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/dialog_utils.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/my_theme.dart';

import '../home/home_screen.dart';
import '../providers/authentication_provider.dart';
import '../register/register_screen.dart';
import '../toast_utils.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'lolo@route.com');

  var passwordController = TextEditingController(text: '123456');

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
                vertical: MediaQuery.of(context).size.height * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SafeArea(
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
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
                          if (text == null || text.trim().isEmpty) {
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
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          if (text.length < 6) {
                            return 'Please enter at least 6 characters';
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: MyTheme.primaryLightColor),
                          onPressed: () {
                            login();
                          },
                          child: Text(
                            'Login',
                            style: Theme.of(context)
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
                            "Don't have an account ? ",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    RegisterScreen.routeName);
                              },
                              child: Text(
                                'Sign up',
                                style: Theme.of(context)
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

  void login() async {
    if (formKey.currentState?.validate() == true) {
      //show loading
      DialogUtils.showLoading(context, 'Loading...');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProvider =
            Provider.of<AuthenticationProvider>(context, listen: false);
        authProvider.updateUser(user);
        DialogUtils.hideDialog(context);

        ToastUtils.showToast(
            toastMessage: 'Login Successfully',
            toastColor: Theme.of(context).primaryColor);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          DialogUtils.showDialogMessage(
            context,
            message: "No user found for that email.",
            posActionName: "ok",
          );
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          DialogUtils.showDialogMessage(
            context,
            message: "Wrong password provided for that user.",
            posActionName: "ok",
          );
        }
      } catch (e) {
        DialogUtils.showDialogMessage(
          context,
          message: e.toString(),
          posActionName: "ok",
        );
      }
    }
  }
}
