import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/persistence/hive_storage_service.dart';
import 'features/visual_engine/presentation/shaders/shader_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive CE local storage and open core boxes
  await HiveStorageService.init();

  // Asynchronously pre-warm Impeller fragment shaders
  // Non-blocking so app starts instantly
  ShaderManager.instance.init();

  runApp(
    const ProviderScope(
      child: WeatherApp(),
    ),
  );
}
