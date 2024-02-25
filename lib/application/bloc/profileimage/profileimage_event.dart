part of 'profileimage_bloc.dart';

sealed class ProfileimageEvent extends Equatable {
  
  const ProfileimageEvent();

  @override
  List<Object> get props => [];
}

class afterUpdateEvent extends ProfileimageEvent{}
class UploadImageEvent extends ProfileimageEvent{}
