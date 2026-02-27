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