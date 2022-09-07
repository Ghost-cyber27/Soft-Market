import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.desc,
    required this.file,
  });

  String id;
  String name;
  int price;
  String image;
  String category;
  String desc;
  String file;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["Name"],
        price: json["Price"],
        image: json["Image"],
        category: json["Category"],
        desc: json["Desc"],
        file: json["File"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "Price": price,
        "Image": image,
        "Category": category,
        "Desc": desc,
        "File": file,
      };
}
