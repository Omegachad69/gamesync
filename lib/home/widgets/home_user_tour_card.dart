import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/format_date.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/pages/p_tour_info_page/p_tour_info_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class HomeUserTourCard extends StatelessWidget {
  final Tour tour;
  const HomeUserTourCard({
    super.key,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          pushScreenWithoutNavBar(context, PTourInfoPage(tour: tour));
        },
        child: FrostedGlassBox(
          theHeight: 100,
          theWidth: double.infinity,
          theChild: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0).copyWith(left: 15),
                child: SizedBox(
                  height: 150,
                  width: 100,
                  child: Image.network(
                    tour.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.tname,
                      style: AppStyles.button15(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      formatDateBydMMMYYYY(tour.dateTime),
                      style: AppStyles.button15(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
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
                          width: 20,
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
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
