import 'item.dart';

List<Item> buildDummyItems(){
  final now =DateTime.now();

  return[
    Item(
      id: '1',
      title: 'Black Wireless Earbuds',
      description: 'Vention brand with scratch on the lid',
      type: ItemType.lost,
      category: ItemCategory.electronic,
      location: 'Library, Computer Terminal',
      date: now.subtract(const Duration(days: 1)),
      contactName: 'Judas Amats',
      contactInfo: '0923-123-4567',
    ),
  ];
}