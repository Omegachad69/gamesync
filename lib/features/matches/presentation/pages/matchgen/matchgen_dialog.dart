import 'package:flutter/material.dart';
import 'package:gameync/core/common/widgets/search_field.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/features/matches/presentation/pages/matchgen/match_generated.dart';
import 'package:gameync/core/common/entities/tour.dart';

class MatchGenDialog extends StatefulWidget {
  final Tour tour;
  MatchGenDialog({super.key, required this.tour});

  @override
  State<MatchGenDialog> createState() => _MatchGenDialogState();
}

class _MatchGenDialogState extends State<MatchGenDialog> {
  final roundController = TextEditingController();

  bool againstEach = false;

  @override
  void dispose() {
    roundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      child: SizedBox(
        height: 700,
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Match Type",
                style: AppStyles.button15(),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Duel',
                style: AppStyles.info14(color: Colors.white.withOpacity(0.5)),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter The Number of Rounds",
                style: AppStyles.button15(),
              ),
              SizedBox(
                height: 15,
              ),
              TtextPage(
                  controller: roundController,
                  hintText: 'Default is Dynamic',
                  height: 80,
                  maxLine: 1,
                  isNumber: true),
              SizedBox(
                height: 30,
              ),
              Text(
                'Matching Criteria',
                style: AppStyles.button15(),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(17)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Random',
                    style:
                        AppStyles.info14(color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Should each partcipant Match Eachother ?',
                style: AppStyles.button15(),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Switch(
                    activeTrackColor: AppPallete.gradient1,
                    activeColor: Colors.white,
                    value: againstEach,
                    onChanged: (value) {
                      setState(() {
                        againstEach = value;
                      });
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    againstEach ? 'Yes' : 'No',
                    style: AppStyles.info14(),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Direct Promotion Criteria',
                style: AppStyles.button15(),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(17)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Random',
                    style:
                        AppStyles.info14(color: Colors.white.withOpacity(0.5)),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TourGradientButton(
                  buttonText: 'Generate',
                  onTap: () {
                    if (roundController.text.isEmpty) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchGenerated(
                                  tour: widget.tour,
                                  againstEach: againstEach,
                                  dpc: 'Random',
                                  mc: 'Randome',
                                  rounds: 0)));
                    }
                  },
                  isCreateTour: false)
            ],
          ),
        ),
      ),
    );
  }
}
