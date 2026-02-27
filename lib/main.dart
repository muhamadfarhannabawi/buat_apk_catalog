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