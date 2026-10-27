import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/persistence/hive_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive CE local storage and open core boxes
  await HiveStorageService.init();

  runApp(
    const ProviderScope(
      child: WeatherApp(),
    ),
  );
}
