import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
// import 'package:neon_widgets/neon_widgets.dart';
// import 'package:glassmorphism_ui/glassmorphism_ui.dart';
// import 'package:glossy/glossy.dart';
// import 'package:sodai_app/model/product_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'product_page.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

void main() {
  runApp(const MyApp());
}

enum _SelectedTab { home, favorite, add, search, person }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'grain bee',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var _selectedTab = _SelectedTab.home;

  // void _handleIndexChanged(int i) {
  //   setState(() {
  //     _selectedTab = _SelectedTab.values[i];
  //   });
  // }
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      backgroundColor: Colors.black);
  static const List<Widget> _widgetOptions = <Widget>[
    ProductPage(),
    ProductPage(),
    ProductPage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),

      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: CrystalNavigationBar(
          currentIndex: _selectedIndex,
          // _SelectedTab.values.indexOfe(_selectedTab),
          height: 10,
          // indicatorColor: Colors.blue,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          onTap: _onItemTapped,
          //  _handleIndexChanged,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.arrow_down_circle,
              unselectedIcon: IconlyLight.more_circle,
              selectedColor: Colors.green,
            ),

            /// Favourite
            CrystalNavigationBarItem(
              icon: IconlyBold.bag_2,
              unselectedIcon: Icons.shopping_bag_rounded,
              selectedColor: Colors.green,
            ),

            /// Search
            CrystalNavigationBarItem(
                icon: IconlyBold.notification,
                unselectedIcon: IconlyLight.
                notification,
                selectedColor: Colors.green),

            /// Profile
            CrystalNavigationBarItem(
              icon: IconlyBold.user_2,
              unselectedIcon: IconlyLight.user,
              selectedColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
