import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

Future<Response> createNewUser(
  BaseClient http,
) async {
  Response response;
  try {
    response = await http.get(Uri.parse('${dotenv.env['API_URL']}/user/login'));
  } catch (e) {
    response = Response(e.toString(), 444);
  }
  return response;
}

Future<Response> getConstants(BaseClient http) async {
  Response response;
  try {
    response = await http.get(Uri.parse('${dotenv.env['API_URL']}/constants'));
  } catch (e) {
    response = Response(e.toString(), 444);
  }
  return response;
}
