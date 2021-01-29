import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/screens/product_page.dart';
import 'package:e_commerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: _productsRef.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}'),
                ),
              );
            }
            // collection data ready to display
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            id: document.id,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 354,
                      width: 354,
                      margin: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            height: 350,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                document.data()['images'][0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    document.data()['name'] ?? 'Product Name',
                                    style: Constants.regularHeading,
                                  ),
                                  Text(
                                    '\$${document.data()['price'].toString()}' ??
                                        'Price',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        CustomAppBar(
          text: 'Home',
          hasTitle: true,
        ),
      ],
    );
  }
}
