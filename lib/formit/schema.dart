// Minimal

//
enum Type {
  String,
  Number,
  Int,
  Float,
  Bool,
  Array,
  Object,
}

class Option {
  String title;
  dynamic value;

  Option.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    value = json["value"];
  }
}

class Schema {
  String name;
  String title;
  String description;
  Type type;
  dynamic value;
  bool require; // required???

  // string and numberic
  String format; // Registry take the function to handle

  // string:
  String pattern;
  int minLength;
  int maxLength;

  // numberic:
  int minimum;
  int exclusiveMinimum;
  int maximum;
  int exclusiveMaximum;
  int multipleOf;

  // object:
  Map<String, Schema> properties;
  bool additionalProperties;
  List<String> propertyNames;
  int minProperties;
  int maxProperties;
  String patternProperties;

  // array:
  Schema items;
  List<dynamic> contains;
  bool additionalItems;
  int minItems;
  int maxItems;

  List<Option> options;
  List<dynamic> enums;

  // meta:
  String render; // render type
  String condition;
  bool ignore;

  Schema.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    value = json['value'];
    require = json['require'] ?? false;
    format = json['format'];
    pattern = json['pattern'];
    minLength = json['minLength'];
    maxLength = json['maxLength'];
    minimum = json['minimum'];
    exclusiveMinimum = json['exclusiveMinimum'];
    maximum = json['maximum'];
    exclusiveMaximum = json['exclusiveMaximum'];
    multipleOf = json['multipleOf'];
    additionalProperties = json['additionalProperties'] ?? true;
    propertyNames = json['propertyNames'].cast<String>();
    minProperties = json['minProperties'];
    maxProperties = json['maxProperties'];
    patternProperties = json['patternProperties'];
    contains = json['contains'] ?? [];
    additionalItems = json['additionalItems'] ?? true;
    minItems = json['minItems'];
    maxItems = json['maxItems'];
    render = json['render'];
    condition = json['condition'];
    ignore = json['ignore'] ?? false;

    if (json["properties"] != null) {
      properties = {};
      json["properties"].forEach((String k, dynamic v) {
        properties[k] = Schema.fromJson(v);
      });
    }

    if (json["items"] != null) {
      items = Schema.fromJson(json["items"]);
    }

    if (json["options"] != null) {
      options = json["options"].map((v) => Option.fromJson(v)).toList();
    }

    enums = json['enum'];

    // try to guess the render
  }
}
