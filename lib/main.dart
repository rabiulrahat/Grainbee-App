import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:glossy/glossy.dart';
import 'package:sodai_app/model/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //here i have created dummy product data
  static List<ProductModel> main_product_lists = [
    ProductModel()
  ]
  void updatedList(String value){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(221, 26, 26, 26),
        body: Column(children: [
          const SizedBox(
            width: 30,
            height: 30,
          ),

          Row(
            children: [
              const SizedBox(
                width: 30,
                height: 30,
              ),
              //  Container(child: NeonSearchBar()),\
              Container(
                width: 300,
                height: 50,
                // color: Colors.red[400],
                child: TextField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Color.fromARGB(179, 129, 126, 126)),
                  decoration: InputDecoration(
                    // hoverColor: Colors.white,
                    // focusColor: Colors.white,
                    filled: true,
                    fillColor: const Color.fromARGB(255, 48, 48, 48),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: 'I Want...',
                  ),
                ),
              ),

              const SizedBox(
                width: 25,
                height: 30,
              ),
              GlossyContainer(
                width: 60,
                height: 50,
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(
                      Icons.add,
                    ),
                    onPressed: () {},
                    // onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 30,
            height: 30,
          ),
          Container(
            width: 150,
            height: 150,
            color: Colors.red[400],
            child: Text(
              'Red',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
          ),
          Expanded(child: ListView(),),

//           Center(
//             child: Stack(
//               children: [
//                 GlassContainer(
//   height: 200,
//   width: 200,
//   blur: 4,
//   color: Colors.white.withOpacity(0.1),
//   gradient: LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [
//       Colors.white.withOpacity(0.2),
//       Colors.blue.withOpacity(0.3),
//     ],
//   ),
//   //--code to remove border
//   border: Border.fromBorderSide(BorderSide.none),
//   shadowStrength: 5,
//   shape: BoxShape.circle,
//   borderRadius: BorderRadius.circular(16),
//   shadowColor: Colors.white.withOpacity(0.24),
// ),
//                 NeonContainer(
//                     spreadColor: Colors.greenAccent,
//                     borderWidth: 2,
//                     borderColor: Colors.greenAccent,
//                     borderRadius: BorderRadius.circular(1120.90),
//                     child: const Image(
//                         // alignment: Alignment.ce,
//                         width: 200.0,
//                         height: 200.0,
//                         image: AssetImage("assets/image.png"))),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
        ]));
  }
}
