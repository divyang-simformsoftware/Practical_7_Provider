import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/firebase_options.dart';
import 'package:shoppingcart/pages/homepage.dart';
import 'package:shoppingcart/providers/addcartprovider.dart';
import 'package:shoppingcart/providers/bottomprovider.dart';
import 'package:shoppingcart/providers/indicatorprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: 'My-Shop', options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AddCartProvider>(
          create: (context) => AddCartProvider(),
        ),
        ChangeNotifierProvider<BottomAppProvider>(
          create: (context) => BottomAppProvider(),
        ),
        ChangeNotifierProvider<IndicatorProvider>(
          create: (context) => IndicatorProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'AppShop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}
