import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/themes/text_style.dart';
import 'package:gameync/features/auth/presentation/bloc/auth/auth_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        const SizedBox(
          height: 80,
          width: 80,
          child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/games/leagueoflegends.jpg')),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
              .user
              .uname,
          style: AppStyles.button15(),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          (context.read<CurrentuserCubit>().state as CurrentUserLoggedIn)
              .user
              .name,
          style: AppStyles.gameName(color: Colors.white.withOpacity(0.7)),
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                context.read<AuthBloc>().add(AuthUserLoggedOut());
                context.read<CurrentuserCubit>().emit(CurrenUserEmpty());
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout')),
        ),
      ],
    );
  }
}
