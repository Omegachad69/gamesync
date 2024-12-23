import 'package:flutter/material.dart';
import 'package:gameync/core/common/entities/matches.dart';
import 'package:gameync/features/matches/presentation/pages/match_view.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/home/widgets/home_user_tour_card.dart';

class HomeMatchView extends StatelessWidget {
  final List<Matches> matchesu;
  const HomeMatchView({
    super.key,
    required this.matchesu,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        scrollDirection: Axis.horizontal,
        itemCount: matchesu.length,
        itemBuilder: (context, index) {
          return MatchView(
              uname: '${matchesu[index].p1name}',
              uname2: '${matchesu[index].p2name}');
        });
  }
}

class HomePageView extends StatelessWidget {
  final List<Tour> tours;
  const HomePageView({
    super.key,
    required this.tours,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        itemCount: tours.length,
        itemBuilder: (context, index) {
          return HomeUserTourCard(
            tour: tours[index],
          );
        });
  }
}
