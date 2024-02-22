import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:urbandrive/domain/Userstore/user_firestore.dart';
import 'package:urbandrive/infrastructure/user_model.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UserFireStore _userFirestore;
  UsersBloc(this._userFirestore) : super(UsersInitialState()) {
    // on<UsersEvent>((event, emit) async{
    //   try{
    //     emit(UsersLoadingState());
    //     //final users =   await _userFirestore.getUsers().where();
    //   }on
    // });
  }
}
