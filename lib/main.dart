import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movilizate/core/blocs/parking/parking_bloc.dart';
import 'package:movilizate/core/routes/app_router.dart';
import 'package:movilizate/core/themes/theme.dart';
import 'package:movilizate/views/parking/map_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nqvzmratixdaoqpxrumh.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xdnptcmF0aXhkYW9xcHhydW1oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMwMTc1NTMsImV4cCI6MjA1ODU5MzU1M30.hDEItAepVK5KHBtowuBMi5DI9F5KoNAwOuHeV_ITqE0',
  );

  runApp(
    BlocProvider(
      create: (context) => ParkingBloc()..add(LoadParkings()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movilizate',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      routerConfig: appRouter(),
    );
  }
}
