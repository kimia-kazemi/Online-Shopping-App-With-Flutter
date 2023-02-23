class Prediction {
  String? formattedName;
  String? state;
  String? placeid;

  Prediction({
    this.formattedName,
    this.state,
    this.placeid,
  });

  Prediction.fromJson(Map<String, dynamic> json) {
    placeid = json['properties']['place_id'];
    formattedName = json['properties']['formatted'];
    state = json['properties']['state'];
  }
}
