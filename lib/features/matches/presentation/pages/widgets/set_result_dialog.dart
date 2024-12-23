import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/app_pallete.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';

class SetResultDialog extends StatefulWidget {
  final String uname;
  final String uname2;
  final String imageUrl;
  final String imageUrl2;
  final String p1;
  final String p2;
  final String mid;
  const SetResultDialog(
      {super.key,
      required this.uname,
      required this.imageUrl,
      required this.uname2,
      required this.imageUrl2,
      required this.p1,
      required this.p2,
      required this.mid});

  @override
  State<SetResultDialog> createState() => _SetResultDialogState();
}

bool tapped1 = false;
bool tapped2 = false;

class _SetResultDialogState extends State<SetResultDialog> {
  void uploadWinner() {
    print(widget.mid);
    context.read<MatchBloc>().add(MatchWinnerUpload(
        mid: widget.mid,
        winner: tapped1
            ? widget.p1
            : tapped2
                ? widget.p2
                : 'Draw'));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      elevation: 0,
      child: SizedBox(
        height: 400,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                'Set Result',
                style: AppStyles.button15(size: 20),
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Tap to select\n Double tap to deselect',
              //   style: AppStyles.gameName(),
              // ),
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    tapped1 = false;
                  });
                },
                onTap: () {
                  setState(() {
                    tapped1 = true;
                  });
                },
                child: SetResultView(
                  uname: widget.uname,
                  imagePath: widget.imageUrl,
                  tapped: tapped1,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    tapped2 = false;
                  });
                },
                onTap: () {
                  setState(() {
                    tapped2 = true;
                  });
                },
                child: SetResultView(
                  uname: widget.uname2,
                  imagePath: widget.imageUrl2,
                  tapped: tapped2,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TourGradientButton(
                  buttonText: 'Confirm Result',
                  onTap: () {
                    uploadWinner();
                    Navigator.pop(context);
                  },
                  isCreateTour: false)
            ],
          ),
        ),
      ),
    );
  }
}

class SetResultView extends StatefulWidget {
  const SetResultView({
    super.key,
    required this.imagePath,
    required this.uname,
    required this.tapped,
  });

  final String imagePath;
  final String uname;
  final bool tapped;
  @override
  State<SetResultView> createState() => _SetResultViewState();
}

class _SetResultViewState extends State<SetResultView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: widget.tapped
          ? BoxDecoration(
              color: const Color.fromARGB(255, 98, 145, 212).withOpacity(0.4),
              border: Border.all(
                color: AppPallete.gradient3,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(13))
          : BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Image.asset(widget.imagePath),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.uname,
                  style: AppStyles.gameName(size: 18),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
