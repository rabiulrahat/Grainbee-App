import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sodai_app/model/product_model.dart';
import 'package:glassmorphism_widgets/glassmorphism_widgets.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  final List<ProductModel> cart;
  final Function(ProductModel) removeFromCart;
  final Function(ProductModel, int) onQuantityChanged;

  CartScreen({
    Key? key,
    required this.cart,
    required this.removeFromCart,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _addressController = TextEditingController();
  String _deliveryAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Editable delivery address field
            TextFormField(
              controller: _addressController,
              onChanged: (value) {
                setState(() {
                  _deliveryAddress = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Delivery Address',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  final product = widget.cart[index];
                  return ListTile(
                    title: Text(
                      product.productTitle.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\$${(product.productPrice! * product.quantity).toString()}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.onQuantityChanged(product, -1);
                                });
                              },
                              icon: Icon(Icons.remove),
                              color: Colors.white,
                            ),
                            Text(
                              product.quantity.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.onQuantityChanged(product, 1);
                                });
                              },
                              icon: Icon(Icons.add),
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                widget.removeFromCart(product);
                                setState(() {}); // Trigger a rebuild
                              },
                              icon: Icon(Icons.delete),
                              color: Colors.white,
                            ),
                          ],
                        ),
                         Row(
                          children: [
                            Expanded(
                              child: GlassContainer(
                                width: double.infinity,
                                height: 56,
                                // borderRadius: 8.0,
                                blur: 10,
                                border: 2,
                                linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF0099FF).withOpacity(0.1),
                                    Color(0xFF0099FF).withOpacity(0.05),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(
                                          deliveryAddress: _deliveryAddress,
                                          cart: widget.cart,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text('Pay with Bkash'),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.transparent,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32.0, vertical: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Bkash payment option with glassy effect

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  final Function(ProductModel) onProductUpdated;

  const ProductDetails({
    Key? key,
    required this.product,
    required this.onProductUpdated,
  }) : super(key: key);

  void increaseQuantity() {
    onProductUpdated(ProductModel(
        productTitle: product.productTitle,
        productPrice: product.productPrice,
        quantity: product.quantity + 1, productGroup: [], productPosterUrl: ''));
  }

  void decreaseQuantity() {
    if (product.quantity > 1) {
      onProductUpdated(ProductModel(
          productTitle: product.productTitle,
          productPrice: product.productPrice,
          quantity: product.quantity - 1, productPosterUrl: '', productGroup: []));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productTitle.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('\$${product.productPrice.toString()}'),
            Row(
              children: [
                IconButton(
                  onPressed: increaseQuantity,
                  icon: Icon(Icons.add),
                ),
                Text(product.quantity.toString()),
                IconButton(
                  onPressed: decreaseQuantity,
                  icon: Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentPage extends StatefulWidget {
  final String deliveryAddress;
  final List<ProductModel> cart;

  PaymentPage({
    Key? key,
    required this.deliveryAddress,
    required this.cart,
  }) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _phoneController = TextEditingController();
  bool _isPaymentSuccess = false;

  DateTime generateRandomDate({int range = 7}) {
    final now = DateTime.now();
    final random = Random();
    final daysFromNow = random.nextInt(range) + 1;
    return now.add(Duration(days: daysFromNow));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery address display
            Text(
              'Delivery Address:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.deliveryAddress),
            SizedBox(height: 16.0),
            // Phone number input field
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Phone Number (for MFS payment)',
              ),
            ),
            SizedBox(height: 16.0),
            // Payment button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement MFS payment logic here

                // For now, simulate a successful payment
                setState(() {
                  _isPaymentSuccess = true;
                });
              },
              child: Text('Proceed to Payment'),
            ),
            if (_isPaymentSuccess) ...[
              SizedBox(height: 32.0),
              // Payment success message
              Text(
                'Payment Successful!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              // Order details display
              Text(
                'Your Order:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...widget.cart
                  .map((product) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.productTitle.toString()),
                          Text(
                              '\$${(product.productPrice! * product.quantity).toString()}'),
                          SizedBox(height: 8.0),
                        ],
                      ))
                  .toList(),
              SizedBox(height: 16.0),
              // Order and delivery date display
              Text(
                'Order will be delivered by:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('dd-MM-yyyy').format(
                    generateRandomDate()), // Generate a random delivery date
              ),
            ],
          ],
        ),
      ),
    );
  }
}
