part of 'bottom_nav_bloc.dart';

sealed class BottomNavState extends Equatable {
  const BottomNavState();
  
  @override
  List<Object> get props => [];
}

final class BottomNavChageState extends BottomNavState {
  final int index;

  
  BottomNavChageState({required this.index});

List<Object> get props =>[index];

}
