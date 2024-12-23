import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/format_date.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';
import 'package:gameync/features/matches/presentation/pages/match_view.dart';
import 'package:gameync/features/matches/presentation/pages/widgets/match_view_2.0_w.dart';

import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';
import 'package:gameync/features/tournaments/presentation/pages/tour_admin/tour_admin_info_pageo/widgets/custom_dialog.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

class PTourInfoPage extends StatefulWidget {
  final Tour tour;
  const PTourInfoPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<PTourInfoPage> createState() => _PTourInfoPageState();
}

class _PTourInfoPageState extends State<PTourInfoPage> {
  int index1 = 0;
  void leaveTour() {
    print('tapped');
    context.read<ParticipantBloc>().add(
          ParticipentLeaveEvent(
            tid: widget.tour.tid,
            uid: (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
                .user
                .uid,
            cPart: widget.tour.cPart! - 1,
          ),
        );
  }

  void joinTours() {
    final uid = (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
        .user
        .uid;

    context.read<ParticipantBloc>().add(Participation(
        tid: widget.tour.tid, uid: uid, cPart: (widget.tour.cPart!) + 1));
  }

  @override
  void initState() {
    context.read<MatchBloc>().add(MatchFetch(tid: widget.tour.tid, rno: 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppPallete.backgroundColor,
            elevation: 0,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(
                  widget.tour.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(25)),
              child: FrostedGlassBox(
                theHeight: MediaQuery.of(context).size.height,
                theWidth: 500,
                theRadius2: 0,
                theRadius: 0,
                theChild: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: FrostedGlassBox(
                            theWidth: 150, theHeight: 5, theChild: SizedBox()),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          widget.tour.tname,
                          style: AppStyles.heading40Bold(size: 30),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          widget.tour.dateTime == DateTime.now()
                              ? '${formatDateBydMMMYYYY(
                                  widget.tour.dateTime,
                                )}'
                              : 'Started',
                          style: AppStyles.button15(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TourGradientButton(
                          height: double.infinity,
                          width: double.infinity,
                          buttonText: 'Joined',
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                      tname: widget.tour.tname,
                                      onTap: () {
                                        leaveTour();
                                      },
                                    ));
                          },
                          isCreateTour: false),
                      SizedBox(height: 30),
                      Text(
                        'Upcoming Macthes',
                        style: AppStyles.button15(
                            size: 17, fweight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ).copyWith(bottom: 20),
                        child: GNav(
                          onTabChange: (index) {
                            setState(() {
                              index1 = index;
                            });
                          },
                          textStyle: AppStyles.button15(
                              size: 13, fweight: FontWeight.w600),
                          gap: 8,
                          backgroundColor: Colors.transparent,
                          rippleColor: AppPallete.gradient1,
                          tabBackgroundColor:
                              AppPallete.gradient1.withAlpha(170),
                          padding: const EdgeInsets.all(14),
                          tabs: const [
                            GButton(
                              icon: Icons.home,
                              text: 'Upcoming Matches',
                            ),
                            GButton(
                              icon: Icons.person,
                              text: 'Finished Matches',
                            ),
                          ],
                        ),
                      ),
                      BlocConsumer<MatchBloc, MatchState>(
                        listener: (context, state) {
                          if (state is MatchFailure) {
                            return showSnackBar(context, state.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is MatchLoading) {
                            return const Loader();
                          }
                          if (state is MatchDisplaySuccess) {
                            return SizedBox(
                              height: 400,
                              width: 400,
                              child: ListView.builder(
                                  itemCount: state.matches.length,
                                  itemBuilder: (context, index) {
                                    final match = state.matches[index];
                                    print(match.winner);
                                    if (index1 == 0 && match.winner == null) {
                                      return MatchView(
                                          uname: '${match.p1name}',
                                          uname2: '${match.p2name}');
                                    } else if (index1 == 1 &&
                                        match.winner != null) {
                                      return MatchView2(
                                          uname: '${match.p1name}',
                                          uname2: '${match.p2name}',
                                          winnername: '${match.winner}',
                                          p1: match.p1,
                                          p2: match.p2,
                                          mid: match.mid);
                                    }

                                    SizedBox();
                                  }),
                            );
                          }
                          return SizedBox();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   height: 200,
            //   color: Colors.yellow,
            // ),
            // Container(
            //   height: 200,
            //   color: Colors.blue,
            // ),
            // Container(
            //   height: 200,
            //   color: Colors.green,
            // ),
            // Container(
            //   height: 200,
            //   color: Colors.orange,
            // ),
          ]))
        ],
      ),
    );
  }
}

class Bubbles extends StatelessWidget {
  final String text;
  const Bubbles({
    super.key,
    required this.widget,
    required this.text,
  });

  final PTourInfoPage widget;

  @override
  Widget build(BuildContext context) {
    return FrostedGlassBox(
        theWidth: 90,
        theHeight: 30,
        theChild: Text(
          text,
          style: AppStyles.button15(fweight: FontWeight.bold, size: 12),
        ));
  }
}
