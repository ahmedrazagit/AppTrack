// Make sure to import the AIAnalysisService
// ai_analysis_service.dart
//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
import 'dart:convert';
import 'package:http/http.dart' as http;

class AIAnalysisService {
  final String _openAiApiKey =
      ""; // Securely manage this key

  Future<String> getAnalysis(String prompt) async {
    const url = "https://api.openai.com/v1/chat/completions";
    const model = "gpt-3.5-turbo"; // Update to the model you have access to

    final headers = {
      "Authorization": "Bearer $_openAiApiKey",
      "Content-Type": "application/json",
    };

    final body = jsonEncode({
      "model": model,
      "prompt": prompt,
      "temperature": 0.7,
      "max_tokens": 256,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["choices"][0]["text"];
      } else {
        print(
            'Failed to load analysis. Status code: ${response.statusCode}. Response body: ${response.body}');
        return "Analysis failed with status code: ${response.statusCode}";
      }
    } catch (e) {
      print('Exception caught while fetching analysis: $e');
      return "Failed to load analysis due to an exception.";
    }
  }
}
