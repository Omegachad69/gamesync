import 'package:gameync/core/error/exception.dart';
import 'package:gameync/features/auth/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWIthEmailPassword({
    required String uname,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
  Future<dynamic> logOutUser();
}

class AuthRemoteDataSourceImpli implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpli(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWIthEmailPassword(
      {required String uname,
      required String name,
      required String phoneNumber,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'phone': phoneNumber,
          'name': name,
          'uname': uname,
        },
      );

      if (response.user == null) {
        throw ServerException('User is Null');
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);

      if (response.user == null) {
        throw ServerException('User is null');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('uid', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first)
            .copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future logOutUser() async {
    try {
      await supabaseClient.auth.signOut();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }
}
