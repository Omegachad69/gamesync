import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/entities/user.dart';
import 'package:gameync/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/domain/usecases/get_all_tours.dart';
import 'package:gameync/features/tournaments/domain/usecases/participate_on_tour.dart';
import 'package:gameync/features/tournaments/domain/usecases/upload_tour.dart';

part 'tour_event.dart';
part 'tour_state.dart';

class TourBloc extends Bloc<TourEvent, TourState> {
  final UploadTour _uploadTour;
  final GetAllTours _getAllTours;
  // final ParticipateOnTours _participateOnTours;
  // final ParticiPants _particiPants;
  // final IsUserJoined _userJoined;

  TourBloc({
    required UploadTour uploadTour,
    required GetAllTours getAllTours,
    // required ParticipateOnTours participateOnTours,
    // required ParticiPants particiPants,
    // required IsUserJoined isUserJoined,
  })  : _uploadTour = uploadTour,
        _getAllTours = getAllTours,
        // _participateOnTours = participateOnTours,
        // _particiPants = particiPants,
        // _userJoined = isUserJoined,
        super(TourInitial()) {
    on<TourEvent>((event, emit) => emit(TourLoading()));

    on<TourUploadToCloud>(_onTourUploadToCloud);
    on<TourFetchAllTours>(_onTourFetchAlllTours);
    // on<TourParticipation>(_onTourParticipation);
    // on<TourParticipantFetch>(_onTourParticipantFetch);
    // on<TourIsUserJoined>(_onTourIsUserJoined);
  }

  void _onTourUploadToCloud(
      TourUploadToCloud event, Emitter<TourState> emit) async {
    final res = await _uploadTour(UploadTourParams(
        tname: event.tname,
        adminId: event.adminId,
        descp: event.descp,
        rules: event.rules,
        dateTime: event.dateTime,
        image: event.image,
        isPaid: event.isPaid,
        ispvp: event.ispvp,
        isduel: event.isduel,
        maxPartcipants: event.maxPartcipants,
        maxTeam: event.maxTeam,
        pricepool: event.pricepool,
        isprivate: event.isprivate,
        inviteLink: event.inviteLink,
        noWinners: event.noWinners,
        cPart: event.cPart,
        entryfee: event.entryfee,
        game: event.game));

    res.fold((l) => emit(TourFailure(l.message)), (r) => emit(TourSuccess()));
  }

  void _onTourFetchAlllTours(TourFetchAllTours event, Emitter emit) async {
    final res = await _getAllTours(NoParams());
    res.fold((l) => emit(TourFailure(l.message)),
        (r) => emit(TourDisplaySuccess(r)));
  }

  // void _onTourParticipation(
  //     TourParticipation event, Emitter<TourState> emit) async {
  //   final res = await _participateOnTours(PartcipateTourParams(
  //       tid: event.tid, uid: event.uid, cPart: event.cPart));

  //   res.fold((l) => emit(TourFailure(l.message)),
  //       (r) => emit(TourParticipationSuccess()));
  // }

  // void _onTourParticipantFetch(
  //     TourParticipantFetch event, Emitter<TourState> emit) async {
  //   final res = await _particiPants(ParticpantParms(tid: event.tid));

  //   res.fold((l) => emit(TourFailure(l.message)),
  //       (r) => emit(TourParicipantsDisplaySuccess(r)));
  // }

  // void _onTourIsUserJoined(
  //     TourIsUserJoined event, Emitter<TourState> emit) async {
  //   final isJoined =
  //       await _userJoined(IsJoinedParams(uid: event.uid, tid: event.tid));
  //   isJoined.fold((l) => emit(TourFailure(l.message)),
  //       (r) => emit(TourIsJoinedSuccess(r)));
  // }
}
