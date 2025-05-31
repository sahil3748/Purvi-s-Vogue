import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';
import '../../models/category.dart';
import '../../services/data_service.dart';
import '../../services/storage_service.dart';
import '../../config/appwrite_config.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final DataService _dataService = DataService();
  final StorageService _storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Categories'),
      ),
      body: FutureBuilder<List<Document>>(
        future: _dataService.getCollection(AppwriteConfig.categoriesCollection),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final categories = snapshot.data!.map((doc) {
            return Category.fromDocument(doc.data, doc.$id);
          }).toList();

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                leading: category.imageUrl.isNotEmpty
                    ? Image.network(
                        category.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.category),
                title: Text(category.name),
                subtitle: Text(category.description),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteCategory(category.id),
                ),
                onTap: () => _editCategory(category),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addCategory() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const CategoryDialog(),
    );

    if (result != null) {
      await _dataService.addDocument(
          AppwriteConfig.categoriesCollection, result);
    }
  }

  Future<void> _editCategory(Category category) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => CategoryDialog(category: category),
    );

    if (result != null) {
      await _dataService.updateDocument(
        AppwriteConfig.categoriesCollection,
        category.id,
        result,
      );
    }
  }

  Future<void> _deleteCategory(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Category'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _dataService.deleteDocument(
          AppwriteConfig.categoriesCollection, id);
    }
  }
}

class CategoryDialog extends StatefulWidget {
  final Category? category;

  const CategoryDialog({super.key, this.category});

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imageUrl;
  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _descriptionController.text = widget.category!.description;
      _imageUrl = widget.category!.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.category == null ? 'Add Category' : 'Edit Category'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              if (_imageUrl != null)
                Image.network(
                  _imageUrl!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _submit,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final imageUrl = await _storageService.pickAndUploadImage('categories');
    if (imageUrl != null) {
      setState(() {
        _imageUrl = imageUrl;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      Navigator.pop(context, {
        'name': _nameController.text,
        'type': 'default',
        'description': _descriptionController.text,
        'image_url': _imageUrl ?? '',
        'is_active': true,
        'display_order': 0,
        'search_keywords': [_nameController.text.toLowerCase()],
      });
    }
  }
}
