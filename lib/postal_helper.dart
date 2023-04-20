import 'dart:convert';

import 'package:http/http.dart' as http;

class PostalHelper {
  static Future<List<Map>> getPostOffices(String pincode) async {
    List<Map> postOffices = [];
    var response = await http
        .get(Uri.parse("https://api.postalpincode.in/pincode/$pincode"));
    var responseData = json.decode(response.body)[0];
    List<dynamic> postOfficesData = responseData['PostOffice'];
    postOfficesData.forEach((element) {
      print(element['Name']);
      postOffices.add(
        {
          'Name': element['Name'],
          'BranchType': element['BranchType'],
          'DeliveryStatus': element['DeliveryStatus'],
          'Circle': element['Circle'],
        },
      );
    });
    return Future.value(postOffices);
  }
}
