import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';
import 'package:gameync/core/secrets/secrets.dart';
import 'package:gameync/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:gameync/features/auth/data/repository/auth_repository_impli.dart';
import 'package:gameync/features/auth/domain/usecases/current_user_usecase.dart';
import 'package:gameync/features/auth/domain/usecases/login_usecase.dart';
import 'package:gameync/features/auth/domain/usecases/user_signup_usecase.dart';
import 'package:gameync/features/auth/domain/repository/auth_repository.dart';
import 'package:gameync/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:gameync/features/matches/data/data_sources/match_remote_data_source.dart';
import 'package:gameync/features/matches/data/repos/match_repo_impli.dart';
import 'package:gameync/features/matches/domain/repos/match_repo.dart';
import 'package:gameync/features/matches/domain/usecases/get_all_matches.dart';
import 'package:gameync/features/matches/domain/usecases/get_user_matches.dart';
import 'package:gameync/features/matches/domain/usecases/upload_matches.dart';
import 'package:gameync/features/matches/domain/usecases/upload_winner.dart';
import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';

import 'package:gameync/features/tournaments/data/data_sources/tour_remote_data_source.dart';
import 'package:gameync/features/tournaments/data/repos/tour_repo.dart';
import 'package:gameync/features/tournaments/domain/repos/tour_repo.dart';

import 'package:gameync/features/tournaments/domain/usecases/get_all_tours.dart';

import 'package:gameync/features/tournaments/domain/usecases/get_user_tours.dart';
import 'package:gameync/features/tournaments/domain/usecases/participate_on_tour.dart';

import 'package:gameync/features/tournaments/domain/usecases/upload_tour.dart';

import 'package:gameync/features/tournaments/presentation/bloc/participant/participant_bloc.dart';
import 'package:gameync/features/tournaments/presentation/bloc/temp/temp_bloc.dart';

import 'package:gameync/features/tournaments/presentation/bloc/tour/tour_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies.dart';
