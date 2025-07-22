import 'package:flutter/material.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({super.key});

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Product 1",
      "price": "10",
      "image": "images/img.png",
    },
    {
      "name": "Product 2",
      "price": "20",
      "image": "images/img.png",
    },
    {
      "name": "Product 3",
      "price": "30",
      "image": "images/img.png",
    },
    {
      "name": "Product 4",
      "price": "40",
      "image": "images/img.png",
    },
    {
      "name": "Product 5",
      "price": "50",
      "image": "images/img.png",
    },
    {
      "name": "Product 6",
      "price": "60",
      "image": "images/img.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      products[index]["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    products[index]["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "\$${products[index]["price"]}",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
