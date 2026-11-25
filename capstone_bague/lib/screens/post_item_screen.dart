import 'dart:io';

import 'package:flutter/material.dart';
import 'package:capstone_bague/models/item.dart';
import 'package:image_picker/image_picker.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  ItemType _type = ItemType.lost;
  ItemCategory _category = ItemCategory.other;

  final _picker = ImagePicker();
  String? _imagePath;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 1280,
        imageQuality: 80,
      );
      if (file != null && mounted) {
        setState(() => _imagePath = file.path);
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the camera or gallery.')),
      );
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take a photo'),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from gallery'),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickImage(ImageSource.gallery);
              },
            ),
            if (_imagePath != null)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('Remove photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  setState(() => _imagePath = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoPicker() {
    final scheme = Theme.of(context).colorScheme;
    final path = _imagePath;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: scheme.surfaceContainerHighest,
        child: InkWell(
          onTap: _showPhotoOptions,
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: path == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo, size: 40),
                      SizedBox(height: 8),
                      Text('Add a photo (optional)'),
                    ],
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(File(path), fit: BoxFit.cover),
                      const Positioned(
                        right: 8,
                        bottom: 8,
                        child: CircleAvatar(
                          radius: 18,
                          child: Icon(Icons.edit, size: 18),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  String? _required(String? value) =>
      (value == null || value.trim().isEmpty) ? 'Required' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final item = Item(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      type: _type,
      category: _category,
      location: _locationController.text.trim(),
      date: DateTime.now(),
      contactName: _nameController.text.trim(),
      contactInfo: _contactController.text.trim(),
      imagePath: _imagePath,
    );
    Navigator.pop(context, item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post an item')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<ItemType>(
              segments: const [
                ButtonSegment(
                  value: ItemType.lost,
                  label: Text('I lost something'),
                  icon: Icon(Icons.search),
                ),
                ButtonSegment(
                  value: ItemType.found,
                  label: Text('I found something'),
                  icon: Icon(Icons.pan_tool),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 16),
            _buildPhotoPicker(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Item name',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ItemCategory>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: ItemCategory.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.label)))
                  .toList(),
              onChanged: (c) => setState(() => _category = c ?? _category),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Where (lost / found)',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your name',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _contactController,
              decoration: const InputDecoration(
                labelText: 'Contact info (phone or email)',
                border: OutlineInputBorder(),
              ),
              validator: _required,
            ),
            const SizedBox(height: 24),
            FilledButton(onPressed: _submit, child: const Text('Post')),
          ],
        ),
      ),
    );
  }
}
