import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soft_market/constants.dart';
import 'package:soft_market/payment/paystackpayment.dart';

import '../../model/product.dart';

class Details extends StatefulWidget {
  final String productId;
  final String productName;
  final int productPrice;
  final String productCategory;
  final String productDesc;
  final String productImg;
  final String productFile;
  // ignore: use_key_in_widget_constructors
  const Details(
      {required this.productId,
      required this.productName,
      required this.productPrice,
      required this.productCategory,
      required this.productDesc,
      required this.productImg,
      required this.productFile});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.10,
                      left: kDefaultPaddin,
                      right: kDefaultPaddin),
                  //height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.productDesc,
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RawMaterialButton(
                        constraints: BoxConstraints.tight(const Size(350, 66)),
                        fillColor: Colors.blue,
                        elevation: 0.0,
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: () {
                          MakePayment(
                                  context: context,
                                  price: widget.productPrice,
                                  file: widget.productFile,
                                  email: "ilekwotryy@gmail.com")
                              .chargeCardandMakePayment(widget.productFile);
                        },
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.productName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Category: ${widget.productCategory}',
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: kDefaultPaddin,
                        ),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Price: \$${widget.productPrice}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold))
                            ])),
                            const SizedBox(
                              width: kDefaultPaddin,
                            ),
                            Expanded(
                              child: Image.network(
                                widget.productImg,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        )
                      ]),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}
