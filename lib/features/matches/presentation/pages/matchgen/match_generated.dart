import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';

import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';
import 'package:gameync/features/matches/presentation/pages/match_view.dart';
import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/core/common/entities/tour.dart';

import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';

class MatchGenerated extends StatefulWidget {
  final bool againstEach;
  final String dpc;
  final String mc;
  final int rounds;
  final Tour tour;
  const MatchGenerated(
      {super.key,
      required this.tour,
      required this.againstEach,
      required this.dpc,
      required this.mc,
      required this.rounds});

  @override
  State<MatchGenerated> createState() => _MatchGeneratedState();
}

class _MatchGeneratedState extends State<MatchGenerated> {
  @override
  void initState() {
    context.read<ParticipantBloc>().add(ParticipantFetch(tid: widget.tour.tid));
    super.initState();
  }

  void uploadMatch() {
    for (int i = 0; i < (pairedUids.length) / 2.floor(); i++) {
      List<String> pair = pairedUids[i];
      context.read<MatchBloc>().add(MatchUploadToCloud(
          p1: pair[0], p2: pair[1], rno: widget.rounds, tid: widget.tour.tid));
    }
  }

  List<List<String>> shuffleAndPairUids(List<Participant> participants) {
    final _random = Random();
    participants.shuffle(_random);

    for (int i = 0; i < participants.length; i += 2) {
      if (i + 1 < participants.length) {
        pairedUids.add([participants[i].uid, participants[i + 1].uid]);
      } else {
        // Handle the case where there's an odd number of participants
        // You might want to add the last one to a list by itself or pair it with a dummy value
        pairedUids.add([participants[i].uid]);
      }
    }

    return pairedUids;
  }

  String getUsernameForUid(String uid, List<Participant> participants) {
    final participant = participants.firstWhere(
      (p) => p.uid == uid,
    );
    return participant.uname;
  }

  List<List<String>> pairedUids = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: Text(
                widget.rounds == 0
                    ? 'Initial Round'
                    : 'Round: ${widget.rounds.toString()}',
                style: AppStyles.appBar30(),
              ),
            ),
            BlocConsumer<ParticipantBloc, ParticipantState>(
              listener: (context, state) {
                if (state is ParticipantFailure) {
                  return showSnackBar(context, state.error);
                }
              },
              builder: (context, state) {
                if (state is ParicipantsDisplaySuccess) {
                  List<List<String>> pids =
                      shuffleAndPairUids(state.participants);

                  return Container(
                    height: 700,
                    width: 500,
                    child: ListView.builder(
                        itemCount: ((state.participants.length) / 2).floor(),
                        itemBuilder: (context, index) {
                          List<String> pair = pids[index];

                          return MatchView(
                              uname: getUsernameForUid(
                                  pair[0], state.participants),
                              uname2: getUsernameForUid(
                                  pair[1], state.participants));
                        }),
                  );
                }

                return SizedBox();
              },
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 150,
                child: TourGradientButton(
                    buttonText: 'Refresh ',
                    onTap: () {
                      setState(() {});
                    },
                    isCreateTour: false),
              ),
              Container(
                width: 150,
                child: TourGradientButton(
                    buttonText: 'Confirm ',
                    onTap: () {
                      uploadMatch();
                      Navigator.pop(context);
                    },
                    isCreateTour: false),
              ),
            ],
          ),
        ));
  }
}
