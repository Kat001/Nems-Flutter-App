class DobData {
  String? message;
  String? status;
  String? telecom;
  String? channel;
  String? mrn;

  DobData({this.message, this.status, this.telecom, this.channel, this.mrn});

  DobData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    telecom = json['telecom'];
    channel = json['channel'];
    mrn = json['mrn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['telecom'] = this.telecom;
    data['channel'] = this.channel;
    data['mrn'] = this.mrn;
    return data;
  }
}
