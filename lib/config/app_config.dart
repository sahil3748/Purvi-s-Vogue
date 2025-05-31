class AppConfig {
  // AppWrite Configuration
  static const String appwriteEndpoint = 'YOUR_APPWRITE_ENDPOINT';
  static const String appwriteProjectId = 'YOUR_PROJECT_ID';
  static const String appwriteBucketId = 'YOUR_BUCKET_ID';

  // Firebase Collection Names
  static const String categoriesCollection = 'Categories';
  static const String productsCollection = 'Products';
  static const String variantsCollection = 'Variants';
  static const String reviewsCollection = 'Reviews';
  static const String promotionsCollection = 'Promotions';
  static const String searchIndexCollection = 'SearchIndex';
  static const String filtersCollection = 'Filters';

  // Product Types
  static const String typeJewelry = 'Jewelry';
  static const String typeClothing = 'Clothing';

  // Gender Types
  static const String genderMen = 'Men';
  static const String genderWomen = 'Women';
  static const String genderUnisex = 'Unisex';

  // Storage Paths
  static const String productImagesPath = 'product_images';
  static const String categoryImagesPath = 'category_images';
  static const String variantImagesPath = 'variant_images';
}
