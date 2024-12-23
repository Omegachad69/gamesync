import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/common/widgets/presistant_navbar.dart';
import 'package:gameync/core/common/widgets/search_field.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/app_pallete.dart';

import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/tournaments/presentation/bloc/tour/tour_bloc.dart';

import 'package:gameync/features/tournaments/presentation/widgets/time_line.dart';

import 'package:gameync/features/tournaments/presentation/widgets/tour_switch.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TourCreatePage3 extends StatefulWidget {
  final String tname;
  final String game;
  final String desc;
  final String rules;
  final DateTime dateTime;
  final File image;
  final bool ispvp;
  final bool isduel;
  final int? maxTeam;
  final int maxParticipants;

  const TourCreatePage3({
    Key? key,
    required this.tname,
    required this.game,
    required this.desc,
    required this.rules,
    required this.dateTime,
    required this.image,
    required this.ispvp,
    required this.isduel,
    required this.maxTeam,
    required this.maxParticipants,
  }) : super(key: key);

  @override
  State<TourCreatePage3> createState() => _TourCreatePage3State();
}

class _TourCreatePage3State extends State<TourCreatePage3> {
  int tapped = 0;
  int tapped2 = 0;
  int tapped3 = 0;
  bool isprivate = false;
  bool ispaid = false;
  bool isprizepool = false;
  bool notCom = true;
  final entryFeeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final pricePoolController = TextEditingController();

  void uploadTour() {
    if (formKey.currentState!.validate()) {
      final adminId =
          (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
              .user
              .uid;
      print('admin id $adminId');

      context.read<TourBloc>().add(TourUploadToCloud(
            tname: widget.tname,
            adminId: adminId,
            descp: widget.desc,
            rules: widget.rules,
            dateTime: widget.dateTime,
            image: widget.image,
            isPaid: ispaid,
            ispvp: widget.ispvp,
            isduel: widget.isduel,
            maxPartcipants: widget.maxParticipants,
            maxTeam: widget.maxTeam,
            pricepool: double.tryParse(pricePoolController.text.trim()),
            isprivate: isprivate,
            inviteLink: '',
            noWinners: 2,
            cPart: 0,
            entryfee: double.tryParse(entryFeeController.text.trim()),
            game: widget.game,
          ));
    }
  }

  @override
  void dispose() {
    entryFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<TourBloc, TourState>(
        listener: (context, state) {
          if (state is TourFailure) {
            showSnackBar(context, state.error);
          } else if (state is TourSuccess) {
            pushScreenWithNavBar(context, PresistentNavBar());
          }
        },
        builder: (context, state) {
          if (state is TourLoading) {
            return const Loader();
          }
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/background/photo_2024-04-12_17-19-32.jpg',
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 2.9),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const TimeLine(
                        cPage: 3,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 22,
                              ),
                              Text(
                                'Choose Settings',
                                style: AppStyles.heading40Bold(size: 30),
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              Text(
                                'Type',
                                style: AppStyles.info14(
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TourSwitch(
                                text1: 'Private',
                                text2: 'Public',
                                onTap1: () {
                                  setState(() {
                                    tapped = 1;
                                    isprivate = true;
                                  });
                                },
                                onTap2: () {
                                  setState(
                                    () {
                                      tapped = 2;
                                      isprivate = false;
                                    },
                                  );
                                },
                                tapped: tapped,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              isprivate
                                  ? FrostedGlassBox(
                                      theWidth: double.infinity,
                                      theHeight: 60,
                                      theChild: Text(
                                        'Click to generate Code',
                                        style: AppStyles.button15(),
                                      ))
                                  : const SizedBox(height: 0),
                              const SizedBox(
                                height: 22,
                              ),
                              Text(
                                'Entry',
                                style: AppStyles.info14(
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TourSwitch(
                                text1: 'Free',
                                text2: 'Paid',
                                onTap1: () {
                                  setState(() {
                                    tapped2 = 1;
                                    ispaid = false;
                                  });
                                },
                                onTap2: () {
                                  setState(
                                    () {
                                      tapped2 = 2;
                                      ispaid = true;
                                    },
                                  );
                                },
                                tapped: tapped2,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ispaid
                                  ? TtextPage(
                                      isNumber: true,
                                      controller: entryFeeController,
                                      hintText: 'Enter the Entry Fee',
                                      height: 95,
                                      maxLine: 1)
                                  : const SizedBox(),
                              const SizedBox(
                                height: 22,
                              ),
                              Text(
                                'Entry',
                                style: AppStyles.info14(
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TourSwitch(
                                text1: 'Prize pool',
                                text2: 'No prize pool',
                                onTap1: () {
                                  setState(() {
                                    tapped3 = 1;
                                    isprizepool = true;
                                  });
                                },
                                onTap2: () {
                                  setState(
                                    () {
                                      tapped3 = 2;
                                      isprizepool = false;
                                    },
                                  );
                                },
                                tapped: tapped3,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              isprizepool
                                  ? TtextPage(
                                      isNumber: true,
                                      controller: pricePoolController,
                                      hintText: 'Enter prize pool in INR',
                                      height: 95,
                                      maxLine: 1)
                                  : const SizedBox(),
                              ispaid && !isprizepool
                                  ? (Text(
                                      'Must have a price pool if entry is paid',
                                      style: AppStyles.button15(
                                          color: AppPallete.errorColor),
                                    ))
                                  : const SizedBox(),
                              const SizedBox(height: 30),
                              TourGradientButton(
                                  buttonText: 'Finish',
                                  onTap: () {
                                    uploadTour();
                                  },
                                  isCreateTour: false),
                              const SizedBox(height: 30),
                              const SizedBox(height: 30),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
