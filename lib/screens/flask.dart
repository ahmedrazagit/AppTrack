import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String _baseUrl = 'http://127.0.0.1:5000/predict';

  Future<List<double>> getPredictions(List<double> lastDayData) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"data": lastDayData}),
    );

    if (response.statusCode == 200) {
      List<dynamic> predictions = json.decode(response.body);
      return predictions
          .map<double>((prediction) => prediction.toDouble())
          .toList();
    } else {
      print('Error from API: ${response.body}');
      throw Exception(
          'Failed to load predictions. Status code: ${response.statusCode}');
    }
  }
}
