import 'package:flutter_bloc/flutter_bloc.dart';

import 'explore_search_tap_bar_event.dart';
import 'explore_search_tap_bar_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState(0)) {
    on<TabChanged>((event, emit) {
      emit(TabState(event.index));
      print(event.index);
    });
  }
}
