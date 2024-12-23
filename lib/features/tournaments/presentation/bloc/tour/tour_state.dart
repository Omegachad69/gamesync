part of 'tour_bloc.dart';

@immutable
sealed class TourState {}

final class TourInitial extends TourState {}

final class TourLoading extends TourState {}

final class TourFailure extends TourState {
  final String error;
  TourFailure(this.error);
}

final class TourSuccess extends TourState {}

final class TourDisplaySuccess extends TourState {
  final List<Tour> tours;

  TourDisplaySuccess(this.tours);
}

// final class TourParticipationSuccess extends TourState {}

// final class TourParicipantsDisplaySuccess extends TourState {
//   final List<Participant> participants;

//   TourParicipantsDisplaySuccess(this.participants);
// }

// final class TourIsJoinedSuccess extends TourState {
//   final bool isJoined;
//   TourIsJoinedSuccess(this.isJoined);
// }
