class ProductModel {
  String? productTitle;
  int? productPrice;
  String? productPosterUrl;
  final List<String> productGroup;

  int quantity;

  final String status; // Add this line

  ProductModel({
    required this.productTitle,
    required this.productPrice,
    required this.productPosterUrl,
    required this.productGroup, this.quantity = 1,
       this.status = 'In Stock', // Add this line and set a default value if needed

  });
}
