import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_diary/firebase_options.dart';
import 'package:mood_diary/routes.dart';

const Color BaseColor = Color(0xFFFFECB3);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
          textTheme: GoogleFonts.nanumBrushScriptTextTheme(
            ThemeData(brightness: Brightness.light).textTheme,
          ),
          scaffoldBackgroundColor: BaseColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: BaseColor,
          ),
          bottomAppBarTheme: const BottomAppBarTheme(
              color: BaseColor, surfaceTintColor: BaseColor)),
    );
  }
}
