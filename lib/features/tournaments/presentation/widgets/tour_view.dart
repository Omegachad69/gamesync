import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/data/games_list.dart';

import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/format_date.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/pages/tour_info/tour_info_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TourCard extends StatelessWidget {
  final Tour tour;
  const TourCard({super.key, required this.tour});
  String findLogoPath(String gameName) {
    final gameEntry = mobileEsportGames.firstWhere(
      (entry) => entry['name'] == gameName,
    );

    return gameEntry != null ? gameEntry['logo'] : null;
  }

  @override
  Widget build(BuildContext context) {
    if (tour.adminId !=
            (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
                .user
                .uid &&
        tour.maxPartcipants != tour.cPart) {
      return GestureDetector(
        onTap: () {
          pushScreenWithoutNavBar(
              context,
              TourInfoPage(
                tour: tour,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: FrostedGlassBox(
            bgcolor: Colors.black.withOpacity(0.6),
            theWidth: double.infinity,
            theHeight: 150,
            theChild: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 180,
                    child: Stack(fit: StackFit.loose, children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 150,
                          height: 140,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.network(
                              tour.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 37,
                          bottom: 20,
                          child: FrostedGlassBox(
                              bgcolor: Colors.black.withOpacity(0.5),
                              theRadius: 8,
                              theRadius2: 8,
                              theWidth: 90,
                              theHeight: 25,
                              theChild: Text(
                                formatDateBydMMMYYYY(tour.dateTime),
                                style: AppStyles.button15(size: 11),
                              ))),

                      // tour.pricepool.toString().isEmpty
                      Positioned(
                          left: 2.5,
                          top: 30,
                          child: Transform.rotate(
                            angle: -3.14 / 4,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.orange, Colors.red],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: FrostedGlassBox(
                                theRadius2: 5,
                                theRadius: 5,
                                theWidth: 70,
                                theHeight: 20,
                                theChild: Center(
                                  child: Text(
                                    '200000',
                                    style: AppStyles.button15(size: 11),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      // : SizedBox()
                    ]),
                  ),
                  // RotatedBox(
                  //     quarterTurns: 1,
                  //     child: Text(
                  //       tour.game,
                  //       maxLines: 1,
                  //       style: AppStyles.gameName(size: 20),
                  //     )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 20,
                          child: Center(
                            child: Text(
                              tour.tname.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.button15(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FrostedGlassBox(
                        //     theHeight: 40,
                        //     theWidth: 160,
                        //     theChild: Center(
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 15.0),
                        //         child: Text(
                        //           tour.game,
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: AppStyles.info14(),
                        //         ),
                        //       ),
                        //     )),

                        SizedBox(
                          height: 10,
                        ),
                        FrostedGlassBox(
                          theWidth: 150,
                          theHeight: 50,
                          theChild: Center(
                            child: Image.asset(
                              findLogoPath(tour.game),
                              color: Colors.deepOrangeAccent,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            FrostedGlassBox(
                              theWidth: 50,
                              theHeight: 20,
                              theChild: Text(
                                tour.ispvp ? 'PvP' : 'TvT',
                                style: AppStyles.button15(size: 11),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 20,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(21),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 22, 122, 63))),
                              child: FrostedGlassBox(
                                theHeight: 20,
                                theWidth: 60,
                                theChild: Center(
                                  child: Text(
                                    '${tour.maxPartcipants - tour.cPart!} More',
                                    style: AppStyles.info14(
                                        size: 11, color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FrostedGlassBox(
                                theWidth: 50,
                                theHeight: 20,
                                theChild: Text(
                                  tour.isPaid
                                      ? tour.entryfee.toString()
                                      : 'Free',
                                  style: AppStyles.button15(size: 11),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    return SizedBox();
  }
}
