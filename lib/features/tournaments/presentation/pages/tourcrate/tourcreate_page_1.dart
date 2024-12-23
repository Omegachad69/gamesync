import 'dart:io';
import 'dart:ui';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/search_field.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/data/globals.dart' as globals;
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/pick_image.dart';

import 'package:gameync/features/tournaments/presentation/pages/tourcrate/tourcreate_page_2.dart';

import 'package:gameync/features/tournaments/presentation/widgets/time_line.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TourCreatePage extends StatefulWidget {
  const TourCreatePage({
    super.key,
  });

  @override
  State<TourCreatePage> createState() => _TourCreatePageState();
}

class _TourCreatePageState extends State<TourCreatePage> {
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final scheduleController = TextEditingController();
  final rulesController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  TimeOfDay _timeOfDay = const TimeOfDay(hour: 12, minute: 00);
  bool noTime = true;
  // ignore: unused_field
  DateTime _dateTime = DateTime(2000);
  File? image;

  void selecImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  DateTime combinedDateTime() {
    return DateTime(
      _dateTime.year,
      _dateTime.month,
      _dateTime.day,
      _timeOfDay.hour,
      _timeOfDay.minute,
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descController.dispose();
    scheduleController.dispose();
    rulesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        backgroundColor: Colors.black,
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
                    cPage: 1,
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 22,
                          ),
                          Text(
                            'General Information',
                            style: AppStyles.heading40Bold(size: 20),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Text(
                            'GAME ',
                            style: AppStyles.info14(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            globals.game,
                            style: AppStyles.gameName(),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Name',
                            style: AppStyles.info14(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TtextPage(
                              isNumber: false,
                              maxLine: 1,
                              height: 100,
                              hintText: 'Specify a unique tournament name',
                              controller: nameController),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Descrption',
                            style: AppStyles.info14(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TtextPage(
                              isNumber: false,
                              maxLine: 10,
                              height: 120,
                              hintText:
                                  'Describe your tournament in detail to attract more participants',
                              controller: descController),
                          const SizedBox(
                            height: 25,
                          ),
                          // Text(
                          //   'Schedule',
                          //   style: AppStyles.info14(),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // TtextPage(
                          //     maxLine: 15,
                          //     height: 130,
                          //     hintText:
                          //         'Optional if your tournament has multiple rounds or matches, add an additional match and round schedule here. if your tournament is a Duel or single match Battle Royale , this step is not needed. You will specify date and time below',
                          //     controller: descController),
                          // const SizedBox(
                          //   height: 25,
                          // ),
                          Text(
                            'Rules',
                            style: AppStyles.info14(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TtextPage(
                              isNumber: false,
                              maxLine: 15,
                              height: 110,
                              hintText:
                                  'Set clear tournaments rules to ensure transparency for all participants',
                              controller: rulesController),
                          const SizedBox(
                            height: 22,
                          ),
                          Text(
                            'Schedule',
                            style: AppStyles.heading40Bold(size: 20),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FrostedGlassBox(
                            theHeight: 445,
                            theWidth: 400,
                            theChild: DatePicker(
                              leadingDateTextStyle: AppStyles.button15(
                                  size: 20, fweight: FontWeight.bold),
                              slidersColor: AppPallete.gradient2,
                              splashColor: AppPallete.gradient2,
                              highlightColor: AppPallete.gradient2,
                              selectedCellTextStyle: AppStyles.button15(),
                              selectedCellDecoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppPallete.gradient2,
                              ),
                              currentDateTextStyle: AppStyles.button15(
                                  color:
                                      const Color.fromARGB(255, 118, 147, 220)),
                              currentDateDecoration: const BoxDecoration(
                                  color: Colors.transparent),
                              enabledCellsTextStyle:
                                  AppStyles.button15(fweight: FontWeight.w400),
                              disabledCellsTextStyle: AppStyles.button15(
                                  color: Colors.white.withOpacity(0.3)),
                              maxDate: DateTime(2030),
                              minDate: DateTime.now(),
                              onDateSelected: (value) {
                                _dateTime = value;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Text(
                            'Select time',
                            style: AppStyles.info14(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                setState(() {
                                  _timeOfDay = value!;
                                  noTime = false;
                                });
                                print(value);
                              });
                            },
                            child: FrostedGlassBox(
                                theWidth: double.infinity,
                                theHeight: 100,
                                theChild: Text(
                                  noTime
                                      ? 'Press to select time'
                                      : _timeOfDay.format(context).toString(),
                                  style: noTime
                                      ? AppStyles.button15()
                                      : AppStyles.time30(),
                                )),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Time displayed  in IST',
                            style: AppStyles.gameName(),
                          ),

                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Optional',
                            style: AppStyles.info14(size: 25),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          image != null
                              ? GestureDetector(
                                  onTap: selecImage,
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 180,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    selecImage();
                                  },
                                  child: DottedBorder(
                                    color: AppPallete.borderColor,
                                    dashPattern: const [10, 4],
                                    radius: const Radius.circular(10),
                                    borderType: BorderType.RRect,
                                    strokeCap: StrokeCap.round,
                                    child: SizedBox(
                                      height: 180,
                                      width: 364,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.folder_open,
                                            size: 40,
                                          ),
                                          const SizedBox(height: 15),
                                          Text('Select your image',
                                              style: AppStyles.info14()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(height: 30),
                          TourGradientButton(
                              buttonText: 'Next',
                              onTap: () {
                                if (formkey.currentState!.validate() &&
                                    image != null &&
                                    _dateTime != DateTime.now()) {
                                  print('nooo');
                                  pushScreenWithoutNavBar(
                                      context,
                                      TourCreatePage2(
                                        game: globals.game,
                                        tname: nameController.text.trim(),
                                        dateTime: DateTime.now(),
                                        image: image!,
                                        desc: descController.text.trim(),
                                        rules: rulesController.text.trim(),
                                      ));
                                }
                              },
                              isCreateTour: false),
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
