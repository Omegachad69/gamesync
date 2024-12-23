import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/common/widgets/loader.dart';

import 'package:gameync/core/common/widgets/presistant_navbar.dart';
import 'package:gameync/core/themes/theme.dart';
import 'package:gameync/features/auth/data/model/user_model.dart';

import 'package:gameync/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:gameync/features/auth/presentation/pages/login_page.dart';
import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';

import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';
import 'package:gameync/features/tournaments/presentation/bloc/temp/temp_bloc.dart';

import 'package:gameync/features/tournaments/presentation/bloc/tour/tour_bloc.dart';
import 'package:gameync/init_imports.dart';
import 'package:restart_app/restart_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    BlocProvider(create: (_) => serviceLocator<CurrentuserCubit>()),
    BlocProvider(create: (_) => serviceLocator<TourBloc>()),
    BlocProvider(create: (_) => serviceLocator<ParticipantBloc>()),
    BlocProvider(create: (_) => serviceLocator<MatchBloc>()),
    BlocProvider(create: (_) => serviceLocator<TempBloc>()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      // home: BlocSelector<CurrentuserCubit, CurrentuserState, User?>(
      //   selector: (state) {
      //     print(state);
      //     if (state is CurrentUserLoggedIn) {
      //       return state.user;
      //     }
      //     return null;
      //   },
      //   builder: (context, user) {
      //     if (user != null) {
      //       return PresistentNavBar();
      //     } else {
      //       return LoginPage();
      //     }
      //   },
      // ),
      home: BlocBuilder<CurrentuserCubit, CurrentuserState>(
        builder: (context, state) {
          if (state is CurrentUserLoggedIn) {
            if (state.user.uid.isEmpty) {
              final res = Supabase.instance.client.auth.currentUser;

              final data =
                  UserModel.fromJson(res!.toJson()).copyWith(uid: res.id);
              context.read<CurrentuserCubit>().updateUser(data);
            }
            return PresistentNavBar();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
