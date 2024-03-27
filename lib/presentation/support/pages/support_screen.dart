import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/presentation/support/widgets/chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final String userId = FirebaseAuth.instance.currentUser!.uid;

  supportCall()async{

    final Uri url = Uri(scheme: 'tel',path: '9876543210');

if(await canLaunchUrl(url)){
      await launchUrl(url);
}else{

  print("Error ");
}

  }
var   _webcontroller = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromARGB(255, 233, 245, 255),
     
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(12),
        
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),  color: Colors.white,
        ),
          padding: EdgeInsets.all(14),
          height: 370,
          child: ListView(
            children: [
              BlocBuilder<UsersBloc, UsersState>(
                builder: (context, state) {
        
                  if(state is UsersLoadedState){
                     return Container(
                      margin: EdgeInsets.all(12),
                      height: 80,
                       child: RichText(
                        
                                         text: TextSpan(children: [
                        TextSpan(
                            text: "Hi ${state.users.name}",
                            style: TextStyle(color: const Color.fromARGB(255, 53, 125, 185), fontSize: 22, fontWeight: FontWeight.w900)),
                        TextSpan(
                            text: "\nHow can we help?",
                            style: TextStyle(color:const Color.fromARGB(255, 53, 125, 185),fontSize: 20, fontWeight: FontWeight.bold)),
                                         ]),
                                       ),
                     );
                  }
                  return RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Hi user",
                          style: TextStyle(color: Colors.black, fontSize: 22)),
                      TextSpan(
                          text: "\nHow can we help?",
                          style: TextStyle(color: Colors.black)),
                    ]),
                  );
                },
              ),
        
              Divider(color:  const Color.fromARGB(255, 233, 245, 255),),
              ListTile(
                onTap: () {
                  
                },
                title: Text("Help"),
                trailing: Icon(Icons.help),
              ),
                 Divider(color:  const Color.fromARGB(255, 233, 245, 255),),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomScreen(
                        userId: userId,
                      ),
                    )),
                title: Text("Chat with us"),
                          trailing: Icon(Icons.chat),
              ),
                 Divider(color:  const Color.fromARGB(255, 233, 245, 255),),
              ListTile(
                onTap: () => supportCall(),
                title: Text("Call Us"),
                subtitle: Text("91+ 9876543210",style: TextStyle(fontSize: 12),),
                trailing:Icon(Icons.call) ,
              ),
            ],
          ),
        ),
      ),
      // bottomSheet:WebViewWidget(
        
      //   controller: _webcontroller) ,
    );
  }
}
