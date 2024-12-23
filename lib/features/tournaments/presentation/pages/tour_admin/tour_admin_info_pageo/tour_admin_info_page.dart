import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/features/matches/presentation/pages/matchgenpage.dart';
import 'package:gameync/features/matches/presentation/pages/winners.dart';

import 'package:gameync/features/tournaments/presentation/pages/tour_admin/tour_admin_info_pageo/widgets/overview_details.dart';
import 'package:gameync/features/tournaments/presentation/pages/tour_admin/tour_admin_info_pageo/widgets/participants.dart';

import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';

class TourAdminInfoPage extends StatefulWidget {
  final Tour tour;
  const TourAdminInfoPage({Key? key, required this.tour}) : super(key: key);

  @override
  State<TourAdminInfoPage> createState() => _TourAdminInfoPageState();
}

class _TourAdminInfoPageState extends State<TourAdminInfoPage> {
  bool isTapped1 = false;
  int index1 = 0;
  final searchBarController = TextEditingController();
  bool isJoined = false;
  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(CupertinoIcons.back)),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset(
          //   'assets/images/background/black-amoled-4K-wallpaper-scaled.jpg',
          //   fit: BoxFit.cover,
          // ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 5, sigmaY: 2.9),
          //   child: Container(
          //     color: Colors.black.withOpacity(0.6),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FrostedGlassBox(
                          theRadius2: 10,
                          theRadius: 10,
                          theHeight: 300,
                          theWidth: 220,
                          theChild: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(49)),
                            height: 290,
                            width: 210,
                            child: Image.network(
                              widget.tour.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 150,
                            height: 90,
                            child: Center(
                              child: Text(
                                widget.tour.tname,
                                maxLines: 3,
                                style: AppStyles.heading40Bold(size: 23),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FrostedGlassBox(
                            theHeight: 50,
                            theWidth: 150,
                            theRadius2: 10,
                            theRadius: 10,
                            theChild: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.tour.isPaid
                                    ? widget.tour.entryfee.toString()
                                    : 'Free',
                                style: AppStyles.button15(size: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: SizedBox(
                              height: 40,
                              width: 120,
                              child: TourGradientButton(
                                  buttonText: 'Delete ',
                                  onTap: () {},
                                  isCreateTour: false),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 30)
                            .copyWith(bottom: 20),
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
                      tabBackgroundColor: AppPallete.gradient1.withAlpha(170),
                      padding: const EdgeInsets.all(14),
                      tabs: const [
                        GButton(
                          icon: Icons.home,
                          text: 'Overview',
                        ),
                        GButton(
                          icon: Icons.person,
                          text: 'Participants',
                        ),
                        GButton(
                          icon: Icons.event,
                          text: 'Matches',
                        ),
                        GButton(
                          icon: Icons.wallet,
                          text: 'Winners',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: index1 == 0
                        ? Details(
                            tour: widget.tour,
                          )
                        : index1 == 1
                            ? Participants(
                                tour: widget.tour,
                                searchBarController: searchBarController)
                            : index1 == 2
                                ? MatchGenPage(
                                    tour: widget.tour,
                                  )
                                : const Winners(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
