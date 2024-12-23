import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/text_style.dart';

class MatchView extends StatelessWidget {
  const MatchView({
    super.key,
    required this.uname,
    required this.uname2,
  });
  final String uname;
  final String uname2;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 367,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 185,
                        child: Image.asset(
                            'assets/images/games/leagueoflegends.jpg')),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      uname,
                      style: AppStyles.button15(),
                    )
                  ],
                ),
                Center(
                  child: Text(
                    'V/S',
                    style: AppStyles.time30(),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 80,
                        width: 150,
                        child: Image.asset(
                            'assets/images/games/leagueoflegends.jpg')),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      uname2,
                      style: AppStyles.button15(),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            FrostedGlassBox(
              theWidth: 100,
              theHeight: 3,
              bgcolor: Colors.white.withOpacity(0.3),
              theChild: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
