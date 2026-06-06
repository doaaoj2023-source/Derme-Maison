import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'splash_screen.dart';
import 'providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DermeMaison());
}

class DermeMaison extends StatelessWidget {
  const DermeMaison({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dermé Maison',

        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.transparent,
        ),

        home: const SplashScreen(),
      ),
    );
  }
}