import 'package:flutter/material.dart';
import 'package:capstone_bague/models/item.dart';
import 'package:capstone_bague/widgets/item_image.dart';

class ItemDetailScreen extends StatelessWidget{
  final Item item;
  const ItemDetailScreen({super.key, required this.item});

  String _formatDate(DateTime d){
    const month = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${month[d.month-1]} ${d.day}, ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Item Detail')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children:[
          ItemImage(
            item: item,
            width: double.infinity,
            height: 240,
            iconSize: 80,
            radius: 16,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text(item.title, style: textTheme.bodyLarge),
              )//
            ],
          ),//
        ]
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          SizedBox(width: 80, child: Text(label)),
          Expanded(
            child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
