part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();
  
  @override
  List<Object> get props => [];
}

final class UsersInitialState extends UsersState {}
final class UsersLoadingState extends UsersState {}
final class UsersLoadedState extends UsersState {
  final List<UserModel> users;
  const UsersLoadedState({required this.users});
}
final class UsersSuccessState extends UsersState {
  final String message;
 const  UsersSuccessState({required this.message});
}
final class UsersError extends UsersState {
  final String errorMessage;
  const UsersError({required this.errorMessage});
}
