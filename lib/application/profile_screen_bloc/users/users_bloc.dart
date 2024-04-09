

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import 'package:urbandrive/domain/repository/user_repo/user_repository.dart';


import 'package:urbandrive/infrastructure/user_model/user_model.dart';

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

      emit(UsersLoadedState( userdata));
      
     }catch (e){
     print(e.toString());
     }
      });
  }
}
