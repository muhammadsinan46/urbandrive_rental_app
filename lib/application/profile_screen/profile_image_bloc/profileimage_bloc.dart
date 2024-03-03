

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:urbandrive/domain/profileutils/profile_image.dart';

part 'profileimage_event.dart';
part 'profileimage_state.dart';

class ProfileimageBloc extends Bloc<ProfileimageEvent, ProfileimageState> {
  final ProfileImage profileImage;
  ProfileimageBloc(this.profileImage) : super( ProfileimageState(file: null)) {
    on<UploadImageEvent>(uploadImage);
    on<AfterUpdateEvent>(afterUpdate);
    
  }
  FutureOr<void> uploadImage(UploadImageEvent event, Emitter<ProfileimageState> emit)async {
      XFile?file =await profileImage.uploadImages();
    
    emit(state.copyWith(file: file));  
  }

  FutureOr<void> afterUpdate(AfterUpdateEvent event, Emitter<ProfileimageState> emit) {
      emit(state.copyWith(file: null));  
  }
}
