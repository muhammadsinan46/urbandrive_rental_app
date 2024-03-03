

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:urbandrive/domain/profileutils/user_repos.dart';


import 'package:urbandrive/infrastructure/user_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
    final UserRepository userRepo;
  UsersBloc(this.userRepo) : super( UsersState()) {
      on<GetUserEvent>((event, emit)async{
     emit(UsersLoadingState());
     await Future.delayed(const Duration(seconds: 1));

     try{
      final userdata = await userRepo.getUser();
      print("user data is ${userdata}");
      emit(UsersLoadedState( userdata));
      
     }catch (e){
     print(e.toString());
     }
      });
  }
}
