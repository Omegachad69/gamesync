import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gameync/core/common/cubits/current_user/currentuser_cubit.dart';

import 'package:gameync/core/common/widgets/loader.dart';

import 'package:gameync/core/themes/text_style.dart';

import 'package:gameync/core/utils/show_snackbar.dart';
import 'package:gameync/features/auth/presentation/bloc/auth/auth_bloc.dart';

import 'package:gameync/features/matches/presentation/bloc/match/match_bloc.dart';

import 'package:gameync/features/tournaments/presentation/bloc/temp/temp_bloc.dart';

import 'package:gameync/features/tournaments/presentation/bloc/tour/tour_bloc.dart';

import 'package:gameync/home/widgets/admin_card.dart';
import 'package:gameync/home/widgets/home_drawer.dart';
import 'package:gameync/home/widgets/home_userTPV_matchPV.dart';

part 'home_page.dart';
