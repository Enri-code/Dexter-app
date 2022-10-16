import 'package:dexter_test/app.dart';
import 'package:dexter_test/core/services/app_init.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInit.setupFirebase();
  runApp(const DexterApp());
}
