import 'dart:convert' as convert;

abstract class Entity {

  Map<String, dynamic> toMap();

  String toJson() {
    String json = convert.json.encode(toMap());
    return json;
  }
}