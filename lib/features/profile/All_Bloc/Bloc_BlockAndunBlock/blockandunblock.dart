import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_BlockAndunBlock/blockandunblockState.dart';
import 'package:trend/features/profile/All_Bloc/Bloc_BlockAndunBlock/blockandunblockevent.dart';

class Blockbloc extends Bloc<BlockEvent, Blockandunblockstate> {
  Dio dio;
  Blockbloc(this.dio) : super(initunBlocsuccess()) {
    on<unBlock>(_unBlock);
  }

  Future<void> _unBlock(
    unBlock event,
    Emitter<Blockandunblockstate> emit,
  ) async {
    try {
      String? tok = await token.getToken();
      print(tok);
      final url = 'http://167.71.92.176/profile/${event.id}/unblock/';
      emit(unBlocLoading());
      final response = await dio.post(
        url,
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );

      if (response.statusCode == 200) {
        emit(unBlocsuccess());
      } else {
        print('Failed to unblock user. Status code: ${response.statusCode}');
      }
    } catch (e) {
      emit(unBlocFailuer());
    }
  }
}
