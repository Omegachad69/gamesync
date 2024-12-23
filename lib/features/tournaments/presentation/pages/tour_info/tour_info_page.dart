import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/format_date.dart';
import 'package:gameync/core/utils/show_snackbar.dart';

import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';
import 'package:gameync/features/tournaments/presentation/pages/tour_admin/tour_admin_info_pageo/widgets/custom_dialog.dart';

class TourInfoPage extends StatefulWidget {
  final Tour tour;
  const TourInfoPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourInfoPage> createState() => _TourInfoPageState();
}

class _TourInfoPageState extends State<TourInfoPage> {
  bool isJoined = false;
  bool isTapped1 = false;
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
    context.read<ParticipantBloc>().add(ParticipantIsUserJoined(
        tid: widget.tour.tid,
        uid: (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
            .user
            .uid));
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
                          '${formatDateBydMMMYYYY(
                            widget.tour.dateTime,
                          )}',
                          style: AppStyles.button15(),
                        ),
                      ),
                      SizedBox(height: 20),
                      BlocConsumer<ParticipantBloc, ParticipantState>(
                        listener: (context, state) {
                          if (state is ParticipantFailure) {
                            if (state.error ==
                                'duplicate key value violates unique constraint "unique_user_group"') {
                              return showSnackBar(
                                  context, 'User Already Joined');
                            }
                            return showSnackBar(context, state.error);
                          }
                          if (state is ParticipantIsJoinedSuccess) {
                            isJoined = state.isJoined;
                          }

                          if (state is ParticipationSuccess) {
                            isJoined = true;
                          }
                          if (state is ParticipantLeaveSuccess) {
                            isJoined = false;
                          }
                        },
                        builder: (context, state) {
                          if (state is ParticipantLoading) {
                            return const Loader();
                          }
                          if (state is ParticipationSuccess) {
                            return TourGradientButton(
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
                                isCreateTour: false);
                          }

                          return isJoined
                              ? TourGradientButton(
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
                                  isCreateTour: false)
                              : TourGradientButton(
                                  height: double.infinity,
                                  width: double.infinity,
                                  buttonText: 'Join',
                                  onTap: () {
                                    joinTours();
                                  },
                                  isCreateTour: false);
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Description',
                        style: AppStyles.button15(
                            size: 17, fweight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.tour.descp,
                        style: AppStyles.button15(
                          fweight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Rules',
                        style: AppStyles.button15(
                            size: 17, fweight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.tour.descp,
                        style: AppStyles.button15(
                          fweight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Info',
                        style: AppStyles.button15(
                            size: 17, fweight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Bubbles(
                            widget: widget,
                            text:
                                '${widget.tour.cPart}/${widget.tour.maxPartcipants} Slots',
                          ),
                          Bubbles(
                            widget: widget,
                            text: widget.tour.isduel ? 'Duel' : 'Battle Royale',
                          ),
                          Bubbles(
                            widget: widget,
                            text: widget.tour.ispvp ? 'P v P' : 'T v T',
                          ),
                        ],
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

  final TourInfoPage widget;

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

// class CurvedEdgescust extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.moveTo(0, 30);

//     path.quadraticBezierTo(size.width / 5, 2.8, size.width / 5 + 25, 0);

//     path.quadraticBezierTo(
//         size.width, size.height / 30, size.width, size.height / 1000);

//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     throw true;
//   }
// }
