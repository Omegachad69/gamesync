import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/format_date.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/pages/tour_admin/tour_admin_info_pageo/tour_admin_info_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class AdminCard extends StatelessWidget {
  final Tour tour;
  const AdminCard({
    super.key,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    if (tour.adminId ==
        (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
            .user
            .uid) {
      return GestureDetector(
        onTap: () =>
            pushScreenWithoutNavBar(context, TourAdminInfoPage(tour: tour)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: Stack(fit: StackFit.expand, children: [
              FrostedGlassBox(
                  theWidth: double.infinity,
                  theHeight: 200,
                  theChild: Row(
                    children: [
                      Container(
                        width: 210,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21)),
                        child: Image.network(tour.imageUrl, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 12),
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 150,
                              child: Center(
                                child: Text(
                                  tour.tname,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyles.heading40Bold(size: 20),
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(17)),
                              child: Center(
                                child: Text(
                                  tour.ispvp ? 'P v P' : 'T v T',
                                  style: AppStyles.button15(
                                    size: 12,
                                    fweight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FrostedGlassBox(
                              theHeight: 20,
                              theWidth: 90,
                              theChild: Text(
                                tour.game,
                                overflow: TextOverflow.fade,
                                style: AppStyles.button15(
                                    size: 12, color: AppPallete.gradient3),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              formatDateBydMMMYYYY(tour.dateTime),
                              style: AppStyles.button15(),
                            ),
                            Text(
                              tour.isPaid ? tour.entryfee.toString() : 'Free',
                              style: AppStyles.button15(
                                color: Colors.cyan,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${tour.cPart}/${tour.maxPartcipants}',
                              style: AppStyles.button15(size: 12),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ]),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
