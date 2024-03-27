
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urbandrive/application/profile_screen_bloc/users/users_bloc.dart';
import 'package:urbandrive/presentation/profile_screen/pages/profile_screen.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProfileScreen(),));
      }, 
      child: Card(
        margin: EdgeInsets.all(10),
         color: Color.fromARGB(255, 216, 237, 255),
        child: AnimatedContainer(
            
          duration: Duration(seconds: 3),
          
            height: 150,
            width: MediaQuery.sizeOf(context).width,
            child: BlocBuilder<UsersBloc, UsersState>(
      
              
              builder: (context, state) {
      
                if(state is UsersLoadedState){
                   return Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                     child:Icon(Icons.person) ,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width-100,
                      child: ListTile(
                        title: Text("${state.users.name}"),
                        subtitle: Text("${state.users.email}"),
                      ),
                    )
                  ],
                );
      
                }
                return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                      ),
                      SizedBox(
                        width: 200,
                        child: ListTile(
                          title: Text("user name"),
                          subtitle: Text("useremail"),
                        ),
                      )
                    ],
                  ),
                );
               
              },
            )),
      ),
    );
  }
}
