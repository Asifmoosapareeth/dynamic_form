
import 'package:flutter/material.dart';

import '../form_model.dart';
import '../form_service.dart';


class DynamicFormPage extends StatefulWidget {
  @override
  _DynamicFormPageState createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  late Future<List<DynamicFormField>> _formFields;

  @override
  void initState() {
    super.initState();
    _formFields = FormService().fetchFormFields();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Form'),
      ),
      body: FutureBuilder<List<DynamicFormField>>(
        future: _formFields,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No form fields available'));
          }

          List<DynamicFormField> formFields = snapshot.data!;

          return Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: formFields.length,
              itemBuilder: (context, index) {
                DynamicFormField field = formFields[index];

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(field.label, style: TextStyle(fontSize: 16)),
                      field.required==true
                          ? DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Select ${field.label}',
                        ),
                        items: field.options
                            .map((option) => DropdownMenuItem<String>(
                          value: option.optionValue,
                          child: Text(option.optionValue),
                        ))
                            .toList(),
                        onChanged: (value) {},
                      )
                          : TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter ${field.label}',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

