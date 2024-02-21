part of 'profileimage_bloc.dart';

sealed class ProfileimageEvent extends Equatable {
  const ProfileimageEvent();

  @override
  List<Object> get props => [];
}


class UploadImageEvent extends ProfileimageEvent{
  final File userImage;


  const UploadImageEvent({required this.userImage});

@override
  List<Object> get props => [userImage];
}