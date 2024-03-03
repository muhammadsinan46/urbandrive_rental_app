part of 'profileimage_bloc.dart';

sealed class ProfileimageEvent extends Equatable {
  
  const ProfileimageEvent();

  @override
  List<Object> get props => [];
}

class AfterUpdateEvent extends ProfileimageEvent{}
class UploadImageEvent extends ProfileimageEvent{}

