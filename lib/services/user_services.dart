import 'dart:convert';

import 'package:cas_house/api_service.dart';
import 'package:http/http.dart' as http;

class UserServices {
  final String _urlPrefix = ApiService.baseUrl;

  login(String email, String password) async {
    print('UserServices: login');
    Map<String, dynamic> body = {'email': email, 'password': password};
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    print(decodedBody);
    print(1);
    return decodedBody;
  }

  registration(String email, String password, String name) async {
    print('UserServices: registration');
    Map<String, dynamic> body = {
      'email': email,
      'password': password,
      'username': name
    };
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/user/registration'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    print("blub " + jsonEncode(decodedBody['success']));

    return decodedBody['success'];
  }
}
