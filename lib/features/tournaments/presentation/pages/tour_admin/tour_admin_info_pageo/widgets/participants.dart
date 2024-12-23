import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/widgets/frosted_glass_box.dart';
import 'package:gameync/core/common/widgets/loader.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/core/utils/show_snackbar.dart';

import 'package:gameync/core/common/entities/tour.dart';
import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';

class Participants extends StatefulWidget {
  const Participants({
    super.key,
    required this.searchBarController,
    required this.tour,
  });

  final TextEditingController searchBarController;
  final Tour tour;

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  @override
  void initState() {
    context.read<ParticipantBloc>().add(ParticipantFetch(tid: widget.tour.tid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myid = (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
        .user
        .uid;
    return BlocConsumer<ParticipantBloc, ParticipantState>(
      listener: (context, state) {
        if (state is ParticipantFailure) {
          return showSnackBar(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is ParticipantLoading) {
          return const Loader();
        }
        if (state is ParicipantsDisplaySuccess) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    'Participants',
                    style: AppStyles.heading40Bold(size: 20),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                      '${state.participants.length} / ${widget.tour.maxPartcipants}',
                      style: AppStyles.heading40Bold(size: 20))
                ],
              ),
              const SizedBox(height: 20),
              SearchBar(
                  controller: widget.searchBarController,
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(CupertinoIcons.search),
                  ),
                  hintText: 'Search Participants',
                  hintStyle: MaterialStatePropertyAll(AppStyles.listItem())),
              const SizedBox(height: 20),
              Container(
                height: 700,
                child: ListView.builder(
                  itemCount: state.participants.length,
                  itemBuilder: (context, index) {
                    final participant = state.participants[index];
                    bool isme = state.participants[index].uid == myid;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: FrostedGlassBox(
                          theWidth: double.infinity,
                          theHeight: 70,
                          theChild: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Center(child: Icon(Icons.person)),
                                ),
                                const SizedBox(width: 30),
                                Text(
                                  '${participant.uname}     ',
                                  style: AppStyles.info14(),
                                ),
                                isme ? Text('(You)') : SizedBox(),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
