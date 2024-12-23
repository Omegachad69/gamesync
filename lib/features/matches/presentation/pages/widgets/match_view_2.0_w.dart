import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/features/matches/presentation/pages/widgets/set_result_dialog.dart';

class MatchView2 extends StatelessWidget {
  const MatchView2({
    super.key,
    required this.uname,
    required this.uname2,
    required this.winnername,
    required this.p1,
    required this.p2,
    required this.mid,
  });
  final String uname;
  final String uname2;
  final String winnername;
  final String p1;
  final String p2;
  final String mid;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 367,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 110,
                      child: uname2 == winnername
                          ? ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.grey, BlendMode.saturation),
                              child: Image.asset(
                                'assets/images/games/leagueoflegends.jpg',
                              ),
                            )
                          : Image.asset(
                              'assets/images/games/leagueoflegends.jpg',
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      uname,
                      style: AppStyles.button15(),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 30),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'V/S',
                          style: AppStyles.time30(),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        winnername == 'null'
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => SetResultDialog(
                                            uname: uname,
                                            uname2: uname2,
                                            imageUrl:
                                                'assets/images/games/leagueoflegends.jpg',
                                            imageUrl2:
                                                'assets/images/games/leagueoflegends.jpg',
                                            p1: p1,
                                            p2: p2,
                                            mid: mid,
                                          ));
                                },
                                child: FrostedGlassBox(
                                    bgcolor: Colors.white.withOpacity(0.1),
                                    theWidth: 100,
                                    theHeight: 30,
                                    theChild: Text(
                                      'Set Result',
                                      style: AppStyles.button15(size: 12),
                                    )),
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: uname == winnername
                          ? ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                  Colors.grey, BlendMode.saturation),
                              child: Image.asset(
                                'assets/images/games/leagueoflegends.jpg',
                              ),
                            )
                          : Image.asset(
                              'assets/images/games/leagueoflegends.jpg',
                            ),
                    ),
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
