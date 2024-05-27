import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/report.dart';

class ReportRepository {
  final String apiUrl = 'https://retoolapi.dev/pfWQZi/data';

  Future<List<Report>> fetchReports() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return responseData.map((data) => Report.fromJson(data)).toList();
      } else {
        throw Exception('Failed to fetch reports');
      }
    } catch (e) {
      print('Error fetching reports: $e');
      throw Exception('Failed to fetch reports');
    }
  }
}
