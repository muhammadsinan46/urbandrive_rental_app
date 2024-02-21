import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profileimage_event.dart';
part 'profileimage_state.dart';

class ProfileimageBloc extends Bloc<ProfileimageEvent, ProfileimageState> {
  ProfileimageBloc() : super(ProfileimageInitial()) {
    on<ProfileimageEvent>((event, emit) {
      if(event is UploadImageEvent){
        emit(ProfileimageSuccess(userImage: event.userImage));
      }
    });
  }
}
