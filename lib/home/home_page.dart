part of 'home_imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<TourBloc>().add(TourFetchAllTours());
    startup();
  }

  void startup() {
    context.read<TempBloc>().add(TempUserTourFetch(
        pid: (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
            .user
            .uid));
    context.read<MatchBloc>().add(MatchUserMatchFetch(
        pid: (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
            .user
            .uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          Text(
            (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
                .user
                .uname,
            style: AppStyles.appBar30(size: 22),
          ),
          const SizedBox(
            width: 80,
          ),
          const Icon(CupertinoIcons.bell),
          const SizedBox(
            width: 30,
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  context.read<TourBloc>().add(TourFetchAllTours());
                  context.read<TempBloc>().add(TempUserTourFetch(
                      pid: (context.read<CurrentuserCubit>().state
                              as CurrentUserLoggedIn)
                          .user
                          .uid));
                  context.read<MatchBloc>().add(
                        MatchUserMatchFetch(
                            pid: (context.read<CurrentuserCubit>().state
                                    as CurrentUserLoggedIn)
                                .user
                                .uid),
                      );
                });
              },
              child: const Icon(Icons.refresh)),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      drawer: const SafeArea(
        child: Drawer(
          width: 200,
          backgroundColor: Colors.black,
          child: HomeDrawer(),
        ),
      ),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image.asset(
            //   'assets/images/background/photo_2024-04-12_17-18-59.jpg',
            //   fit: BoxFit.cover,
            // ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.9, sigmaY: 2.9),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Created Tournaments

                    Text(
                      'Created Tournaments',
                      style: AppStyles.heading40Bold(size: 22),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 240,
                      width: 700,
                      child: BlocConsumer<TourBloc, TourState>(
                        listener: (context, state) {
                          if (state is TourFailure) {
                            return showSnackBar(context, state.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is TourLoading) {
                            return const Loader();
                          }
                          if (state is TourDisplaySuccess) {
                            final currentUserAid = (context
                                    .read<CurrentuserCubit>()
                                    .state as CurrentUserLoggedIn)
                                .user
                                .uid;
                            final filteredTours = state.tours
                                .where((tour) => tour.adminId == currentUserAid)
                                .toList();
                            return PageView.builder(
                                physics: const BouncingScrollPhysics(
                                    decelerationRate:
                                        ScrollDecelerationRate.normal),
                                itemCount: filteredTours.length,
                                itemBuilder: (context, index) {
                                  return AdminCard(
                                    tour: filteredTours[index],
                                  );
                                });
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //
                    Text(
                      'Upcoming Matches',
                      style: AppStyles.heading40Bold(size: 22),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    BlocConsumer<MatchBloc, MatchState>(
                      listener: (context, state) {
                        if (state is MatchFailure) {
                          return showSnackBar(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is MatchLoading) {
                          return const Loader();
                        }

                        if (state is MatchUserDisplaySuccess) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 160,
                              child: HomeMatchView(
                                matchesu: state.matchesu,
                              ),
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              'Please Refresh Home page',
                              style: AppStyles.button15(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Joined Tournaments',
                      style: AppStyles.heading40Bold(size: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 160,
                      width: 700,
                      child: BlocConsumer<TempBloc, TempState>(
                        listener: (context, state) {
                          if (state is TempFailure) {
                            return showSnackBar(context, state.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is TempLoading) {
                            return const Loader();
                          }
                          if (state is TempSuccess) {
                            return HomePageView(
                              tours: state.usertours,
                            );
                          }
                          return const Text('hi');
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
    );
  }
}
