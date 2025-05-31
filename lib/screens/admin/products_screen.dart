import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';
import '../../models/product.dart';
import '../../models/category.dart';
import '../../services/data_service.dart';
import '../../services/storage_service.dart';
import '../../config/appwrite_config.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final DataService _dataService = DataService();
  final StorageService _storageService = StorageService();
  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: FutureBuilder<List<Document>>(
              future: _selectedCategoryId != null
                  ? _dataService.queryCollection(
                      AppwriteConfig.productsCollection,
                      whereConditions: [
                        ['category_id', _selectedCategoryId]
                      ],
                    )
                  : _dataService
                      .getCollection(AppwriteConfig.productsCollection),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final products = snapshot.data!.map((doc) {
                  return Product.fromDocument(doc.data, doc.$id);
                }).toList();

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      leading: product.images.isNotEmpty
                          ? Image.network(
                              product.images.first,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.inventory),
                      title: Text(product.name),
                      subtitle: Text(
                          '${product.description}\nPrice: \$${product.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              product.isAvailable
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () => _toggleAvailability(product),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteProduct(product.id),
                          ),
                        ],
                      ),
                      onTap: () => _editProduct(product),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return FutureBuilder<List<Document>>(
      future: _dataService.getCollection(AppwriteConfig.categoriesCollection),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final categories = snapshot.data!.map((doc) {
          return Category.fromDocument(doc.data, doc.$id);
        }).toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: _selectedCategoryId,
            hint: const Text('Filter by Category'),
            isExpanded: true,
            items: [
              const DropdownMenuItem<String>(
                value: null,
                child: Text('All Categories'),
              ),
              ...categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Text(category.name),
                );
              }),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCategoryId = value;
              });
            },
          ),
        );
      },
    );
  }

  Future<void> _addProduct() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const ProductDialog(),
    );

    if (result != null) {
      await _dataService.addDocument(AppwriteConfig.productsCollection, result);
    }
  }

  Future<void> _editProduct(Product product) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ProductDialog(product: product),
    );

    if (result != null) {
      await _dataService.updateDocument(
        AppwriteConfig.productsCollection,
        product.id,
        result,
      );
    }
  }

  Future<void> _deleteProduct(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
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
      await _dataService.deleteDocument(AppwriteConfig.productsCollection, id);
    }
  }

  Future<void> _toggleAvailability(Product product) async {
    await _dataService.updateDocument(
      AppwriteConfig.productsCollection,
      product.id,
      {'is_available': !product.isAvailable},
    );
  }
}

class ProductDialog extends StatefulWidget {
  final Product? product;

  const ProductDialog({super.key, this.product});

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String? _selectedCategoryId;
  List<String> _imageUrls = [];
  final Map<String, TextEditingController> _specControllers = {};
  final StorageService _storageService = StorageService();
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = widget.product!.price.toString();
      _selectedCategoryId = widget.product!.categoryId;
      _imageUrls = List.from(widget.product!.images);
      widget.product!.specifications.forEach((key, value) {
        _specControllers[key] = TextEditingController(text: value.toString());
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _specControllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCategoryDropdown(),
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
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildImageSection(),
              const SizedBox(height: 16),
              _buildSpecificationsSection(),
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

  Widget _buildCategoryDropdown() {
    return FutureBuilder<List<Document>>(
      future: _dataService.getCollection(AppwriteConfig.categoriesCollection),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final categories = snapshot.data!.map((doc) {
          return Category.fromDocument(doc.data, doc.$id);
        }).toList();

        return DropdownButtonFormField<String>(
          value: _selectedCategoryId,
          decoration: const InputDecoration(labelText: 'Category'),
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category.id,
              child: Text(category.name),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategoryId = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a category';
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Images'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._imageUrls.map(
              (url) => Stack(
                children: [
                  Image.network(
                    url,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          _imageUrls.remove(url);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Icon(Icons.add_photo_alternate),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Specifications'),
        const SizedBox(height: 8),
        ..._specControllers.entries.map(
          (entry) => Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: entry.value,
                  decoration: InputDecoration(labelText: entry.key),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _specControllers.remove(entry.key);
                  });
                },
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: _addSpecification,
          child: const Text('Add Specification'),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    final imageUrl = await _storageService.pickAndUploadImage('products');
    if (imageUrl != null) {
      setState(() {
        _imageUrls.add(imageUrl);
      });
    }
  }

  void _addSpecification() {
    showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _SpecificationDialog(),
    ).then((result) {
      if (result != null) {
        setState(() {
          _specControllers[result['key']!] =
              TextEditingController(text: result['value']);
        });
      }
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final specifications = <String, String>{};
      _specControllers.forEach((key, controller) {
        specifications[key] = controller.text;
      });

      Navigator.pop(context, {
        'category_id': _selectedCategoryId,
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'images': _imageUrls,
        'specifications': specifications,
        'is_available': widget.product?.isAvailable ?? true,
        'search_keywords': [_nameController.text.toLowerCase()],
      });
    }
  }
}

class _SpecificationDialog extends StatelessWidget {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  _SpecificationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Specification'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _keyController,
            decoration: const InputDecoration(labelText: 'Key'),
          ),
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(labelText: 'Value'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_keyController.text.isNotEmpty) {
              Navigator.pop(context, {
                'key': _keyController.text,
                'value': _valueController.text,
              });
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
