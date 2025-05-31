// This is a template file showing how to structure your dummy data
// You can provide your actual data following this format

// Category Template
final List<Map<String, dynamic>> dummyCategoriesTemplate = [
  {
    'id': 'cat1', // Unique identifier for the category
    'name': 'Women\'s Clothing',
    'description': 'All women\'s clothing items',
    'imageUrl':
        'https://example.com/category-image.jpg', // URL for category image
  },
  // Add more categories in the same format
];

// Product Template
final List<Map<String, dynamic>> dummyProductsTemplate = [
  {
    'id': 'prod1', // Unique identifier for the product
    'categoryId': 'cat1', // Reference to the category this product belongs to
    'name': 'Floral Summer Dress',
    'description':
        'Beautiful floral print summer dress perfect for casual wear',
    'price': 59.99,
    'discountPrice': 49.99, // Optional: Include if product is on sale
    'images': [
      'https://example.com/dress-image1.jpg',
      'https://example.com/dress-image2.jpg',
    ],
    'sizes': ['XS', 'S', 'M', 'L', 'XL'],
    'colors': ['Red', 'Blue', 'Black'],
    'inStock': true,
    'stockQuantity': 50,
    'tags': ['summer', 'dress', 'floral'],
    'specifications': {
      'material': 'Cotton',
      'care': 'Machine wash cold',
      'style': 'Casual',
    }
  },
  // Add more products in the same format
];

/*
HOW TO PROVIDE YOUR DATA:

1. For Categories:
   - Create a list of categories
   - Each category should have: id, name, description, and imageUrl
   - Make sure each category has a unique id

2. For Products:
   - Create a list of products
   - Each product should have all the fields shown in the template above
   - Make sure to:
     * Use unique product IDs
     * Reference valid category IDs
     * Provide real image URLs
     * Include accurate pricing
     * List available sizes and colors
     * Add relevant tags and specifications

3. You can provide your data in a similar format:

final actualCategories = [
  {
    'id': 'your-category-id',
    'name': 'Your Category Name',
    // ... other fields
  },
];

final actualProducts = [
  {
    'id': 'your-product-id',
    'name': 'Your Product Name',
    // ... other fields
  },
];
*/
