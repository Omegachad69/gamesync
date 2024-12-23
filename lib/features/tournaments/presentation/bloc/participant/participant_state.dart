part of 'participant_bloc.dart';

@immutable
sealed class ParticipantState {}

final class ParticipantInitial extends ParticipantState {}

final class ParticipantLoading extends ParticipantState {}

final class ParticipantFailure extends ParticipantState {
  final String error;

  ParticipantFailure(this.error);
}

final class ParticipationSuccess extends ParticipantState {}

final class ParicipantsDisplaySuccess extends ParticipantState {
  final List<Participant> participants;

  ParicipantsDisplaySuccess(this.participants);
}

final class ParticipantIsJoinedSuccess extends ParticipantState {
  final bool isJoined;
  ParticipantIsJoinedSuccess(this.isJoined);
}

final class ParticipantLeaveSuccess extends ParticipantState {}
