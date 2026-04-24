import 'package:firebase_service/firebase_service.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();
  await configureDependencies();
  runApp(const App());
}
