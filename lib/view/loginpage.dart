import 'package:signup_signin/components/my_login_container.dart';
import 'package:signup_signin/view/registerpage.dart';

import '../provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/components/my_TextField.dart';
import 'package:signup_signin/components/mybotton.dart';

import '../provider/google_Auth_provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

// error massages
  final String _loginError =
      '[firebase_auth/channel-error] "dev.flutter.pigeon.firebase_auth_platform_interface.FirebaseAuthHostApi.signInWithEmailAndPassword".';
  final String _emailFormatError =
      '[firebase_auth/invalid-email] The email address is badly formatted.';
  final String _emailOrPasswordIncorrect =
      '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.';

  // text editing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final GlobalKey _lognKey = GlobalKey<FormState>();
    final authProvider = Provider.of<Authprovider>(context);
    final gAuthProvider = Provider.of<GoogleProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Authentication'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            // form
            child: Form(
              key: _lognKey,
              child: Column(
                children: [
                  const Text('Login Page'),
                  const SizedBox(
                    height: 25,
                  ),
                  // email text field
                  MyTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email is empty';
                        }
                        return null;
                      },
                      controller: _emailController,
                      obscureText: false,
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                  const SizedBox(
                    height: 10,
                  ),
                  // password text field
                  MyTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is empty';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: true,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // login button
                  GestureDetector(
                    onTap: () async {
                      try {
                        await authProvider.signInWithEmailPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        // Navigate to another page or show success message
                      } catch (e) {
                        print('error is : $e');
                        if (e == _loginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'Email and Password is null',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          );
                        } else if (e == _emailFormatError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'Email format is not correct',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          );
                        } else if (e == _emailOrPasswordIncorrect) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'Email or password is\'nt correct',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          );
                        }
                      }
                    },
                    child: const MyButton(
                      padding: EdgeInsets.all(10),
                      text: 'LOGIN',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // OR and divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('or'),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 140,
                        child: Divider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // google sign in
                  MyContainer(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        gAuthProvider.googleSignIn();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('lib/images/google.png'),
                            )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.surface,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // create account button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: MyContainer(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          'Create account',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.surface,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
