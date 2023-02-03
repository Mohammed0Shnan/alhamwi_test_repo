
class ProductModel{
  late int id ;
  late String name;
  late double price;
  late String description;
  late String image;
  ProductModel({required this.id, required this.name , required this.price,required this.description, required this.image });


  ProductModel.fromMap(Map<String, dynamic> item):
        id=item["id"],
        name= item["name"],
        price= item["price"],
        description= item["description"],
        image= item["image"];

  Map<String, Object> toMap(){
    return {'id':id,
      'name': name,
      'price':price,
      'description':description,
      'image':image,
    };
  }
}



