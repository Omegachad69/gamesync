import 'package:bloc/bloc.dart';
import 'package:gameync/core/common/entities/tour.dart';

import 'package:gameync/features/tournaments/domain/usecases/get_user_tours.dart';
import 'package:meta/meta.dart';

part 'temp_event.dart';
part 'temp_state.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  final GetUserTours _getUserTours;
  TempBloc({
    required GetUserTours getUserTours,
  })  : _getUserTours = getUserTours,
        super(TempInitial()) {
    on<TempEvent>((event, emit) => emit(TempLoading()));
    on<TempUserTourFetch>(_onTempUserTourFetch);
  }

  void _onTempUserTourFetch(
      TempUserTourFetch event, Emitter<TempState> emit) async {
    final res = await _getUserTours(GetUserTourParams(event.pid));
    res.fold((l) => emit(TempFailure(l.message)), (r) => emit(TempSuccess(r)));
  }
}
