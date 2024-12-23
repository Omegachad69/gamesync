import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';

import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/tournaments/domain/entities/particioant.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';

class Matches extends StatefulWidget {
  final Tour tour;
  const Matches({super.key, required this.tour});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  @override
  void initState() {
    context.read<ParticipantBloc>().add(ParticipantFetch(tid: widget.tour.tid));
    super.initState();
  }

  // List<String> shuffleAndExtractUids(List<Participant> participants) {
  //   final _random = Random();
  //   participants.shuffle(_random);
  //   return participants.map((participant) => participant.uid).toList();
  // }

  List<List<String>> shuffleAndPairUids(List<Participant> participants) {
    final _random = Random();
    participants.shuffle(_random);

    List<List<String>> pairedUids = [];
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

  @override
  Widget build(BuildContext context) {
    if ((widget.tour.maxPartcipants != widget.tour.cPart)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 40),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/images/icons/time-passing.png',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, top: 20),
            child: Text(
              'Matching only available after limit reached or on Due date',
              style: AppStyles.appBar30(size: 20),
            ),
          )
        ],
      );
    }
    return BlocConsumer<ParticipantBloc, ParticipantState>(
      listener: (context, state) {
        if (state is ParticipantFailure) {
          return showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is ParicipantsDisplaySuccess) {
          List<List<String>> pids = shuffleAndPairUids(state.participants);

          return Container(
            height: 700,
            width: 500,
            child: ListView.builder(
                itemCount: ((state.participants.length) / 2).floor(),
                itemBuilder: (context, index) {
                  List<String> pair = pids[index];
                  return MatchView(
                      uname: getUsernameForUid(pair[0], state.participants),
                      uname2: getUsernameForUid(pair[1], state.participants));
                }),
          );
        }

        return SizedBox();
      },
    );
  }
}

class MatchView extends StatelessWidget {
  const MatchView({
    super.key,
    required this.uname,
    required this.uname2,
  });
  final String uname;
  final String uname2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 367,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 150,
                        child: Image.asset(
                            'assets/images/games/leagueoflegends.jpg')),
                    Text(
                      uname,
                      style: AppStyles.button15(),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    'V/S',
                    style: AppStyles.time30(),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 150,
                        child: Image.asset(
                            'assets/images/games/leagueoflegends.jpg')),
                    Text(
                      uname2,
                      style: AppStyles.button15(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FrostedGlassBox(
              theWidth: 100,
              theHeight: 3,
              bgcolor: Colors.white.withOpacity(0.3),
              theChild: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
