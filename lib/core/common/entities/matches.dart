class Matches {
  final String mid;
  final String p1;
  final String p2;
  final int rno;
  final String tid;
  final String? p1name;
  final String? p2name;
  final String? winner;
  final String? tname;
  Matches({
    required this.mid,
    required this.p1,
    required this.p2,
    required this.rno,
    required this.tid,
    this.p1name,
    this.p2name,
    this.winner,
    this.tname,
  });
}
