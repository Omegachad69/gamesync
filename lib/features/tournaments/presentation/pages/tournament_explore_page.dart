import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/common/widgets/tour_gradient_button.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/bloc/tour/tour_bloc.dart';

import 'package:gameync/features/tournaments/presentation/pages/select_game_page.dart';
import 'package:gameync/features/tournaments/presentation/widgets/search_fieldd.dart';

import 'package:gameync/features/tournaments/presentation/widgets/tour_view.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class TourExplorePage extends StatefulWidget {
  const TourExplorePage({super.key});

  @override
  State<TourExplorePage> createState() => _TourExplorePageState();
}

List<Tour> _foundTours = [];

class _TourExplorePageState extends State<TourExplorePage> {
  @override
  void initState() {
    super.initState();
    context.read<TourBloc>().add(TourFetchAllTours());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'GameSync ',
                style: AppStyles.button15(size: 22),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      context.read<TourBloc>().add(TourFetchAllTours());
                    });
                  },
                  child: Icon(Icons.refresh)),
            ),
          ],
          toolbarHeight: 30,
        ),
        // body: Stack(fit: StackFit.expand, children: [
        //   Image.asset(
        //     'assets/images/background/photo_2024-04-12_17-19-38.jpg',
        //     fit: BoxFit.cover,
        //   ),
        //   BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 2.9),
        //     child: Container(
        //       color: Colors.black.withOpacity(0.6),
        //     ),
        //   ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocConsumer<TourBloc, TourState>(
            listener: (context, state) {
              if (state is TourFailure) {
                showSnackBar(context, state.error);
              }
            },
            builder: (context, state) {
              if (state is TourLoading) {
                return const Loader();
              }
              if (state is TourDisplaySuccess) {
                if (_foundTours.isEmpty) {
                  _foundTours = state.tours;
                }
                void runFilter(String enteredText) {
                  List<Tour> results = [];
                  if (enteredText.isEmpty) {
                    results = state.tours;
                  } else {
                    results = state.tours
                        .where((tours) => tours.tname
                            .toLowerCase()
                            .contains(enteredText.toLowerCase()))
                        .toList();
                  }
                  setState(() {
                    _foundTours = results;
                  });
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0)
                          .copyWith(top: 00, bottom: 10),
                      child: SearchField(
                        onChanges: (value) => runFilter(value),
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    TourGradientButton(
                        isCreateTour: true,
                        buttonText: 'Create New Tournament',
                        onTap: () {
                          pushScreenWithoutNavBar(context, SelectGamePage());
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _foundTours.length,
                        itemBuilder: (context, index) {
                          final tours = _foundTours[index];
                          return TourCard(
                            tour: tours,
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
        //]
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
    // );
  }
}
