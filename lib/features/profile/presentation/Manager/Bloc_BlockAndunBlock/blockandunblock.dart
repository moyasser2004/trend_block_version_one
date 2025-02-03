import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_BlockAndunBlock/blockandunblockState.dart';
import 'package:trend/features/profile/presentation/Manager/Bloc_BlockAndunBlock/blockandunblockevent.dart';

class Blockbloc extends Bloc<BlockEvent, Blockandunblockstate> {
  ProfileRemoteDatasource profileRemoteDatasource;
  Blockbloc(this.profileRemoteDatasource) : super(initunBlocsuccess()) {
    on<unBlock>(_unBlock);
  }

  Future<void> _unBlock(
    unBlock event,
    Emitter<Blockandunblockstate> emit,
  ) async {
    emit(unBlocLoading());
    try {
      final success = await profileRemoteDatasource.unblockUser("${event.id}");
      if (success) {
        emit(unBlocsuccess());
      } else {
        emit(unBlocFailuer());
      }
    } catch (e) {
      emit(unBlocFailuer());
    }
  }
}
