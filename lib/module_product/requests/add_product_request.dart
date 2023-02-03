class AddProductRequest {
  late int id;
  late String name;
  late double price;
  late String description;
  late String image;

  AddProductRequest(
      {required this.name,
      required this.image,
      required this.description,
      required this.price});

  Map<String, dynamic>? toJson() {
    Map<String, dynamic> map = {};
    map['name'] = this.name;
    map['price'] = this.price;
    map['description'] = this.description;
    map['image'] = this.image;
    return map;
  }
}
