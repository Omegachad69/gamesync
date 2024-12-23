import 'dart:io';

import 'package:gameync/core/error/exception.dart';

import 'package:gameync/features/tournaments/data/models/partcipant_model.dart';

import 'package:gameync/features/tournaments/data/models/tour_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class TourRemoteDataSource {
  Future<TourModel> uploadTour(TourModel tour);

  Future<String> uploadTourImage(
      {required File image, required TourModel tour});

  Future<List<TourModel>> getAllTours();

  Future<List<ParticpantModel>> getAllParticipants({required String tid});
  Future<String> particpateOnTour(
      {required String uid, required String tid, required int cPart});
  Future<bool> isUserJoined({required String uid, required String tid});
  Future<String> leaveParticipant(
      {required String tid, required String uid, required int cPart});

  Future<List<TourModel>> getUserTours({required String pid});

  Future<dynamic> deleteTour({required tid});
}

class TourRemoteDataSourceImpli implements TourRemoteDataSource {
  final SupabaseClient supabaseClient;

  TourRemoteDataSourceImpli(this.supabaseClient);

  @override
  Future<TourModel> uploadTour(TourModel tour) async {
    try {
      final tourData = await supabaseClient
          .from('tournaments')
          .insert(tour.toJson())
          .select();

      return TourModel.fromMap(tourData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadTourImage(
      {required File image, required TourModel tour}) async {
    try {
      await supabaseClient.storage.from('tour_images').upload(tour.tid, image);

      return supabaseClient.storage.from('tour_images').getPublicUrl(tour.tid);
    } on StorageException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TourModel>> getAllTours() async {
    try {
      final tours =
          await supabaseClient.from('tournaments').select('*,profiles (name)');

      return tours
          .map(
            (tour) => TourModel.fromMap(tour).copyWith(
              aname: tour['profiles']['name'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> particpateOnTour(
      {required String uid, required String tid, required int cPart}) async {
    try {
      await supabaseClient
          .from('participants')
          .insert({'tid': tid, 'uid': uid}).select();
      await supabaseClient
          .from('tournaments')
          .update({'cPart': cPart}).eq('tid', tid);
      return 'Joined Successfully';
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ParticpantModel>> getAllParticipants(
      {required String tid}) async {
    try {
      final response = await supabaseClient
          .from('participants')
          .select('profiles(*)')
          .eq('tid', tid);

      return response
          .map((participant) =>
              ParticpantModel.fromJson(participant['profiles']))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<bool> isUserJoined({required String uid, required String tid}) async {
    try {
      final isJoined = await supabaseClient
          .from('participants')
          .select('uid')
          .eq('uid', uid)
          .eq('tid', tid);
      if (isJoined.isEmpty) {
        return false;
      }
      return true;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> leaveParticipant(
      {required String tid, required String uid, required int cPart}) async {
    try {
      await supabaseClient
          .from('participants')
          .delete()
          .eq('tid', tid)
          .eq('uid', uid);
      await supabaseClient
          .from('tournaments')
          .update({'cPart': cPart}).eq('tid', tid);
      return 'Removed SuccessFully';
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<List<TourModel>> getUserTours({required String pid}) async {
    try {
      final response = await supabaseClient
          .from('participants')
          .select('tid')
          .eq('uid', pid);

      final tids = (response).map((e) => e['tid']).toList();
      List<Map<String, dynamic>> userTourss = [];
      for (int i = 0; i < tids.length; i++) {
        final tourResponse = await supabaseClient
            .from('tournaments')
            .select('*')
            .eq('tid', tids[i]);
        if (tourResponse.isNotEmpty) {
          userTourss.addAll((tourResponse).cast<Map<String, dynamic>>());
        }
      }

      return userTourss.map((tour) => TourModel.fromMap(tour)).toList();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future deleteTour({required tid}) async {
    try {
      await supabaseClient.from('tournaments').delete().eq('tid', tid);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }
  //Match Work
}
