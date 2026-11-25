import 'package:flutter/material.dart';

enum ItemType {lost, found}

enum ItemCategory {electronic, book, clothing, accessory, id, other}

extension Item_Category on ItemCategory {
  String get label {
    switch (this) {
      case ItemCategory.electronic:
      return 'Electronic';

      case ItemCategory.book:
      return 'Book';

      case ItemCategory.clothing:
      return 'Clothing';

      case ItemCategory.accessory:
      return 'Accessory';

      case ItemCategory.id:
      return 'ID and Card';

      case ItemCategory.other:
      return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case ItemCategory.electronic:
        return Icons.headset_outlined;
      
      case ItemCategory.book:
        return Icons.menu_book_outlined;

      case ItemCategory.clothing:
        return Icons.checkroom_outlined;

      case ItemCategory.accessory:
        return Icons.watch_outlined;

      case ItemCategory.id:
        return Icons.badge_outlined;

      case ItemCategory.other:
        return Icons.inventory_2_outlined;
    }
  }
}

class Item{
  final String id;
  final String title;
  final String description;
  final ItemType type;
  final ItemCategory category;
  final String location;
  final DateTime date;
  final String contactName;
  final String contactInfo;

  final String? imagePath;
  bool claimed;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    required this.location,
    required this.date,
    required this.contactName,
    required this.contactInfo,
    this.imagePath,
    this.claimed = false,
  });
}