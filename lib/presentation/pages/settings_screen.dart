
import 'package:flutter/material.dart';
import 'package:urbandrive/domain/Userauth/user_auth_helper.dart';
import 'package:urbandrive/presentation/pages/login_screen.dart';

  UserauthHelper userauthHelper = UserauthHelper();

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
      
      body: Column(children: [

        Center(
          child: Card(
            child: Container(
              
              height: 400,
              width: MediaQuery.sizeOf(context).width-50,
              child: Column(children: [
                  ListTile(leading: Icon(Icons.favorite),title: Text("Favourite Cars"),trailing: Icon(Icons.arrow_forward_ios),),
                  Divider(),
                            ListTile(leading: Icon(Icons.favorite),title: Text("Privacy Policy"),trailing: Icon(Icons.arrow_forward_ios),),
                  Divider(),
                            ListTile(leading: Icon(Icons.favorite),title: Text("Terms and Conditions"),trailing: Icon(Icons.arrow_forward_ios),),
                  Divider(),
                            ListTile(leading: Icon(Icons.favorite),title: Text("Delete My Account"),trailing: Icon(Icons.arrow_forward_ios),),
                  Divider(),
                            ListTile(
                              onTap: () {
                                    userauthHelper.signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false,
                          );
                              },
                              leading: Icon(Icons.favorite),title: Text("Logout"),trailing: Icon(Icons.arrow_forward_ios),),
                  Divider()

              ],)
              ),
          ),
        )

      ],),);
  }
}