import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/components/mybotton.dart';
import 'package:signup_signin/provider/register_provider.dart';

import '../components/my_TextField.dart';

class RegisterPage extends StatelessWidget {
   RegisterPage({super.key});
   // error messages
   // final String _loginError =
   //     '[firebase_auth/channel-error] "dev.flutter.pigeon.firebase_auth_platform_interface.FirebaseAuthHostApi.signInWithEmailAndPassword".';
   // final String _emailFormatError =
   //     '[firebase_auth/invalid-email] The email address is badly formatted.';
   // final String _emailOrPasswordIncorrect =
   //     '[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.';


   // text editing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final  _key = GlobalKey<FormState>();
    final regProvider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _key,
          child: Column(
            children:[
              const SizedBox(
                height: 50,
              ),
              const Text('Register Page'),
              const SizedBox(
                height: 70,
              ),
              // email controller
              MyTextField(
                validator: (value){
                  if(value!.isEmpty){
                    return 'Please enter email';
                  }
                  // email validation
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                  controller: _emailController,
                  obscureText: false,
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(
                height: 10,
              ),
              // password controller
              MyTextField(
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                  controller: _passwordController,
                  obscureText: false,
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(
                height: 10,
              ),
              // conform password controller
              MyTextField(
                  controller: _cPwController,
                  obscureText: true,
                  labelText: 'Conform Password',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(
                height: 30,
              ),
              // register button
              GestureDetector(
                onTap: ()async{
                  if (_key.currentState?.validate() == true) {
                    if(_passwordController.text == _cPwController.text){
                      try{
                        await regProvider.registration(email: _emailController.text, password: _passwordController.text);
                        print('hallo');
                      } on FirebaseAuthException catch (e) {
                        print('hallo world');
                        print('error is :${e.code.toString()}');
                        if (e.code == 'weak-password') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password is weak')),
                          );
                        } else if (e.code == 'The email address is already in use by another account.') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.transparent,
                                content: Text(
                                  'Email is already registered',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          );
                        } else {
                          print('error is : ${e.message}');
                        }
                      } catch (e) {
                        print('error is : $e');
                      }
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Conform Password is not match')),
                      );
                    }
                  }
                },
                child:
                    const MyButton(padding: EdgeInsets.all(10), text: 'Register'),
              ),
              const SizedBox(
                height: 10,
              ),
              // login button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account already?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'login',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
