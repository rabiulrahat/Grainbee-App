class ProductModel {
  String? productTitle;
  int? productPrice;
  String? productPosterUrl;
  final List<String> productGroup;


  ProductModel({
    required this.productTitle,
    required this.productPrice,
    required this.productPosterUrl,
    required this.productGroup,
  });
}
