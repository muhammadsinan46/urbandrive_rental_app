part of 'bottom_nav_bloc.dart';

 class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class BottomNavChageEvent extends BottomNavEvent{

 final  int index;
const   BottomNavChageEvent({required this.index});
 
}