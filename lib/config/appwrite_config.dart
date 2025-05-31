import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  static const String projectId = '683a85b5001ebb6db205';
  static const String endpoint = 'https://cloud.appwrite.io/v1';

  // Storage configuration
  static const String defaultBucketId = 'default'; // Replace with your bucket ID

  static Client getClient() {
    Client client = Client();
    client
      .setEndpoint(endpoint)
      .setProject(projectId)
      .setSelfSigned(status: true); // For self-signed certificates in dev mode
    return client;
  }

  // Add your database ID and collection IDs here
  static const String databaseId = 'your_database_id';
  
  // Add other Appwrite-specific configuration constants here
} 