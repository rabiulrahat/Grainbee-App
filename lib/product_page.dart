import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neon_widgets/neon_widgets.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:glossy/glossy.dart';
import 'package:provider/provider.dart';
import 'package:sodai_app/model/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:sodai_app/product_cart.dart';
import 'package:badges/badges.dart';
List<ProductModel> cart = [];

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //here i have created dummy product data
  static List<ProductModel> main_product_lists = [
    ProductModel(
      productTitle: "Rice",
      productPrice: 12,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/rice.png?raw=true",
      productGroup: ["Grocery", "Grain"],
    ),
    ProductModel(
        productTitle: "Lentil",
        productPrice: 40,
        productPosterUrl:
            // "https://github.com/rabiulrahat/testserver/blob/main/lentil.png?raw=true",
            "https://img.freepik.com/premium-photo/fresh-lentil-vegetables-isolated-transparent-background-ai-generated_585689-820.jpg?w=826",
        productGroup: ["Grocery", "Grain"]),
    ProductModel(
      productTitle: "Wheat",
      productPrice: 12,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/wheat.png?raw=true",
      productGroup: ["Grocery", "Grain"],
    ),
    ProductModel(
      productTitle: "Oil",
      productPrice: 40,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/oil.png?raw=true",
      productGroup: ["Grocery"],
    ),
    ProductModel(
      productTitle: "Egg",
      productPrice: 12,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/egg.png?raw=true",
      productGroup: ["Grocery"],
    ),
    ProductModel(
      productTitle: "Chili Powder",
      productPrice: 30,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/chili.png?raw=true",
      productGroup: ["Grocery"],
    ),
    ProductModel(
      productTitle: "Sugar",
      productPrice: 30,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/sugar.png?raw=true",
      productGroup: ["Grocery"],
    ),
    ProductModel(
      productTitle: "Tumeric",
      productPrice: 20,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/tumeric.png?raw=true",
      productGroup: ["Grocery"],
    ),
    ProductModel(
      productTitle: "Salt",
      productPrice: 20,
      productPosterUrl:
          "https://github.com/rabiulrahat/testserver/blob/main/salt.png?raw=true",
      productGroup: ["grocery"],
    ),
  ];
  //caaroselItems

  //here displaying the product list and filtering
  List<ProductModel> product_display = List.from(main_product_lists);
  void updatedList(String value) {
    setState(() {
      product_display = main_product_lists
          .where((element) =>
              element.productTitle!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  ///add to cart function
  void addToCart(ProductModel product) {
    setState(() {
      var existingProductIndex =
          cart.indexWhere((p) => p.productTitle == product.productTitle);
      if (existingProductIndex != -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product already added to cart.'),
          ),
        );
      } else {
        cart.add(ProductModel(
            productTitle: product.productTitle,
            productPrice: product.productPrice,
            productPosterUrl: '',
            productGroup: []));
      }
    });
  }
  void removeFromCart(ProductModel product) {
    setState(() {
      cart.remove(product);
    });
  }

  void navigateToProductDetails(ProductModel product) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetails(
              product: product,
              onProductUpdated: (updatedProduct) {
                setState(() {
                  var productIndex =
                      cart.indexWhere((p) => p.productTitle == updatedProduct.productTitle);
                  if (productIndex != -1) {
                    cart[productIndex] = updatedProduct;
                  }
                });
              })),
    );
  }

  void navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CartScreen(
              cart: cart,
              removeFromCart: removeFromCart,
              onQuantityChanged: (product, delta) {
                setState(() {
                  var productIndex =
                      cart.indexWhere((p) => p.productTitle == product.productTitle);
                  if (productIndex != -1) {
                    cart[productIndex].quantity += delta;
                    if (cart[productIndex].quantity <= 0) {
                      cart.removeAt(productIndex);
                    }
                  }
                });
              })),
    );
  }

  //i have to fix it
  // void groupList(String value) {
  //   setState(() {
  //     product_display = main_product_lists
  //         .where((element) =>
  //             element.productGroup!.any((productGroup) => productGroup == _productGroup))
  //       .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(221, 26, 26, 26),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
                height: 30,
              ),
              //  Container(child: NeonSearchBar()),\
              //here  i make a search bar using textfield widget
              Container(
                width: 300,
                height: 50,
                // color: Colors.red[400],
                //  product search bar
                child: TextField(
                  onChanged: (value) => updatedList(value),
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
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
                    hintStyle: TextStyle(fontSize: 17.0, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(
                width: 10,
                height: 30,
              ),
             FloatingActionButton.extended(
        onPressed: () {
          navigateToCart(context);
        },
        label: Text('Cart (${cart.length})'),
        icon: Icon(Icons.shopping_cart),
      ),
              //this is filter button after search bar

              // GlassButton(
              //   borderRadius: BorderRadius.circular(12),
              //   onPressed: () {
              //     showGlassBottomSheet(
              //         context: context,
              //         child: Center(
              //             child: GlassText("Hello World", fontSize: 20)));
              //   },
              //   child: GlassText("Button"),
              // ),
            ],
          ),
          SizedBox(
            width: 10,
            height: 10,
          ),
          // Container(
          //   height: 150,
          //   width: 300,
          //   child: GlassFlexContainer(
          //     child: Padding(
          //       padding: EdgeInsets.all(8),
          //       child: Center(child: GlassText("Banner")),
          //     ),
          //   ),
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Row(
              children: [
                //here  button for vegetable
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  // onTap: onPressed,
                  //button for vegetables
                  child: Container(
                    height: 100,
                    width: 90,
                    child: GlassFlexContainer(
                      border: BorderSide.strokeAlignInside,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Image(
                                image: NetworkImage(
                                    'https://freepngimg.com/thumb/cucumber/1-2-cucumber-png-hd-thumb.png'),
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ),
                          Center(
                              child: GlassText(
                            "Vegetable",
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 30,
                ),
                Container(
                  height: 100,
                  width: 90,
                  child: GlassFlexContainer(
                    border: BorderSide.strokeAlignInside,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image(
                              image: NetworkImage(
                                  'https://freepngimg.com/thumb/strawberry/1-strawberry-png-images.png'),
                              width: 60,
                              height: 50,
                            ),
                          ),
                        ),
                        Center(
                            child: GlassText(
                          "Fruits",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  width: 10,
                  height: 30,
                ),

                Container(
                  height: 100,
                  width: 90,
                  child: GlassFlexContainer(
                    border: BorderSide.strokeAlignInside,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image(
                              image: NetworkImage(
                                  'https://freepngimg.com/thumb/strawberry/1-strawberry-png-images.png'),
                              width: 60,
                              height: 50,
                            ),
                          ),
                        ),
                        Center(
                            child: GlassText(
                          "Fruits",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 30,
                ),

                Container(
                  height: 100,
                  width: 90,
                  child: GlassFlexContainer(
                    border: BorderSide.strokeAlignInside,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image(
                              image: NetworkImage(
                                  'https://freepngimg.com/thumb/strawberry/1-strawberry-png-images.png'),
                              width: 60,
                              height: 50,
                            ),
                          ),
                        ),
                        Center(
                            child: GlassText(
                          "Fruits",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 30,
                ),

                Container(
                  height: 100,
                  width: 90,
                  child: GlassFlexContainer(
                    border: BorderSide.strokeAlignInside,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Image(
                              image: NetworkImage(
                                  'https://freepngimg.com/thumb/strawberry/1-strawberry-png-images.png'),
                              width: 60,
                              height: 50,
                            ),
                          ),
                        ),
                        Center(
                            child: GlassText(
                          "Fruits",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //this slider or ad section
          CarouselSlider(
            items: [
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/sack-rice-with-rice-plant-place-wooden-floor_1150-34313.jpg?w=1380&t=st=1714375452~exp=1714376052~hmac=bde741407701218128ac6024ff83604d85fa1ec42b9559f21a574991a3f47f0c"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/glass-jar-red-lentils-with-wooden-spoon-wooden-board_114579-62880.jpg?t=st=1714375550~exp=1714379150~hmac=0c8fa293351cc1be6a23534db997f6efbb91fb3f2c28c4d35145438167d9ddd7&w=1380"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/red-chili-peppers-wooden-table-with-other-chilis-spices_1340-24043.jpg?t=st=1714375601~exp=1714379201~hmac=6eac485d02723e13cb9774bc3fe08bd479ebb36d962fd172458aa519292e70eb&w=1380"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg?t=st=1714375656~exp=1714379256~hmac=fe40bfa950f528afc445641a9ce6e587301327c0433bc546e86e59c9f5c9c827&w=1380"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/premium-photo/flat-lay-top-view-turmeric-curcumin-powder-wooden-bowl-spoon-with-fresh-rhizome-wood-background_252965-741.jpg?w=1380"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 160.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
              scrollDirection: Axis.horizontal,
            ),
          ),
          // Container(
          //   width: 300,
          //   height: 150,
          //   color: const Color.fromARGB(255, 87, 85, 85),
          //   child: Center(
          //     child: Text(
          //       'Banner',
          //       style: TextStyle(color: Colors.white, fontSize: 20),
          //     ),
          //   ),
          // ),

          SizedBox(
            width: 30,
            height: 30,
          ),
          Expanded(
              child: product_display.length == 0
                  ? Center(
                      child: Text("Product not found",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1 / 1.2,
                        // mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemCount: product_display.length,
                      itemBuilder: (BuildContext context, int index) {
                      final product = product_display[index];

                        return Column(
                          children: [
                            SizedBox(
                              height: 230,
                              width: 230,
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Gesture Detected!')));
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        children: [
                                          // SizedBox(
                                          //   child: Image(
                                          //       // alignment: Alignment.ce,
                                          //       width: 80.0,
                                          //       height: 80.0,
                                          //       image: NetworkImage(product_display[index]
                                          //           .productPosterUrl!)),
                                          // ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: NeonPoint(
                                              pointSize: 00,
                                              spreadColor:
                                                  Colors.green.withOpacity(0.5),
                                              lightSpreadRadius: 90,
                                            ),
                                          ),
                                          Container(
                                            // spreadColor: Colors.green,
                                            // borderWidth: 0,
                                            // borderColor: Colors.greenAccent,
                                            // borderRadius: BorderRadius.circular(1000.90),
                                            child:
                                                // Image.network(
                                                //   product_display[index].productPosterUrl!,
                                                //   fit: BoxFit.contain,
                                                // ),
                                                //     CachedNetworkImage(
                                                //   imageUrl:
                                                //       product_display[index].productPosterUrl!,
                                                //   placeholder: (context, url) =>
                                                //       CircularProgressIndicator(),
                                                //   errorWidget: (context, url, error) =>
                                                //       Icon(Icons.error),
                                                // ),
                                                Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Image(
                                                        // alignment: Alignment.ce,
                                                        width: 100.0,
                                                        height: 100.0,
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            product_display[
                                                                    index]
                                                                .productPosterUrl!)),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  product_display[index]
                                                      .productTitle!,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "৳ " +
                                                      "${product_display[index].productPrice}",
                                                  style: TextStyle(
                                                      color: Colors.greenAccent,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Image.asset('assets/card-sample-image-2.jpg'),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: CircleBorder(),
                                                ),
                                                onPressed: () {
                                                  addToCart(product);
                                                },
                                                child: const Icon(
                                                  Icons.shopping_bag_outlined,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }))
        ],
      ),
    );
  }

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
//         ]));
//   }
// }
}
