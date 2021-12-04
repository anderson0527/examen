import 'dart:convert';
import 'package:examen/models/information.dart';
import 'package:examen/models/response.dart';
import 'package:examen/models/token.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static Future<Response> getInformation(Token token) async {
    var url = Uri.parse('https://vehicleszulu.azurewebsites.net/api/Finals');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization': 'bearer ${token.token}',
      },
    );

    var body = response.body;
    if (response.statusCode >= 400){
      return Response(message: body);
    }

    var decodedJson = jsonDecode(body);
    return Response(message: 'true', result: Information.fromJson(decodedJson));
  }

  static Future<Response> sendInformation(Map<String, dynamic> sendInformation, Token token) async {
    var url = Uri.parse('https://vehicleszulu.azurewebsites.net/api/Finals');
    var response = await http.post(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization': 'bearer ${token.token}',
      },
      body: jsonEncode(sendInformation),
    );

    var body = response.body;
    if (response.statusCode >= 400){
      return Response(message: body);
    }

    var decodedJson = jsonDecode(body);
    return Response(message: 'true', result: Information.fromJson(decodedJson));
  }
}
