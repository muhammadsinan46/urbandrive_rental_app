part of 'profileimage_bloc.dart';

sealed class ProfileimageState extends Equatable {
  const ProfileimageState();
  
  @override
  List<Object> get props => [];
}

final class ProfileimageInitial extends ProfileimageState {}
final class ProfileimageFailure extends ProfileimageState {}
final class ProfileimageLoading extends ProfileimageState {}
final class ProfileimageSuccess extends ProfileimageState {
  final File userImage;

  const ProfileimageSuccess({required this.userImage});

  @override
  List<Object> get props => [userImage];
}

