import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  // Your Appwrite endpoint (update this with your actual endpoint)
  static const String endpoint = 'https://cloud.appwrite.io/v1';

  // Your Appwrite project ID (update this with your actual project ID)
  static const String projectId = 'purvis-vogue';

  // Your database ID (update this with your actual database ID)
  static const String databaseId = 'purvis-vogue-db';

  // Your storage bucket ID (update this with your actual bucket ID)
  static const String storageBucketId = 'products-images';

  // Get configured Appwrite client
  static Client getClient() {
    Client client = Client();
    client
        .setEndpoint(endpoint)
        .setProject(projectId)
        .setSelfSigned(status: true); // Remove this line in production
    return client;
  }

  // Collection IDs
  static const String productsCollection = 'products';
  static const String categoriesCollection = 'categories';
  static const String variantsCollection = 'variants';
}
