import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/format_date.dart';
import 'package:gameync/core/common/entities/tour.dart';

class Details extends StatelessWidget {
  final Tour tour;

  const Details({
    super.key,
    required this.tour,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: AppStyles.heading40Bold(size: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const FrostedGlassBox(
            theWidth: double.infinity, theHeight: 2, theChild: SizedBox()),
        TourInfoDetailsText(
          icon: CupertinoIcons.game_controller,
          hText: 'Game',
          text2: tour.game,
        ),
        TourInfoDetailsText(
          icon: CupertinoIcons.clock_fill,
          hText: 'Schedule',
          text2: 'Starts : ${formatDateBydMMMYYYY(tour.dateTime)}',
        ),
        TourInfoDetailsText(
          icon: CupertinoIcons.square_split_1x2,
          hText: 'Mode',
          text2: tour.ispvp ? 'Player v Player' : 'Team v Team',
        ),
        TourInfoDetailsText(
          icon: CupertinoIcons.bolt_circle,
          hText: 'Type',
          text2: tour.isduel ? 'Duel' : 'Battle Royale',
        ),
        const TourInfoDetailsText(
          icon: CupertinoIcons.person_2_fill,
          hText: 'Capacity',
          text2: 'Teams: 16 \n Players per Team : 3\n Total No.of player : 30',
        ),
        const SizedBox(
          height: 20,
        ),
        const FrostedGlassBox(
            theWidth: double.infinity, theHeight: 2, theChild: SizedBox()),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              width: 50,
              height: 80,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              child: const Icon(Icons.person),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORGANISER',
                    style:
                        AppStyles.info14(size: 11, color: AppPallete.gradient2),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${tour.aname}',
                    style: AppStyles.button15(),
                  )
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            TourGradientButton(
                width: 40,
                height: 100,
                buttonText: 'Chat',
                onTap: () {},
                isCreateTour: false)
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Rules',
          style: AppStyles.heading40Bold(size: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const FrostedGlassBox(
            theWidth: double.infinity, theHeight: 2, theChild: SizedBox()),
        const SizedBox(
          height: 10,
        ),
        Text(
          tour.rules,
          style: AppStyles.listItem(),
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'About',
          style: AppStyles.heading40Bold(size: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const FrostedGlassBox(
            theWidth: double.infinity, theHeight: 2, theChild: SizedBox()),
        const SizedBox(
          height: 10,
        ),
        Text(
          tour.descp,
          style: AppStyles.listItem(),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class TourInfoDetailsText extends StatelessWidget {
  final String hText;
  final String text2;
  final IconData icon;
  const TourInfoDetailsText({
    Key? key,
    required this.hText,
    required this.text2,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0).copyWith(top: 16),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 47,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppPallete.gradient2.withOpacity(0.7),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 25,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hText,
                style: AppStyles.info14(color: AppPallete.gradient2, size: 12),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                text2,
                style: AppStyles.listItem(fweight: FontWeight.w600, size: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
