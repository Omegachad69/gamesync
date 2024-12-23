import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/data/games_list.dart';
import 'package:gameync/core/data/globals.dart' as globals;

import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/features/tournaments/presentation/pages/tourcrate/tourcreate_page_1.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class SelectGamePage extends StatefulWidget {
  const SelectGamePage({super.key});

  @override
  State<SelectGamePage> createState() => _SelectGamePageState();
}

class _SelectGamePageState extends State<SelectGamePage> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: Text(
            'Select Game',
            style: AppStyles.appBar30(),
          ),
        ),
        body: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: mobileEsportGames.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _selectedIndex == index
                              ? Colors.redAccent
                              : Colors.transparent,
                          width: 4),
                      borderRadius: BorderRadius.circular(32)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(27),
                    // padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image.asset(
                            mobileEsportGames[index]['imageUrl'],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                            child: FrostedGlassBox(
                                theWidth: double.infinity,
                                theHeight: 62,
                                theRadius: 0,
                                theRadius2: 0,
                                theChild: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(11.0),
                                    child: Text(
                                      mobileEsportGames[index]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 14),
                                    ),
                                  ),
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _selectedIndex != -1
            ? GestureDetector(
                onTap: () {
                  globals.game = mobileEsportGames[_selectedIndex]['name'];
                  pushScreenWithoutNavBar(context, TourCreatePage());
                },
                // child: Container(
                //   decoration: BoxDecoration(
                //     color: Colors.yellow,
                //     borderRadius: BorderRadius.circular(27),
                //     gradient: const LinearGradient(
                //       colors: [
                //         AppPallete.gradient1,
                //         AppPallete.gradient2,
                //       ],
                //       begin: Alignment.bottomLeft,
                //       end: Alignment.topRight,
                //     ),
                //   ),
                //   width: 350,
                //   height: 55,
                //   child:
                //       Center(child: Text('Next', style: AppStyles.button15())),
                // ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(27),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(127, 55, 38, 235),
                        Color.fromARGB(119, 43, 118, 216),
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                  ),
                  child: FrostedGlassBox(
                    theWidth: 350,
                    theHeight: 55,
                    theChild: Center(
                        child: Text('Next', style: AppStyles.button15())),
                  ),
                ),
              )
            // : Container(
            //     decoration: BoxDecoration(
            //         color: Colors.grey, borderRadius: BorderRadius.circular(27)),
            //     width: 350,
            //     height: 55,
            //     child: Center(
            //         child: Text(
            //       'Next',
            //       style: AppStyles.button15(),
            //     )),
            //   ),
            : SizedBox());
  }
}
