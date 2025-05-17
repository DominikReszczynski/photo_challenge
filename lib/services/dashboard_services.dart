import 'dart:convert';

import 'package:cas_house/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardServices {
  final String _urlPrefix = ApiService.baseUrl;

  chat() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUserId = prefs.getString('userId');
    print('DashboardServices');
    Map<String, dynamic> body = {'userID': storedUserId};
    print(_urlPrefix);
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/dashboard/chat'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    Map<String, dynamic> decodedBody = json.decode(res.body);
    print(decodedBody);
    if (decodedBody['success']) {
      String text = decodedBody['text'][0]['text'];
      return text;
    }
  }
}
