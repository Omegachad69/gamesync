import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';

import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';
import 'package:gameync/features/matches/presentation/pages/matchgen/matchgen_dialog.dart';
import 'package:gameync/features/matches/presentation/pages/widgets/match_view_2.0_w.dart';

import 'package:gameync/core/common/entities/tour.dart';

class MatchGenPage extends StatefulWidget {
  final Tour tour;
  const MatchGenPage({super.key, required this.tour});

  @override
  State<MatchGenPage> createState() => _MatchGenState();
}

class _MatchGenState extends State<MatchGenPage> {
  @override
  void initState() {
    context.read<MatchBloc>().add(MatchFetch(tid: widget.tour.tid, rno: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchBloc, MatchState>(
      listener: (context, state) {
        if (state is MatchFailure) {
          return showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is MatchLoading) {
          return const Loader();
        }
        if (state is MatchWinnerSuccess) {
          context
              .read<MatchBloc>()
              .add(MatchFetch(tid: widget.tour.tid, rno: 0));
        }
        if (state is MatchDisplaySuccess) {
          if (state.matches.isEmpty) {
            return Center(
              child: TourGradientButton(
                  buttonText: 'Generate Matches',
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => MatchGenConstraints()));\
                    showDialog(
                        context: context,
                        builder: (context) => MatchGenDialog(
                              tour: widget.tour,
                            ));
                  },
                  isCreateTour: false),
            );
          }

          return Container(
            height: 700,
            width: 500,
            child: ListView.builder(
                itemCount: state.matches.length,
                itemBuilder: (context, index) {
                  return MatchView2(
                    uname: '${state.matches[index].p1name}',
                    uname2: '${state.matches[index].p2name}',
                    winnername: '${state.matches[index].winner}',
                    p1: state.matches[index].p1,
                    p2: state.matches[index].p2,
                    mid: state.matches[index].mid,
                  );
                }),
          );
        }
        return IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              context
                  .read<MatchBloc>()
                  .add(MatchFetch(tid: widget.tour.tid, rno: 0));
            });
          },
        );
      },
    );
  }
}
