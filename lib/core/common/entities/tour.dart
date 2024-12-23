class Tour {
  final String tname;
  final String tid;
  final String adminId;
  final String descp;
  final String rules;
  final DateTime dateTime;
  final String imageUrl;
  final bool isPaid;
  final bool ispvp;
  final bool isduel;
  final int maxPartcipants;
  final int? maxTeam;
  final double? pricepool;
  final bool isprivate;
  final String? inviteLink;
  final int noWinners;
  final double? entryfee;
  final String game;
  final String? aname;
  final int? cPart;

  Tour({
    required this.tname,
    required this.tid,
    required this.adminId,
    required this.descp,
    required this.rules,
    required this.dateTime,
    required this.imageUrl,
    required this.isPaid,
    required this.ispvp,
    required this.isduel,
    required this.maxPartcipants,
    required this.maxTeam,
    required this.pricepool,
    required this.isprivate,
    required this.inviteLink,
    required this.noWinners,
    required this.entryfee,
    required this.game,
    required this.cPart,
    this.aname,
  });
}
