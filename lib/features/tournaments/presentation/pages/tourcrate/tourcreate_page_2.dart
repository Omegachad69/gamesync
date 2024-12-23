import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/search_field.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/features/tournaments/presentation/pages/tourcrate/tourcreate_page_3.dart';
import 'package:gameync/features/tournaments/presentation/widgets/expansion_tile.dart';

import 'package:gameync/features/tournaments/presentation/widgets/time_line.dart';

class TourCreatePage2 extends StatefulWidget {
  final String tname;
  final String game;
  final String rules;
  final String desc;
  final File image;
  final DateTime dateTime;

  const TourCreatePage2({
    Key? key,
    required this.tname,
    required this.game,
    required this.rules,
    required this.desc,
    required this.image,
    required this.dateTime,
  }) : super(key: key);

  @override
  State<TourCreatePage2> createState() => _TourCreatePage2State();
}

class _TourCreatePage2State extends State<TourCreatePage2> {
  String _modtitle = 'Tap to select the event mode';
  String _eType = 'Tap to select the event type';
  bool duel = false;
  bool playerv = true;
  final expansionTileController = ExpansionTileController();
  final teamNumberController = TextEditingController();
  final maxParController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    teamNumberController.dispose();
    maxParController.dispose();
    super.dispose();
  }

  // void addData() {
  //   TourDataPage2(playerv, duel, teamNumberController.text.trim() as int,
  //       maxParController.text.trim() as int);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.black,
      ),
      body: Stack(
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
                    cPage: 2,
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
                            'Choose a Format',
                            style: AppStyles.heading40Bold(size: 30),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Text(
                            'Type ',
                            style: AppStyles.info14(
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomExpansionTile(
                            title: Text(
                              _eType,
                              style: AppStyles.listTitle(),
                            ),
                            children: <Widget>[
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    _eType = 'Team v Team';
                                    playerv = false;
                                  });
                                },
                                title: Text('Team v Team',
                                    style: AppStyles.listItem()),
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    _eType = 'Player v Player';
                                  });
                                  playerv = true;
                                },
                                title: Text('Player v Player',
                                    style: AppStyles.listItem()),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          !playerv
                              ? TtextPage(
                                  isNumber: true,
                                  controller: teamNumberController,
                                  hintText:
                                      'Specify the number of players per team',
                                  height: 100,
                                  maxLine: 1)
                              : const SizedBox(
                                  height: 0,
                                ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Mode ',
                            style: AppStyles.info14(
                              size: 17,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomExpansionTile(
                            title: Text(
                              _modtitle,
                              style: AppStyles.listTitle(),
                            ),
                            children: <Widget>[
                              const SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    _modtitle = 'Battle Royale';
                                    duel = false;
                                  });
                                },
                                title: Text('Battle Royale',
                                    style: AppStyles.listItem()),
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    _modtitle = 'Duel';
                                  });
                                  duel = true;
                                },
                                title:
                                    Text('Duel', style: AppStyles.listItem()),
                              ),
                            ],
                          ),
                          _modtitle == 'Battle Royale'
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.question_circle_fill,
                                        size: 13,
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        'Battle Royale is currently not Supported',
                                        style: AppStyles.button15(
                                            size: 13, color: Colors.redAccent),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(height: 20),
                          SizedBox(
                            height: 20,
                          ),
                          TtextPage(
                              controller: maxParController,
                              hintText:
                                  'Enter the Maximum Participants allowed',
                              height: 70,
                              maxLine: 1,
                              isNumber: true),
                          const SizedBox(height: 30),
                          duel
                              ? TourGradientButton(
                                  buttonText: 'Next',
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      if (playerv = true) {}
                                      pushScreenWithoutNavBar(
                                          context,
                                          TourCreatePage3(
                                              tname: widget.tname,
                                              game: widget.game,
                                              rules: widget.rules,
                                              desc: widget.desc,
                                              image: widget.image,
                                              dateTime: widget.dateTime,
                                              isduel: duel,
                                              ispvp: playerv,
                                              maxParticipants: int.parse(
                                                  maxParController.text.trim()),
                                              maxTeam: playerv
                                                  ? 0
                                                  : int.parse(
                                                      teamNumberController.text
                                                          .trim())));
                                    }
                                  },
                                  isCreateTour: false)
                              : const SizedBox(height: 30),
                          const SizedBox(height: 30),
                        ]),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
