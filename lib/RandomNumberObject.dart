class RandomNumberObject {
  String randomNumber;
  String timeStamp;


  RandomNumberObject.fromJson(Map<String, dynamic> responseBody) {
    randomNumber = responseBody['randomNumber'];
    timeStamp = responseBody['timeStamp'];

  }

  Map<String, dynamic> toJson() {
    Map<String,dynamic> json = Map();
    json['randomNumber'] = randomNumber;
    json['timeStamp'] = timeStamp;
    return json;
  }


}