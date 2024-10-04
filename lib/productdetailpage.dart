import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final dynamic product;

  const ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['thumbnail']),
            SizedBox(height: 16),
            Text(
              product['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product['price']}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              product['description'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
