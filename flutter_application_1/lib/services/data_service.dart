import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  final String _apiUrl = 'https://jsonplaceholder.typicode.com/todos/1';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}