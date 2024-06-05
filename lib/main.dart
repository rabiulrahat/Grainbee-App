import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:sodai_app/motor_control.dart';
import 'package:sodai_app/notification_page.dart';
import 'package:sodai_app/product_cart.dart';
import 'model/product_model.dart';
import 'product_page.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'cart_screen.dart';

void main() async {
  runApp(MyApp());
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //   apiKey: "AIzaSyDUsR4F_nxc7uTv-5ikLx3yrRPYCQo6M0w",
  //   projectId: "grainbee-267a9",
  //   messagingSenderId: "156799547924",
  //   appId: "1:156799547924:web:d8d79dd231755707b58501",
  // )
  // );
  //   await Firebase.initializeApp(
  // );
}

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     return FirebaseOptions(
//       apiKey: "AIzaSyDUsR4F_nxc7uTv-5ikLx3yrRPYCQo6M0w",
//       projectId: "grainbee-267a9",
//       messagingSenderId: "156799547924",
//       appId: "1:156799547924:web:d8d79dd231755707b58501",
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductCart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'grain bee',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        themeMode: ThemeMode.dark,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      backgroundColor: Colors.black);
  static List<Widget> _widgetOptions = <Widget>[
    ProductPage(),
    Consumer<ProductCart>(
      builder: (context, cart, child) {
        return CartScreen(
          cart: cart.items,
          removeFromCart: cart.removeFromCart,
          onQuantityChanged: cart.onQuantityChanged,
        );
      },
    ),
    NotificationPage(notifications: notifications),
    // ApiPage(),
    // MPage()
    // Text(
    //   'Index 2: School',
    //   style: optionStyle,
    // ),
    // Text(
    //   'Index 3: School',
    //   style: optionStyle,
    // ),
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
          height: 10,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withOpacity(0.1),
          onTap: _onItemTapped,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.arrow_down_circle,
              unselectedIcon: IconlyLight.more_circle,
              selectedColor: Colors.green,
            ),

            // / Favourite
            CrystalNavigationBarItem(
              icon: IconlyBold.bag_2,
              unselectedIcon: Icons.shopping_bag_rounded,
              selectedColor: Colors.green,
            ),


            /// Search
            CrystalNavigationBarItem(
                icon: IconlyBold.notification,
                unselectedIcon: IconlyLight.notification,
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

class ProductCart with ChangeNotifier {
  List<ProductModel> get items => cart;

  void addToCart(ProductModel product) {
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    cart.remove(product);
    notifyListeners();
  }

  void onQuantityChanged(ProductModel product, int quantity) {
    final index =
        cart.indexWhere((item) => item.productTitle == product.productTitle);
    if (index != -1) {
      cart[index].quantity += quantity;
      if (cart[index].quantity <= 0) {
        removeFromCart(product);
      } else {
        notifyListeners();
      }
    }
  }
}
