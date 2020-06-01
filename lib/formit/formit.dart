import 'package:flutter/material.dart';
import './schema.dart';

class FormFactory {
  // bnuilder configuration

  FormFactory();

  Widget build(Schema schema) {
    // return widget

    switch (schema.render) {
      default:
        return throw 'unknown render type: ${schema.render}';
    }
  }
}
