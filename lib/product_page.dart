import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neon_widgets/neon_widgets.dart';

// import 'package:glossy/glossy.dart';
import 'package:sodai_app/model/product_model.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:provider/provider.dart';
import 'package:sodai_app/product_cart.dart';

// import 'package:badges/badges.dart';
List<ProductModel> cart = [];
//////////////////////////////////
//new code for  category design//
/////////////////////////////////
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
// final List<String> products = List.generate(50, (index) => 'Product $index');
  static List<ProductModel> products = [
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
  //////////////////////////////
  ///  //here displaying the product list and filtering
  List<ProductModel> product_display = List.from(products);
  void updatedList(String value) {
    setState(() {
      product_display = products
          .where((element) =>
              element.productTitle!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  ///add to cart function
  // void addToCart(ProductModel product) {
  //   setState(() {
  //     var existingProductIndex =
  //         cart.indexWhere((p) => p.productTitle == product.productTitle);
  //     if (existingProductIndex != -1) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Product already added to cart.'),
  //         ),
  //       );
  //     } else {
  //       cart.add(ProductModel(
  //           productTitle: product.productTitle,
  //           productPrice: product.productPrice,
  //           productPosterUrl: product.productPosterUrl,
  //           productGroup: []));
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Product added to cart.'),
  //         ),
  //       );
  //     }
  //   });
  // }
  ////////////////////
  ///new add to cart
  ///
  void addToCart(ProductModel product) {
    setState(() {
      var existingProductIndex =
          cart.indexWhere((p) => p.productTitle == product.productTitle);
      if (existingProductIndex != -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product already added to cart.'),
          ),
        );
      } else {
        int limit;
        if (currentCategory == 'All') {
          limit = 4;
        } else if (currentCategory == 'Combo Package') {
          limit = 2;
        } else if (currentCategory == 'Freedom Fighter Pack') {
          limit = 5;
        } else {
          // Set a default limit or throw an error
          limit = 0;
        }

        if (cart.length >= limit) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'You can only add $limit items to the cart from the $currentCategory category.'),
            ),
          );
        } else {
          cart.add(ProductModel(
              productTitle: product.productTitle,
              productPrice: product.productPrice,
              productPosterUrl: product.productPosterUrl,
              productGroup: []));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added to cart.'),
            ),
          );
        }
      }
    });
  }

  ///
  ///
  ///
  ////
  ///
  ////////////////

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
                  var productIndex = cart.indexWhere(
                      (p) => p.productTitle == updatedProduct.productTitle);
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
                  var productIndex = cart.indexWhere(
                      (p) => p.productTitle == product.productTitle);
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

  //////////////////////////////////////
  ///Here I have to provide other List//
  //////////////////////////////////////
  final Map<String, List<String>> items = {
    'Category 1': List.generate(20, (index) => 'Item 1 $index'),
    'Category 2': List.generate(20, (index) => 'Item 2 $index'),
    'Category 3': List.generate(20, (index) => 'Item 3 $index'),
  };

  final List<String> categories = [
    'All',
    'Combo Package',
    'Freedom Fighter Pack',
  ];

  String currentCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(221, 26, 26, 26),
      // appBar: AppBar(
      //   title: Text('Grid View with Sections'),
      // ),
      body: CustomScrollView(
        slivers: [
          // SliverPersistentHeader(
          //   delegate: _SearchBarDelegate(
          //     height: 100,
          //     width: 34,
          //     child:
          //   ),

          //   pinned: true,
          // ),

          SliverAppBar(
            backgroundColor: const Color.fromARGB(221, 26, 26, 26),
            pinned: true,
            title: Row(
              children: [
                Container(
                  height: 50,
                  width: 300,
                  child: TextField(
                    onChanged: (value) => updatedList(value),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      // Reduce the vertical and horizontal padding of the search bar

                      // hoverColor: Colors.white,
                      // focusColor: Colors.white,
                      filled: true,
                      fillColor: const Color.fromARGB(255, 48, 48, 48),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          // Set the width and color of the border
                          width: 3.0,
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'I Want...',
                      hintStyle:
                          const TextStyle(fontSize: 17.0, color: Colors.white),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(8)),
                //  SizedBox(
                //   height: 50,
                //   width: 80,
                //   child: MaterialButton(
                //     onPressed: () {
                //       navigateToCart(context);
                //     },
                //     color: Colors.blue, // You can choose the color you want
                //     textColor:
                //         Colors.white, // You can choose the text color you want
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.shopping_cart),
                //         SizedBox(
                //             width: 8), // You can adjust the spacing as needed
                //         Text('Cart (${cart.length})'),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 70,
                  width: 50,
                  child: IconBadgeButton(
                    icon: Icons.shopping_cart,
                    productQuantity: cart.length,
                    onPressed: () {
                      navigateToCart(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: CarouselSlider(
                items: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/sack-rice-with-rice-plant-place-wooden-floor_1150-34313.jpg?w=1380&t=st=1714375452~exp=1714376052~hmac=bde741407701218128ac6024ff83604d85fa1ec42b9559f21a574991a3f47f0c"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/glass-jar-red-lentils-with-wooden-spoon-wooden-board_114579-62880.jpg?t=st=1714375550~exp=1714379150~hmac=0c8fa293351cc1be6a23534db997f6efbb91fb3f2c28c4d35145438167d9ddd7&w=1380"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/red-chili-peppers-wooden-table-with-other-chilis-spices_1340-24043.jpg?t=st=1714375601~exp=1714379201~hmac=6eac485d02723e13cb9774bc3fe08bd479ebb36d962fd172458aa519292e70eb&w=1380"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg?t=st=1714375656~exp=1714379256~hmac=fe40bfa950f528afc445641a9ce6e587301327c0433bc546e86e59c9f5c9c827&w=1380"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
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
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(width: 10.0),
                  ...categories.map((String category) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          currentCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.bold,
                            color: currentCategory == category
                                ? Colors.green
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
          if (currentCategory != 'All') ...[
            SliverPadding(
              padding: const EdgeInsets.only(top: 8.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  currentCategory,
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = product_display[index];

                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 230,
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(const SnackBar(
                                //         content:
                                //             Text('Gesture Detected!')));
                                showGlassBottomSheet(
                                    context: context,
                                    child: Center(
                                        child: GlassText("Hello World",
                                            fontSize: 20)));
                              },
                              child: Column(
                                children: [
                                  Card(
                                    color:
                                        const Color.fromARGB(255, 48, 48, 48),
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
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Image(
                                                      // alignment: Alignment.ce,
                                                      width: 100.0,
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          product_display[index]
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
                                                style: const TextStyle(
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
                                                "৳ "
                                                "${product_display[index].productPrice}",
                                                style: const TextStyle(
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
                                                shape: const CircleBorder(),
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
                      ),
                    ],
                  );
                },
                childCount: product_display.length,
              ),
            ),
          ] else ...[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = product_display[index];

                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 230,
                            width: 200,
                            child: GestureDetector(
                              onTap: () {
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(const SnackBar(
                                //         content:
                                //             Text('Gesture Detected!')));
                                showGlassBottomSheet(
                                    context: context,
                                    child: Center(
                                        child: GlassText("Hello World",
                                            fontSize: 20)));
                              },
                              child: Column(
                                children: [
                                  Card(
                                    color:
                                        const Color.fromARGB(255, 48, 48, 48),
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
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Image(
                                                      // alignment: Alignment.ce,
                                                      width: 100.0,
                                                      height: 100.0,
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          product_display[index]
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
                                                style: const TextStyle(
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
                                                "৳ "
                                                "${product_display[index].productPrice}",
                                                style: const TextStyle(
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
                                                shape: const CircleBorder(),
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
                      ),
                    ],
                  );
                },
                childCount: product_display.length,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// //////////////////////////////////
// //new code for  category design//
// /////////////////////////////////
// class MPage extends StatefulWidget {
//   @override
//   _MPageState createState() => _MPageState();
// }

// class _MPageState extends State<MPage> {
//   // final List<String> products = List.generate(50, (index) => 'Product $index');
//   static List<ProductModel> products = [
//     ProductModel(
//       productTitle: "Rice",
//       productPrice: 12,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/rice.png?raw=true",
//       productGroup: ["Grocery", "Grain"],
//     ),
//     ProductModel(
//         productTitle: "Lentil",
//         productPrice: 40,
//         productPosterUrl:
//             // "https://github.com/rabiulrahat/testserver/blob/main/lentil.png?raw=true",
//             "https://img.freepik.com/premium-photo/fresh-lentil-vegetables-isolated-transparent-background-ai-generated_585689-820.jpg?w=826",
//         productGroup: ["Grocery", "Grain"]),
//     ProductModel(
//       productTitle: "Wheat",
//       productPrice: 12,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/wheat.png?raw=true",
//       productGroup: ["Grocery", "Grain"],
//     ),
//     ProductModel(
//       productTitle: "Oil",
//       productPrice: 40,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/oil.png?raw=true",
//       productGroup: ["Grocery"],
//     ),
//     ProductModel(
//       productTitle: "Egg",
//       productPrice: 12,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/egg.png?raw=true",
//       productGroup: ["Grocery"],
//     ),
//     ProductModel(
//       productTitle: "Chili Powder",
//       productPrice: 30,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/chili.png?raw=true",
//       productGroup: ["Grocery"],
//     ),
//     ProductModel(
//       productTitle: "Sugar",
//       productPrice: 30,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/sugar.png?raw=true",
//       productGroup: ["Grocery"],
//     ),
//     ProductModel(
//       productTitle: "Tumeric",
//       productPrice: 20,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/tumeric.png?raw=true",
//       productGroup: ["Grocery"],
//     ),
//     ProductModel(
//       productTitle: "Salt",
//       productPrice: 20,
//       productPosterUrl:
//           "https://github.com/rabiulrahat/testserver/blob/main/salt.png?raw=true",
//       productGroup: ["grocery"],
//     ),
//   ];
//   //////////////////////////////
//   ///  //here displaying the product list and filtering
//   List<ProductModel> product_display = List.from(products);
//   void updatedList(String value) {
//     setState(() {
//       product_display = products
//           .where((element) =>
//               element.productTitle!.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   ///add to cart function
//   // void addToCart(ProductModel product) {
//   //   setState(() {
//   //     var existingProductIndex =
//   //         cart.indexWhere((p) => p.productTitle == product.productTitle);
//   //     if (existingProductIndex != -1) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Product already added to cart.'),
//   //         ),
//   //       );
//   //     } else {
//   //       cart.add(ProductModel(
//   //           productTitle: product.productTitle,
//   //           productPrice: product.productPrice,
//   //           productPosterUrl: product.productPosterUrl,
//   //           productGroup: []));
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         const SnackBar(
//   //           content: Text('Product added to cart.'),
//   //         ),
//   //       );
//   //     }
//   //   });
//   // }
//   ////////////////////
//   ///new add to cart
//   ///
//   void addToCart(ProductModel product) {
//     setState(() {
//       var existingProductIndex =
//           cart.indexWhere((p) => p.productTitle == product.productTitle);
//       if (existingProductIndex != -1) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Product already added to cart.'),
//           ),
//         );
//       } else {
//         int limit;
//         if (currentCategory == 'All') {
//           limit = 4;
//         } else if (currentCategory == 'Combo Package') {
//           limit = 2;
//         } else if (currentCategory == 'Freedom Fighter Pack') {
//           limit = 5;
//         } else {
//           // Set a default limit or throw an error
//           limit = 0;
//         }

//         if (cart.length >= limit) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                   'You can only add $limit items to the cart from the $currentCategory category.'),
//             ),
//           );
//         } else {
//           cart.add(ProductModel(
//               productTitle: product.productTitle,
//               productPrice: product.productPrice,
//               productPosterUrl: product.productPosterUrl,
//               productGroup: []));
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Product added to cart.'),
//             ),
//           );
//         }
//       }
//     });
//   }


//   ///
//   ///
//   ///
//   ////
//   ///
//   ////////////////

//   void removeFromCart(ProductModel product) {
//     setState(() {
//       cart.remove(product);
//     });
//   }

//   void navigateToProductDetails(ProductModel product) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ProductDetails(
//               product: product,
//               onProductUpdated: (updatedProduct) {
//                 setState(() {
//                   var productIndex = cart.indexWhere(
//                       (p) => p.productTitle == updatedProduct.productTitle);
//                   if (productIndex != -1) {
//                     cart[productIndex] = updatedProduct;
//                   }
//                 });
//               })),
//     );
//   }

//   void navigateToCart(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => CartScreen(
//               cart: cart,
//               removeFromCart: removeFromCart,
//               onQuantityChanged: (product, delta) {
//                 setState(() {
//                   var productIndex = cart.indexWhere(
//                       (p) => p.productTitle == product.productTitle);
//                   if (productIndex != -1) {
//                     cart[productIndex].quantity += delta;
//                     if (cart[productIndex].quantity <= 0) {
//                       cart.removeAt(productIndex);
//                     }
//                   }
//                 });
//               })),
//     );
//   }

//   //i have to fix it
//   // void groupList(String value) {
//   //   setState(() {
//   //     product_display = main_product_lists
//   //         .where((element) =>
//   //             element.productGroup!.any((productGroup) => productGroup == _productGroup))
//   //       .toList();
//   //   });
//   // }

//   //////////////////////////////////////
//   ///Here I have to provide other List//
//   //////////////////////////////////////
//   final Map<String, List<String>> items = {
//     'Category 1': List.generate(20, (index) => 'Item 1 $index'),
//     'Category 2': List.generate(20, (index) => 'Item 2 $index'),
//     'Category 3': List.generate(20, (index) => 'Item 3 $index'),
//   };

//   final List<String> categories = [
//     'All',
//     'Combo Package',
//     'Freedom Fighter Pack',
//   ];

//   String currentCategory = 'All';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(221, 26, 26, 26),
//       // appBar: AppBar(
//       //   title: Text('Grid View with Sections'),
//       // ),
//       body: CustomScrollView(
//         slivers: [
//           // SliverPersistentHeader(
//           //   delegate: _SearchBarDelegate(
//           //     height: 100,
//           //     width: 34,
//           //     child:
//           //   ),

//           //   pinned: true,
//           // ),

//           SliverAppBar(
//             backgroundColor: const Color.fromARGB(221, 26, 26, 26),
//             pinned: true,
//             title: Row(
//               children: [
//                 Container(
//                   height: 50,
//                   width: 300,
//                 child: TextField(
//                       onChanged: (value) => updatedList(value),
//                       cursorColor: Colors.white,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                             // Reduce the vertical and horizontal padding of the search bar

//                         // hoverColor: Colors.white,
//                         // focusColor: Colors.white,
//                         filled: true,
//                         fillColor: const Color.fromARGB(255, 48, 48, 48),
//                         enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           // Set the width and color of the border
//                           width: 3.0,
//                           color: Colors.grey,
//                         ),                        borderRadius: BorderRadius.circular(12),
//                         ),
//                         hintText: 'I Want...',
//                         hintStyle:
//                             const TextStyle(fontSize: 17.0, color: Colors.white),

//                       ),

//                     ),
//               ),
//               const Padding(padding: EdgeInsets.all(8)),
//                 //  SizedBox(
//                 //   height: 50,
//                 //   width: 80,
//                 //   child: MaterialButton(
//                 //     onPressed: () {
//                 //       navigateToCart(context);
//                 //     },
//                 //     color: Colors.blue, // You can choose the color you want
//                 //     textColor:
//                 //         Colors.white, // You can choose the text color you want
//                 //     child: Row(
//                 //       mainAxisAlignment: MainAxisAlignment.center,
//                 //       children: [
//                 //         Icon(Icons.shopping_cart),
//                 //         SizedBox(
//                 //             width: 8), // You can adjust the spacing as needed
//                 //         Text('Cart (${cart.length})'),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//  SizedBox(
//             height: 70,
//             width: 50,
//             child: IconBadgeButton(
//               icon: Icons.shopping_cart,
//               productQuantity: cart.length,
//               onPressed: () {
//                 navigateToCart(context);
//               },
//             ),
//           ),

//               ],
//             ),
//           ),
//           SliverToBoxAdapter(
//             child: SingleChildScrollView(
//               child: CarouselSlider(
//                 items: [
//                   Container(
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             "https://img.freepik.com/free-photo/sack-rice-with-rice-plant-place-wooden-floor_1150-34313.jpg?w=1380&t=st=1714375452~exp=1714376052~hmac=bde741407701218128ac6024ff83604d85fa1ec42b9559f21a574991a3f47f0c"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             "https://img.freepik.com/free-photo/glass-jar-red-lentils-with-wooden-spoon-wooden-board_114579-62880.jpg?t=st=1714375550~exp=1714379150~hmac=0c8fa293351cc1be6a23534db997f6efbb91fb3f2c28c4d35145438167d9ddd7&w=1380"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             "https://img.freepik.com/free-photo/red-chili-peppers-wooden-table-with-other-chilis-spices_1340-24043.jpg?t=st=1714375601~exp=1714379201~hmac=6eac485d02723e13cb9774bc3fe08bd479ebb36d962fd172458aa519292e70eb&w=1380"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             "https://img.freepik.com/free-photo/world-diabetes-day-sugar-wooden-bowl-dark-surface_1150-26666.jpg?t=st=1714375656~exp=1714379256~hmac=fe40bfa950f528afc445641a9ce6e587301327c0433bc546e86e59c9f5c9c827&w=1380"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: const DecorationImage(
//                         image: NetworkImage(
//                             "https://img.freepik.com/premium-photo/flat-lay-top-view-turmeric-curcumin-powder-wooden-bowl-spoon-with-fresh-rhizome-wood-background_252965-741.jpg?w=1380"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ],
//                 options: CarouselOptions(
//                   height: 160.0,
//                   enlargeCenterPage: true,
//                   autoPlay: true,
//                   aspectRatio: 16 / 9,
//                   autoPlayCurve: Curves.fastOutSlowIn,
//                   enableInfiniteScroll: true,
//                   autoPlayAnimationDuration: const Duration(milliseconds: 800),
//                   viewportFraction: 0.8,
//                   scrollDirection: Axis.horizontal,
//                 ),
//               ),
//             ),

//           ),
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Row(
//                 children: [

//                   SizedBox(width: 10.0),
//                   ...categories.map((String category) {
//                     return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           currentCategory = category;
//                         });
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.all(10.0),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(4.0),
//                         ),
//                         child: Text(
//                           category,
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             // fontWeight: FontWeight.bold,
//                             color: currentCategory == category
//                                 ? Colors.green
//                                 : Colors.white,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                                     SizedBox(width: 10.0),


//                 ],
//               ),
//             ),
//           ),
//           if (currentCategory != 'All') ...[
//             SliverPadding(
//               padding: const EdgeInsets.only(top: 8.0),
//               sliver: SliverToBoxAdapter(
//                 child: Text(
//                   currentCategory,
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white
//                   ),
//                 ),
//               ),
//             ),
//              SliverGrid(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1 / 1.2,
//                 mainAxisSpacing: 10.0,
//                 crossAxisSpacing: 10.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final product = product_display[index];

//                   return Column(
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 230,
//                             width: 200,
//                             child: GestureDetector(
//                               onTap: () {
//                                 // ScaffoldMessenger.of(context)
//                                 //     .showSnackBar(const SnackBar(
//                                 //         content:
//                                 //             Text('Gesture Detected!')));
//                                 showGlassBottomSheet(
//                                     context: context,
//                                     child: Center(
//                                         child: GlassText("Hello World",
//                                             fontSize: 20)));
//                               },
//                               child: Column(
//                                 children: [
//                                   Card(
//                                     color:
//                                         const Color.fromARGB(255, 48, 48, 48),
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         // SizedBox(
//                                         //   child: Image(
//                                         //       // alignment: Alignment.ce,
//                                         //       width: 80.0,
//                                         //       height: 80.0,
//                                         //       image: NetworkImage(product_display[index]
//                                         //           .productPosterUrl!)),
//                                         // ),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: NeonPoint(
//                                             pointSize: 00,
//                                             spreadColor:
//                                                 Colors.green.withOpacity(0.5),
//                                             lightSpreadRadius: 90,
//                                           ),
//                                         ),
//                                         Container(
//                                           // spreadColor: Colors.green,
//                                           // borderWidth: 0,
//                                           // borderColor: Colors.greenAccent,
//                                           // borderRadius: BorderRadius.circular(1000.90),
//                                           child:
//                                               // Image.network(
//                                               //   product_display[index].productPosterUrl!,
//                                               //   fit: BoxFit.contain,
//                                               // ),
//                                               //     CachedNetworkImage(
//                                               //   imageUrl:
//                                               //       product_display[index].productPosterUrl!,
//                                               //   placeholder: (context, url) =>
//                                               //       CircularProgressIndicator(),
//                                               //   errorWidget: (context, url, error) =>
//                                               //       Icon(Icons.error),
//                                               // ),
//                                               Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   const SizedBox(
//                                                     width: 20,
//                                                   ),
//                                                   Image(
//                                                       // alignment: Alignment.ce,
//                                                       width: 100.0,
//                                                       height: 100.0,
//                                                       fit: BoxFit.cover,
//                                                       image: NetworkImage(
//                                                           product_display[index]
//                                                               .productPosterUrl!)),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 product_display[index]
//                                                     .productTitle!,
//                                                 style: const TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 20),
//                                               ),
//                                             ],
//                                           ),
//                                         ),

//                                         Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 "৳ "
//                                                 "${product_display[index].productPrice}",
//                                                 style: const TextStyle(
//                                                     color: Colors.greenAccent,
//                                                     fontSize: 20),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Image.asset('assets/card-sample-image-2.jpg'),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.green,
//                                                 shape: const CircleBorder(),
//                                               ),
//                                               onPressed: () {
//                                                 addToCart(product);
//                                               },
//                                               child: const Icon(
//                                                 Icons.shopping_bag_outlined,
//                                                 color: Colors.white,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//                 childCount: product_display.length,
//               ),
//             ),
//           ] else ...[

//             SliverGrid(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 1 / 1.2,
//                   mainAxisSpacing : 10.0,
//                   crossAxisSpacing : 10.0,
//               ),
//               delegate: SliverChildBuilderDelegate(
//                 (BuildContext context, int index) {
//                   final product = product_display[index];

//                   return Column(
//                     children: [

//                       Row(
//                         children: [
//                           SizedBox(
//                             height: 230,
//                             width: 200,
//                             child: GestureDetector(
//                               onTap: () {
//                                 // ScaffoldMessenger.of(context)
//                                 //     .showSnackBar(const SnackBar(
//                                 //         content:
//                                 //             Text('Gesture Detected!')));
//                                 showGlassBottomSheet(
//                                     context: context,
//                                     child: Center(
//                                         child: GlassText("Hello World",
//                                             fontSize: 20)));
//                               },
//                               child: Column(
//                                 children: [
//                                   Card(
//                                     color:
//                                         const Color.fromARGB(255, 48, 48, 48),
//                                     clipBehavior: Clip.antiAlias,
//                                     child: Column(
//                                       children: [
//                                         // SizedBox(
//                                         //   child: Image(
//                                         //       // alignment: Alignment.ce,
//                                         //       width: 80.0,
//                                         //       height: 80.0,
//                                         //       image: NetworkImage(product_display[index]
//                                         //           .productPosterUrl!)),
//                                         // ),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: NeonPoint(
//                                             pointSize: 00,
//                                             spreadColor:
//                                                 Colors.green.withOpacity(0.5),
//                                             lightSpreadRadius: 90,
//                                           ),
//                                         ),
//                                         Container(
//                                           // spreadColor: Colors.green,
//                                           // borderWidth: 0,
//                                           // borderColor: Colors.greenAccent,
//                                           // borderRadius: BorderRadius.circular(1000.90),
//                                           child:
//                                               // Image.network(
//                                               //   product_display[index].productPosterUrl!,
//                                               //   fit: BoxFit.contain,
//                                               // ),
//                                               //     CachedNetworkImage(
//                                               //   imageUrl:
//                                               //       product_display[index].productPosterUrl!,
//                                               //   placeholder: (context, url) =>
//                                               //       CircularProgressIndicator(),
//                                               //   errorWidget: (context, url, error) =>
//                                               //       Icon(Icons.error),
//                                               // ),
//                                               Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   const SizedBox(
//                                                     width: 20,
//                                                   ),
//                                                   Image(
//                                                       // alignment: Alignment.ce,
//                                                       width: 100.0,
//                                                       height: 100.0,
//                                                       fit: BoxFit.cover,
//                                                       image: NetworkImage(
//                                                           product_display[index]
//                                                               .productPosterUrl!)),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 product_display[index]
//                                                     .productTitle!,
//                                                 style: const TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 20),
//                                               ),
//                                             ],
//                                           ),
//                                         ),

//                                         Padding(
//                                           padding: const EdgeInsets.all(3.0),
//                                           child: Row(
//                                             children: [
//                                               Text(
//                                                 "৳ "
//                                                 "${product_display[index].productPrice}",
//                                                 style: const TextStyle(
//                                                     color: Colors.greenAccent,
//                                                     fontSize: 20),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Image.asset('assets/card-sample-image-2.jpg'),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             ElevatedButton(
//                                               style: ElevatedButton.styleFrom(
//                                                 backgroundColor: Colors.green,
//                                                 shape: const CircleBorder(),
//                                               ),
//                                               onPressed: () {
//                                                 addToCart(product);
//                                               },
//                                               child: const Icon(
//                                                 Icons.shopping_bag_outlined,
//                                                 color: Colors.white,
//                                                 size: 20,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   );
//                 },
//                 childCount: product_display.length,
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final double width;
  final Widget child;

  _SearchBarDelegate(
      {required this.height, required this.width, required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: height,
      width: width,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.width != width ||
        oldDelegate.child != child;
  }
}

/////////////////////////////////////////
//////
class IconBadgeButton extends StatelessWidget {
  final IconData icon;
  final int productQuantity;
  final VoidCallback onPressed;

  const IconBadgeButton({
    required this.icon,
    required this.productQuantity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Icon
          Icon(
            icon,
            size: 28,
            color: Colors.white,
          ),

          // Glossy effect
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(24),
          //   child: BackdropFilter(
          //     // filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //     filter: null,
          //     child: Container(
          //       width: 48,
          //       height: 48,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(24),
          //         // color: Colors.white.withOpacity(0.1),
          //       ),
          //     ),
          //   ),
          // ),

          // Product quantity
          if (productQuantity > 0)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Center(
                  child: Text(
                    productQuantity.toString(),
                    style: TextStyle(
                      color: const Color.fromARGB(255, 55, 55, 55),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
////
////////////////////////////////////////////
// class MPage extends StatefulWidget {
//   MPage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MPageState createState() => _MPageState();
// }

// class _MPageState extends State<MPage> {
//   int _selectedIndex = -1;
//   List<String> _timeSlots = [
//     "9:00 - 10:00",
//     "10:00 - 11:00",
//     // ... add more time slots
//   ];

//   // Maximum capacity for each time slot
//   int _maxCapacity = 10;

//   // Current number of people for each time slot
//   List<int> _currentPeople = [0, 0];

//   void _selectTile(int index) {
//     if (_currentPeople[index] < _maxCapacity) {
//       // Only allow selection if the time slot is not full
//       setState(() {
//         if (_selectedIndex == index) {
//           _currentPeople[index]--;
//           _selectedIndex = -1;
//         } else {
//           if (_selectedIndex != -1) {
//             _currentPeople[_selectedIndex]--;
//           }
//           _currentPeople[index]++;
//           _selectedIndex = index;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         children: List.generate(_timeSlots.length, (index) {
//           return InkWell(
//             onTap: () => _selectTile(index),
//             child: Container(
//               color: _selectedIndex == index
//                   ? Colors.blue
//                   : (_currentPeople[index] >= _maxCapacity
//                       ? Colors.grey
//                       : Colors.white),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(_timeSlots[index], style: TextStyle(fontSize: 20)),
//                     Text('${_currentPeople[index]} / $_maxCapacity',
//                         style: TextStyle(fontSize: 16)),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class MPage extends StatefulWidget {
//   MPage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MPageState createState() => _MPageState();
// }

// class _MPageState extends State<MPage> {
//   int _selectedIndex = -1;
//   bool _isEditing = true;
//   List<String> _timeSlots = [
//     "9:00 - 10:00",
//     "10:00 - 11:00",
//     // ... add more time slots
//   ];

//   // Maximum capacity for each time slot
//   int _maxCapacity = 10;

//   // Current number of people for each time slot
//   List<int> _currentPeople = [0, 0];

//   void _selectTile(int index) {
//     if (_isEditing && _currentPeople[index] < _maxCapacity) {
//       // Only allow selection if editing is enabled and the time slot is not full
//       setState(() {
//         if (_selectedIndex == index) {
//           _currentPeople[index]--;
//           _selectedIndex = -1;
//         } else {
//           if (_selectedIndex != -1) {
//             _currentPeople[_selectedIndex]--;
//           }
//           _currentPeople[index]++;
//           _selectedIndex = index;
//         }
//       });
//     }
//   }

//   void _confirmSelection() {
//     setState(() {
//       _isEditing = false;
//     });
//   }

//   void _enableEditing() {
//     setState(() {
//       _isEditing = true;
//       _currentPeople[_selectedIndex]--;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Column(children: [
//           if (_selectedIndex != -1)
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 if (_isEditing)
//                   ElevatedButton(
//                     onPressed: _confirmSelection,
//                     child: Text('Confirm'),
//                   ),
//                 if (!_isEditing)
//                   ElevatedButton(
//                     onPressed: _enableEditing,
//                     child: Text('Re-edit'),
//                   ),
//               ],
//             ),
//           Expanded(
//               child: GridView.count(
//                   crossAxisCount: 2,
//                   children: List.generate(_timeSlots.length, (index) {
//                     return InkWell(
//                         onTap: () => _selectTile(index),
//                         child: Container(
//                             color: _selectedIndex == index
//                                 ? Colors.blue
//                                 : (_currentPeople[index] >= _maxCapacity
//                                     ? Colors.grey
//                                     : Colors.white),
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(_timeSlots[index],
//                                       style: TextStyle(fontSize: 20)),
//                                   Text(
//                                       '${_currentPeople[index]}/ $_maxCapacity}',
//                                       style: TextStyle(fontSize: 16))
//                                 ],
//                               ),
//                             )));
//                   })))
//         ]));
//   }
// }
