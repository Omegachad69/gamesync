import 'package:bloc/bloc.dart';
import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/features/tournaments/domain/usecases/participate_on_tour.dart';
import 'package:meta/meta.dart';

part 'participant_event.dart';
part 'participant_state.dart';

class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  final ParticipateOnTours _participateOnTours;
  final ParticiPants _particiPants;
  final IsUserJoined _userJoined;
  final LeaveParticipant _leaveParticipant;
  ParticipantBloc({
    required ParticipateOnTours participateOnTours,
    required ParticiPants particiPants,
    required IsUserJoined isUserJoined,
    required LeaveParticipant leaveParticipant,
  })  : _participateOnTours = participateOnTours,
        _particiPants = particiPants,
        _userJoined = isUserJoined,
        _leaveParticipant = leaveParticipant,
        super(ParticipantInitial()) {
    on<ParticipantEvent>((event, emit) => emit(ParticipantLoading()));
    on<Participation>(_onParticipation);
    on<ParticipantFetch>(_onParticipantFetch);
    on<ParticipantIsUserJoined>(_onParticipationIsUserJoined);
    on<ParticipentLeaveEvent>(_onParticipentLeaveEvent);
  }

  void _onParticipation(
      Participation event, Emitter<ParticipantState> emit) async {
    final res = await _participateOnTours(PartcipateTourParams(
        tid: event.tid, uid: event.uid, cPart: event.cPart));

    res.fold((l) => emit(ParticipantFailure(l.message)),
        (r) => emit(ParticipationSuccess()));
  }

  void _onParticipantFetch(
      ParticipantFetch event, Emitter<ParticipantState> emit) async {
    final res = await _particiPants(ParticpantParms(tid: event.tid));

    res.fold((l) => emit(ParticipantFailure(l.message)),
        (r) => emit(ParicipantsDisplaySuccess(r)));
  }

  void _onParticipationIsUserJoined(
      ParticipantIsUserJoined event, Emitter<ParticipantState> emit) async {
    final isJoined =
        await _userJoined(IsJoinedParams(uid: event.uid, tid: event.tid));
    isJoined.fold((l) => emit(ParticipantFailure(l.message)),
        (r) => emit(ParticipantIsJoinedSuccess(r)));
  }

  void _onParticipentLeaveEvent(
      ParticipentLeaveEvent event, Emitter<ParticipantState> emit) async {
    final isLeft = await _leaveParticipant(
        LeaveParams(uid: event.uid, tid: event.tid, cPart: event.cPart));

    isLeft.fold((l) => emit(ParticipantFailure(l.message)),
        (r) => emit(ParticipantLeaveSuccess()));
  }
}
