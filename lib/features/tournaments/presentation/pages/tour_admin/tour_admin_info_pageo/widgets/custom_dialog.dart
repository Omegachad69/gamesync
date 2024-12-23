import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';

class CustomDialog extends StatelessWidget {
  final String tname;
  final Function onTap;
  const CustomDialog({super.key, required this.tname, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      // backgroundColor: AppPallete.gradient2.withOpacity(0.6).withAlpha(50),
      backgroundColor: Colors.black.withOpacity(0.5),
      child: FrostedGlassBox(
          theWidth: 400,
          theHeight: 290,
          theChild: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 150,
                  child: Image.asset(
                    'assets/images/icons/warning.png',
                  ),
                ),
                Text(
                  'Are you Sure ?',
                  style: AppStyles.button15(size: 22),
                ),
                // Text(
                //   ' you want to leave $tname ',
                //   style: AppStyles.button15(),
                // ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppPallete.errorColor),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onTap();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(AppPallete.gradient1),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        child: Text('Leave')),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
