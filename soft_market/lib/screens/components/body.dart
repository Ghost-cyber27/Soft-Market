import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soft_market/constants.dart';
import 'package:soft_market/screens/details/details_page.dart';

import '../../model/product.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> softitems = [];
  @override
  void initState() {
    fetchRecords();
    super.initState();
  }

  fetchRecords() async {
    var record = await FirebaseFirestore.instance.collection("Products").get();
    mapRecord(record);
  }

  mapRecord(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map((product) => Product(
            id: product.id,
            name: product['Name'],
            price: product['Price'],
            image: product['Image'],
            category: product['Category'],
            desc: product['Desc'],
            file: product['File']))
        .toList();

    setState(() {
      softitems = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: softitems.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => Details(
                            productId: softitems[index].id,
                            productCategory: softitems[index].category,
                            productDesc: softitems[index].desc,
                            productName: softitems[index].name,
                            productPrice: softitems[index].price,
                            productImg: softitems[index].image,
                            productFile: softitems[index].file,
                          ))));
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(kDefaultPaddin),
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Image.network(softitems[index].image),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(softitems[index].name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          );
        }));
  }
}
