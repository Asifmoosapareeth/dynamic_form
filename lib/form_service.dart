import 'dart:convert';
import 'package:http/http.dart' as http;

import 'form_model.dart';

class FormService {
  final String apiUrl = 'http://127.0.0.1:8000/api/dynamic-form';
  final String apiUrl2 = 'http://127.0.0.1:8000/api/dynamic-form2';

  Future<List<DynamicFormField>> fetchFormFields() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['form_fields'];
      return data.map((item) => DynamicFormField.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load form fields');
    }
  }
  Future<List<DynamicFormField>> fetchsecondFormFields() async {
    final response = await http.get(Uri.parse(apiUrl2));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['form_fields2'];
      return data.map((item) => DynamicFormField.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load form fields');
    }
  }

}
