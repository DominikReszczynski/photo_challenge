import 'dart:convert';
import 'dart:io';

import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/properties.dart';
import 'package:http/http.dart' as http;

class PropertyServices {
  final String _urlPrefix = ApiService.baseUrl;

  Future<Property?> addProperty(Property property, File? imageFile) async {
    final uri = Uri.parse('$_urlPrefix/property/addProperty');
    final request = http.MultipartRequest('POST', uri);

    // Dodaj dane JSON jako pole tekstowe
    request.fields['property'] = jsonEncode(property.toJson());

    // Dodaj plik jako multipart
    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    // Wyślij żądanie
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = json.decode(response.body);
      if (decoded['success']) {
        print(decoded['property']);
        return Property.fromJson(decoded['property']);
      }
    }

    return null;
  }

  Future<List<Property?>?> getAllPropertiesByOwner() async {
    // final prefs = await SharedPreferences.getInstance();
    // final storedUserId = prefs.getString('userId');

    print(loggedUser!.id);
    Map<String, dynamic> body = {
      'userID': loggedUser!.id,
    };
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/property/getAllByOwner'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    if (decodedBody['success']) {
      List<Property> properties = [];
      for (var property in decodedBody['properties']) {
        properties.add(Property.fromJson(property));
      }
      return properties;
    }
    return null;
  }

  Future<List<Property?>?> getAllPropertiesByTenant() async {
    // final prefs = await SharedPreferences.getInstance();
    // final storedUserId = prefs.getString('userId');
    // print(storedUserId);
    Map<String, dynamic> body = {
      'userID': loggedUser!.id,
    };
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/property/getAllByTenant'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    if (decodedBody['success']) {
      List<Property> properties = [];
      for (var property in decodedBody['properties']) {
        properties.add(Property.fromJson(property));
      }
      return properties;
    }
    return null;
  }

  Future<bool> setPin(String propertyID, String pin) async {
    print(loggedUser!.id);
    Map<String, dynamic> body = {
      'propertyID': propertyID,
      'pin': pin,
    };
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/property/setPin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    if (decodedBody['success']) {
      return true;
    }
    return false;
  }

  Future<bool> removePin(String propertyID) async {
    print(loggedUser!.id);
    Map<String, dynamic> body = {
      'propertyID': propertyID,
    };
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/property/removePin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    if (decodedBody['success']) {
      return true;
    }
    return false;
  }

  Future addTenantToProperty(
      String propertyID, String pin, String tenantID) async {
    Map<String, dynamic> body = {
      'propertyID': propertyID,
      'pin': pin,
      'tenantID': tenantID,
    };
    final http.Response res = await http.post(
      Uri.parse('$_urlPrefix/property/addTenantToProperty'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    print(res.body);
    Map<String, dynamic> decodedBody = json.decode(res.body);
    if (decodedBody['success']) {
      Property result = Property.fromJson(decodedBody['property']);
      return result;
    }
    return null;
  }
}
