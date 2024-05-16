import 'package:assignment/Favourite.dart';
import 'package:assignment/Person.dart';
import 'package:assignment/boxes.dart';
import 'package:assignment/components/ChangeNotifier.dart';
import 'package:assignment/views/Liked.dart';
import 'package:assignment/views/Profile.dart';
import 'package:assignment/views/Starting_screen.dart';
import 'package:assignment/views/sign_in.dart';
import 'package:assignment/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(FavoriteAdapter());
  boxPersons = await Hive.openBox<Person>('PersonBox');
  boxFavourite = await Hive.openBox<Favorite>('FavoriteBox');

  runApp(
    ChangeNotifierProvider(
      create: (context) => StoreData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: StartingScreen.routeName,
      routes: {
        StartingScreen.routeName: (_) => const StartingScreen(),
        SignUp.routeName: (_) => const SignUp(),
        SignIn.routeName: (_) => const SignIn(),
        Profile.routeName: (_) => const Profile(),
        LikedStores.routeName: (_) => const LikedStores(),
      },
    );
  }
}
