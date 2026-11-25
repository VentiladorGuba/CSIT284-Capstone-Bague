import 'package:capstone_bague/models/dummy_items.dart';
import 'package:capstone_bague/models/item.dart';
import 'package:flutter/material.dart';

enum FeedFilter { all, lost, found }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = buildDummyItems();
  FeedFilter _filter = FeedFilter.all;

  List<Item> get _visibleItems {
    final filtered = _items.where((item) {
      switch (_filter) {
        case FeedFilter.all:
          return true;
        case FeedFilter.lost:
          return item.type == ItemType.lost;
        case FeedFilter.found:
          return item.type == ItemType.found;
      }
    }).toList();

    // Newest first.
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final items = _visibleItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Lost & Found Board')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<FeedFilter>(
                segments: const [
                  ButtonSegment(value: FeedFilter.all, label: Text('All')),
                  ButtonSegment(value: FeedFilter.lost, label: Text('Lost')),
                  ButtonSegment(value: FeedFilter.found, label: Text('Found')),
                ],
                selected: {_filter},
                onSelectionChanged: (selection) =>
                    setState(() => _filter = selection.first),
              ),
            ),
          ),
          Expanded(
            child: items.isEmpty?
            const Center(child: Text('Nothing here yet...')):
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                final item = items[index];
                return ItemCard(context);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openPostScreen,
        icon: const Icon(Icons.add_outlined),
        label: const Text('Post item'),
        ),
    );
  }
}
