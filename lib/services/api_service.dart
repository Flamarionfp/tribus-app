import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";

  Future<List<Map<String, String>>> fetchClasses() async {
    final uri = Uri.parse("$baseUrl/classes");

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar classes (${response.statusCode})");
    }

    final decoded = jsonDecode(response.body);

    return List<Map<String, String>>.from(
      decoded["classes"].map(
        (item) => {
          "id": item["id"].toString(),
          "label": item["label"].toString(),
        },
      ),
    );
  }

  Future<Map<String, dynamic>> predictImage(File image) async {
    var uri = Uri.parse("$baseUrl/predict");

    var request = http.MultipartRequest("POST", uri);
    request.files.add(await http.MultipartFile.fromPath("file", image.path));

    final streamed = await request.send();
    final body = await streamed.stream.bytesToString();

    if (streamed.statusCode != 200) {
      throw Exception("Erro na predição (${streamed.statusCode})");
    }

    return jsonDecode(body);
  }
}
