class Information {
  int id = 0;
  String date = '';
  String email = '';
  int qualification = 0;
  String theBest = '';
  String theWorst = '';
  String remarks = '';

  Information({ 
    required this.id,
    required this.date,
    required this.email,
    required this.qualification,
    required this.theBest,
    required this.theWorst,
    required this.remarks
  });

  Information.fromJson(Map<String, dynamic> json) {
    (json['id'] != 0) ? id = json['id'] : id = 0;
    (json['date'] != null) ? date = json['date'] : date = '';
    (json['email'] != null) ? email = json['email'] : email = '';
    (json['qualification'] != 0) ? qualification = json['qualification'] : qualification = 0;
    (json['theBest'] != null) ? theBest = json['theBest'] : theBest = '';
    (json['theWorst'] != null) ? theWorst = json['theWorst'] : theWorst = '';
    (json['remarks'] != null) ? remarks = json['remarks'] : remarks = '';
  }
}

class SendInformation {
  String email = '';
  int qualification = 0;
  String theBest = '';
  String theWorst = '';
  String remarks = '';

  SendInformation({
    required this.email,
    required this.qualification,
    required this.theBest,
    required this.theWorst,
    required this.remarks
  });

  SendInformation.fromJson(Map<String, dynamic> json) {
    (json['email'] != null) ? email = json['email'] : email = '';
    (json['qualification'] != null) ? qualification = json['qualification'] : qualification = 0;
    (json['theBest'] != null) ? theBest = json['theBest'] : theBest = '';
    (json['theWorst'] != null) ? theWorst = json['theWorst'] : theWorst = '';
    (json['remarks'] != null) ? remarks = json['remarks'] : remarks = '';
  }
}
