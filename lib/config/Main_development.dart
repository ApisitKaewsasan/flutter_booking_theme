

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';

void main() => Development();

class Development extends Env {
  EnvType environmentType = EnvType.DEVELOPMENT;
  final String appName = "DS BookIng Dev";
 // final String baseUrl = 'https://api.dev.website.org';
  final String baseUrl = 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1';
  final String dbName = 'DSBooKing-Dev.db';
}