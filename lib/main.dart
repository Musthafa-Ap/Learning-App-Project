import 'package:flutter/material.dart';
import 'package:nuox_project/my_home_page.dart';
import 'package:nuox_project/pages/cart/cart_services/cart_services.dart';
import 'package:nuox_project/pages/catagories_detailed_page.dart/services/catagories_detailed_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/recomendations_services/recomendations_provider.dart';
import 'package:nuox_project/pages/course_detailed_page/services/course_detailed_provider.dart';
import 'package:nuox_project/pages/featured/services/catagories_section/catagories_provider.dart';
import 'package:nuox_project/pages/featured/services/featured_provider.dart';
import 'package:nuox_project/pages/featured/services/top_courses_section/top_courses_provider.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:nuox_project/authentication/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication/login_page.dart';
import 'authentication/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => FeaturedProvider()),
    ChangeNotifierProvider(create: (_) => CatagoriesProvider()),
    ChangeNotifierProvider(create: (_) => TopCoursesProvider()),
    ChangeNotifierProvider(create: (_) => CourseDetailedProvider()),
    ChangeNotifierProvider(create: (_) => CatagoriesDetailedProvider()),
    ChangeNotifierProvider(create: (_) => RecomendationsProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider())
  ], child: MyApp()));
}

bool isLoggedIn = false;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkLoggedInorNot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
            )),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }

  void checkLoggedInorNot() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    bool? checkData = _sharedPrefs.getBool("isLogged");
    if (checkData == null || checkData == false) {
      setState(() {
        isLoggedIn = false;
      });
    } else if (checkData == true) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoNextPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100,
          backgroundImage: NetworkImage(
            "https://anazonya.com/wp-content/uploads/2022/03/nuox-2.jpg",
          ),
        ),
      ),
    );
  }

  Future<void> gotoNextPage(context) async {
    await Future.delayed(Duration(seconds: 2));
    isLoggedIn
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()))
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
