part of 'profileimage_bloc.dart';

 class ProfileimageState extends Equatable {
    
  final XFile? file;

  
   const ProfileimageState({required this.file});
  



  ProfileimageState copyWith({XFile? file}){
   
    return ProfileimageState(file: file ?? this.file);
  }
  @override
  List<Object?> get props => [file];
}


