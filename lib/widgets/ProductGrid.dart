import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/products_provider.dart';
import './ProductItem.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<Products>(context);
    final products = productList.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) => ProductItem(
        products[index].id,
        products[index].title,
        products[index].imageUrl,
      ),
      itemCount: products.length,
      padding: const EdgeInsets.all(10.0),
    );
  }
}
