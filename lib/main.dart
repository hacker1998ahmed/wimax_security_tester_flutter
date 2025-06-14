import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wimax_pentest_flutter/core/attack_executor.dart';
import 'package:wimax_pentest_flutter/ui/screens/home_screen.dart';
import 'package:wimax_pentest_flutter/ui/theme/app_theme.dart';
import 'package:wimax_pentest_flutter/services/notification_service.dart';
import 'package:wimax_pentest_flutter/utils/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة Firebase
  await _initializeFirebase();
  
  // تهيئة الإشعارات
  await NotificationService.initialize();
  
  // تهيئة أدوات الهجوم
  await AttackExecutor.initializeTools();
  
  // تسجيل بدء التشغيل
  AppLogger.debug('Application started');
  
  runApp(const MyApp());
}

Future<void> _initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "YOUR_API_KEY",
        appId: "YOUR_APP_ID",
        messagingSenderId: "YOUR_SENDER_ID",
        projectId: "YOUR_PROJECT_ID",
        storageBucket: "YOUR_STORAGE_BUCKET",
      ),
    );
    AppLogger.debug('Firebase initialized successfully');
  } catch (e) {
    AppLogger.error('Firebase initialization failed', e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiMax Pentest Tool',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // الإنجليزية
        Locale('ar', 'SA'), // العربية
      ],
      home: const HomeScreen(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}