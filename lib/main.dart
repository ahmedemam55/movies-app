import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/features/browse/page/browse_page.dart';
import 'package:movies_app/features/layout_page/page/layout_page.dart';
import 'package:movies_app/features/search/page/search_page.dart';
import 'package:movies_app/features/watch_list/page/watch_list_page.dart';
import 'package:movies_app/features/watch_list/widgets/boxes.dart';
import 'package:movies_app/core/config/application_theme_manager.dart';
import 'package:movies_app/features/home/page/home_page.dart';
import 'package:movies_app/features/splash/splach_screen.dart';
import 'package:movies_app/features/watch_list/widgets/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(dbAdapter());
  }
  
  boxDb = await Hive.openBox<db>('dbBox');
  
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ApplicationThemeManager.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        HomePage.routeName: (context) => const HomePage(),
        SearchPage.routeName: (context) => const SearchPage(),
        WatchListPage.routeName: (context) => const WatchListPage(),
        BrowsePage.routeName: (context) => const BrowsePage(),
        LayoutView.routeName: (context) => LayoutView(), // أزلت كلمة const من هنا
      },
    );
  }
}
