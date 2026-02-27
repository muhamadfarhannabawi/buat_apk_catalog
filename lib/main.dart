import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: const MyApp(),
    ),
  );
}

//// 1. STATE MODEL (BUSINESS LOGIC) ----
class CartModel extends ChangeNotifier {
  final List<String> _items = [];

  UnmodifiableListView<String> get items =>
      UnmodifiableListView(_items);

       int get totalItems => _items.length;

  bool contains(String item) => _items.contains(item);

  void add(String itemName) {
    if (!_items.contains(itemName)) {
      _items.add(itemName);
      notifyListeners();
    }
  }

   void remove(String itemName) {
    _items.remove(itemName);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

//// 2. UI LAYER ----
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCatalog(),
    );
  }
}

//// 3. HALAMAN KATALOG ----
class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  final List<String> products = const [
    'Nasi Goreng',
    'Sate Ayam',
    'Es Teh',
    'Ayam Bakar',
    'Kopi',
  ];

   @override
  Widget build(BuildContext context) {
    final totalItems =
        context.select<CartModel, int>((cart) => cart.totalItems);

        return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Makanan'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyCart(),
                    ),
                  );
                },
              ),
               if (totalItems > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      totalItems.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                       ),
                  ),
                ),
            ],
          )
        ],
      ),
       body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index]),
            trailing: AddButton(item: products[index]),
          );
        },
      ),
    );
  }
}

//// 4. WIDGET TOMBOL TAMBAH ----
class AddButton extends StatelessWidget {
  final String item;

  const AddButton({required this.item, super.key});

   @override
  Widget build(BuildContext context) {
    final isInCart =
        context.select<CartModel, bool>((cart) => cart.contains(item));