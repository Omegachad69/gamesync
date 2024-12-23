part of 'init_imports.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initTour();
  _initMatch();
  final supabase = await Supabase.initialize(
      anonKey: AppSecrets.anonKey, url: AppSecrets.projectUrl);

  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => CurrentuserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpli(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpli(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogOut(serviceLocator()));

  serviceLocator.registerLazySingleton(() => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        currentuserCubit: serviceLocator(),
        userLogOut: serviceLocator(),
      ));
}

void _initTour() {
  serviceLocator.registerFactory<TourRemoteDataSource>(
      () => TourRemoteDataSourceImpli(serviceLocator()));

  serviceLocator
      .registerFactory<TourRepository>(() => TourRepoImpli(serviceLocator()));

  serviceLocator.registerFactory(() => UploadTour(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllTours(serviceLocator()));
  serviceLocator.registerFactory(() => ParticipateOnTours(serviceLocator()));
  serviceLocator.registerFactory(() => ParticiPants(serviceLocator()));
  serviceLocator.registerFactory(() => IsUserJoined(serviceLocator()));
  serviceLocator.registerFactory(() => LeaveParticipant(serviceLocator()));
  serviceLocator.registerFactory(() => GetUserTours(serviceLocator()));

  serviceLocator.registerLazySingleton(() => TourBloc(
        uploadTour: serviceLocator(),
        getAllTours: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(
    () => ParticipantBloc(
      participateOnTours: serviceLocator(),
      particiPants: serviceLocator(),
      isUserJoined: serviceLocator(),
      leaveParticipant: serviceLocator(),
    ),
  );

  serviceLocator
      .registerLazySingleton(() => TempBloc(getUserTours: serviceLocator()));
}

void _initMatch() {
  serviceLocator.registerFactory<MatchRemoteDataSource>(
      () => MatchRemoteDataSourceImpli(serviceLocator()));

  serviceLocator.registerFactory<MatchRepository>(
      () => MatchRepositoryImpli(serviceLocator()));

  serviceLocator.registerFactory(() => UploadMatches(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllMatches(serviceLocator()));
  serviceLocator.registerFactory(() => UploadWinner(serviceLocator()));
  serviceLocator.registerFactory(() => GetUserMatches(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => MatchBloc(
      uploadMatches: serviceLocator(),
      getAllMatches: serviceLocator(),
      uploadWinner: serviceLocator(),
      getUserMatches: serviceLocator(),
    ),
  );
}
