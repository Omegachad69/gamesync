import 'package:gameync/core/error/exception.dart';
import 'package:gameync/features/matches/data/models/match_model.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class MatchRemoteDataSource {
  Future<MatchModel> uploadMatches(MatchModel match);

  Future<List<MatchModel>> getAllMatches(
      {required String tid, required int rno});

  Future<String> uploadWinner({required String mid, required String winner});

  Future<List<MatchModel>> getUserMatches({required String pid});
}

class MatchRemoteDataSourceImpli implements MatchRemoteDataSource {
  final SupabaseClient supabaseClient;
  MatchRemoteDataSourceImpli(this.supabaseClient);

  @override
  Future<MatchModel> uploadMatches(MatchModel match) async {
    try {
      final matchData =
          await supabaseClient.from('matches').insert(match.toMap()).select();
      return MatchModel.fromMap(matchData.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<List<MatchModel>> getAllMatches(
      {required String tid, required int rno}) async {
    try {
      final matches = await supabaseClient
          .from('matches')
          .select(
            '*,p1name:profiles!fk_p1(uname),p2name:profiles!fk_p2(uname),winner:profiles!fk_winner(uname),tname:tournaments!t_id(tname)',
          )
          .eq('tid', tid)
          .eq('rno', rno);

      return matches
          .map(
            (match) => MatchModel.fromMap(match).copyWith(
              p1name: match['p1name']['uname'],
              p2name: match['p2name']['uname'],
              winner: match['winner'] == null ? null : match['winner']['uname'],
              tname: match['tname']['tname'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String> uploadWinner(
      {required String mid, required String winner}) async {
    try {
      await supabaseClient
          .from('matches')
          .update({'winner': winner}).eq('mid', mid);
      return 'Succes';
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<List<MatchModel>> getUserMatches({required String pid}) async {
    try {
      final matchesu = await supabaseClient
          .from('matches')
          .select(
            '*,p1name:profiles!fk_p1(uname),p2name:profiles!fk_p2(uname),winner:profiles!fk_winner(uname),tname:tournaments!t_id(tname)',
          )
          .or('p1.eq.$pid,p2.eq.$pid');
      // .eq('winner', 'null');
      return matchesu
          .map(
            (match) => MatchModel.fromMap(match).copyWith(
              p1name: match['p1name']['uname'],
              p2name: match['p2name']['uname'],
              winner: match['winner'] == null ? null : match['winner']['uname'],
              tname: match['tname']['tname'],
            ),
          )
          .toList();
    } on ServerException catch (e) {
      throw ServerException(e.message);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    }
  }
}
