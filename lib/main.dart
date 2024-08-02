import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/firebase_options.dart';
import 'package:signup_signin/provider/authprovider.dart';
import 'package:signup_signin/provider/google_Auth_provider.dart';
import 'package:signup_signin/provider/register_provider.dart';
import 'package:signup_signin/provider/themeProvider.dart';
import 'package:signup_signin/view/homepage.dart';
import 'package:signup_signin/view/loginpage.dart';

void main() async {
  print('hello');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => Authprovider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => GoogleProvider()),
    ChangeNotifierProvider(create: (context) => RegisterProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.lightMode,
        darkTheme: themeProvider.darkMode,
        home: const AuthWrapper());
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          if (snapShot.hasData) {
            return const Homepage();
          } else {
            return LoginPage();
          }
        });
  }
}
