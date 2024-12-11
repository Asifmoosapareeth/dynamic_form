class DynamicFormField {
  final int id;
  final String label;
  final String type;
  final bool required;
  final List<Option> options;

  DynamicFormField({
    required this.id,
    required this.label,
    required this.type,
    required this.required,
    required this.options,
  });

  factory DynamicFormField.fromJson(Map<String, dynamic> json) {
    return DynamicFormField(
      id: json['id'],
      label: json['label'],
      type: json['type'],
      required: json['required'] ,
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String optionValue;

  Option({required this.id, required this.optionValue});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      optionValue: json['option_value'],
    );
  }
}
