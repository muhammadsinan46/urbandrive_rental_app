part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}


class UserLoadEvent extends UsersEvent{}
class UserAddEvent extends UsersEvent{
  final UserModel users;

 const  UserAddEvent({required this.users});
   @override
  List<Object> get props => [users];
}
class UserUpdateEvent extends UsersEvent{
  final UserModel users;
 const  UserUpdateEvent({required this.users});
   @override
  List<Object> get props => [users];
}
class UserDeleteEvent extends UsersEvent{
  final UserModel users;
  const UserDeleteEvent({required this.users});


  @override
  List<Object> get props => [users];
}

