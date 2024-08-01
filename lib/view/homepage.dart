import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signup_signin/provider/authprovider.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
  final auth = Provider.of<Authprovider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(

        leading:IconButton(
          onPressed: ()async{
            await auth.signOut();
          },
          icon: Icon(Icons.logout),
        ),),
      drawer: Drawer(),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(auth.currentUser!.email.toString()),
          ],
        ),
      ),
    );
  }
}
