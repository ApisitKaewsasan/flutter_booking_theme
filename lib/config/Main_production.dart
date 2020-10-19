

import 'package:basic_utils/basic_utils.dart';
import 'package:ds_book_app/config/Env.dart';
import 'package:flutter/material.dart';

void main() => Production();

class Production extends Env {
  EnvType environmentType = EnvType.PRODUCTION;
  final String appName = "DS BooKing";
  final String baseUrl = 'https://api.website.org';
  final String dbName = 'DSBooKing.db';
}