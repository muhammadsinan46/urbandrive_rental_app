part of 'users_bloc.dart';

 class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

 class UsersLoadingState extends UsersState {
    @override
  List<Object> get props => [];
}
 class UsersLoadedState extends UsersState {
   UserModel users;
   UsersLoadedState(this.users);
      @override
  List<Object> get props => [users];
}
