import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_States.dart';
import 'package:trend/features/bottom_nav_bar/Bloc/Bottom_Nav_event.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial()) {
    on<BottomNavItemSelected>((event, emit) {
      emit(BottomNavUpdated(event.index));
    });
  }
}
