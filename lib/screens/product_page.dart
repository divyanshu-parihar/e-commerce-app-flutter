import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String id;

  ProductPage({this.id});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(snapshot.error),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List imagesList = documentData['images'];
                print(imagesList);
                return ListView(
                  children: [
                    Container(
                      height: 400,
                      child: PageView(
                        children: [
                          for (int i; i < imagesList.length; i++)
                            Container(
                              child: Image.network(
                                '${imagesList[i]}',
                                fit: BoxFit.cover,
                              ),
                            )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        documentData['name'] ?? 'Product Name',
                        style: Constants.boldHeading,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        '\$${documentData['price'].toString()}' ?? 'Price',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(documentData['description'] ?? 'Description',
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 24.0,
                      ),
                      child: Text(
                        'Select Size',
                        style: Constants.regularDarkText,
                      ),
                    ),
                  ],
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            future: _products.doc(widget.id).get()),
        CustomAppBar(
          hasTitle: false,
          hasBackArrow: true,
          hasBackground: false,
        ),
      ],
    ));
  }
}
