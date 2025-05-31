// Dummy data for initial Firebase population

final List<Map<String, dynamic>> dummyCategories = [
  {
    'id': 'cat1',
    'name': 'Traditional Wear',
    'description': 'Elegant traditional Indian wear for all occasions',
    'imageUrl': 'https://images.unsplash.com/photo-1583391733956-6c78276477e2',
  },
  {
    'id': 'cat2',
    'name': 'Western Wear',
    'description': 'Modern western clothing for contemporary style',
    'imageUrl': 'https://images.unsplash.com/photo-1539109136881-3be0616acf4b',
  },
  {
    'id': 'cat3',
    'name': 'Accessories',
    'description': 'Beautiful accessories to complement your outfit',
    'imageUrl': 'https://images.unsplash.com/photo-1601121141461-9d6647bca1ed',
  },
  {
    'id': 'cat4',
    'name': 'Footwear',
    'description': 'Stylish footwear for every occasion',
    'imageUrl': 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2',
  },
  {
    'id': 'cat5',
    'name': 'Jewelry',
    'description': 'Exquisite jewelry pieces for all occasions',
    'imageUrl': 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338',
  }
];

final List<Map<String, dynamic>> dummyProducts = [
  // Traditional Wear Products
  {
    'id': 'prod1',
    'categoryId': 'cat1',
    'name': 'Embroidered Silk Saree',
    'description': 'Beautiful hand-embroidered silk saree with zari work',
    'price': 15999.99,
    'discountPrice': 13999.99,
    'images': [
      'https://images.unsplash.com/photo-1610189025358-14c50ae4777f',
      'https://images.unsplash.com/photo-1610189025358-14c50ae4777f',
    ],
    'sizes': ['Free Size'],
    'colors': ['Red', 'Gold'],
    'inStock': true,
    'stockQuantity': 25,
    'tags': ['saree', 'silk', 'traditional', 'wedding'],
    'specifications': {
      'material': 'Pure Silk',
      'care': 'Dry clean only',
      'style': 'Traditional',
    }
  },
  {
    'id': 'prod2',
    'categoryId': 'cat1',
    'name': 'Designer Anarkali Suit',
    'description': 'Elegant designer Anarkali suit with detailed embroidery',
    'price': 12999.99,
    'discountPrice': 11999.99,
    'images': [
      'https://images.unsplash.com/photo-1583391733956-6c78276477e2',
      'https://images.unsplash.com/photo-1583391733956-6c78276477e2',
    ],
    'sizes': ['S', 'M', 'L', 'XL'],
    'colors': ['Blue', 'Green'],
    'inStock': true,
    'stockQuantity': 30,
    'tags': ['anarkali', 'suit', 'designer', 'party'],
    'specifications': {
      'material': 'Georgette',
      'care': 'Dry clean only',
      'style': 'Party wear',
    }
  },
  // Western Wear Products
  {
    'id': 'prod3',
    'categoryId': 'cat2',
    'name': 'Floral Maxi Dress',
    'description': 'Stunning floral print maxi dress perfect for summer',
    'price': 4999.99,
    'discountPrice': 3999.99,
    'images': [
      'https://images.unsplash.com/photo-1539109136881-3be0616acf4b',
      'https://images.unsplash.com/photo-1539109136881-3be0616acf4b',
    ],
    'sizes': ['XS', 'S', 'M', 'L'],
    'colors': ['Blue', 'Pink'],
    'inStock': true,
    'stockQuantity': 40,
    'tags': ['dress', 'maxi', 'floral', 'summer'],
    'specifications': {
      'material': 'Cotton',
      'care': 'Machine wash cold',
      'style': 'Casual',
    }
  },
  // Accessories Products
  {
    'id': 'prod4',
    'categoryId': 'cat3',
    'name': 'Designer Clutch Bag',
    'description': 'Elegant clutch bag with intricate embellishments',
    'price': 2999.99,
    'discountPrice': 2499.99,
    'images': [
      'https://images.unsplash.com/photo-1601121141461-9d6647bca1ed',
      'https://images.unsplash.com/photo-1601121141461-9d6647bca1ed',
    ],
    'sizes': ['One Size'],
    'colors': ['Gold', 'Silver'],
    'inStock': true,
    'stockQuantity': 20,
    'tags': ['clutch', 'bag', 'party', 'accessories'],
    'specifications': {
      'material': 'Synthetic leather with metal work',
      'care': 'Wipe with clean cloth',
      'style': 'Party wear',
    }
  },
  // Footwear Products
  {
    'id': 'prod5',
    'categoryId': 'cat4',
    'name': 'Embellished Heels',
    'description': 'Beautiful embellished heels for special occasions',
    'price': 3999.99,
    'discountPrice': 3499.99,
    'images': [
      'https://images.unsplash.com/photo-1543163521-1bf539c55dd2',
      'https://images.unsplash.com/photo-1543163521-1bf539c55dd2',
    ],
    'sizes': ['36', '37', '38', '39', '40'],
    'colors': ['Gold', 'Silver', 'Rose Gold'],
    'inStock': true,
    'stockQuantity': 30,
    'tags': ['heels', 'party', 'wedding', 'footwear'],
    'specifications': {
      'material': 'Synthetic with stone work',
      'care': 'Wipe with clean cloth',
      'style': 'Party wear',
    }
  }
];
