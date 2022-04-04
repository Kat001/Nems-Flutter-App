class MrnData {
  String? message;
  String? status;
  String? telecom;
  String? channel;

  MrnData({this.message, this.status, this.telecom, this.channel});

  MrnData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    telecom = json['telecom'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['telecom'] = this.telecom;
    data['channel'] = this.channel;
    return data;
  }
}
