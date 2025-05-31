import '../data/dummy_data.dart';
import '../services/firebase_service.dart';

class DummyDataUploader {
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> uploadDummyData() async {
    try {
      // Check if data already exists
      final bool dataExists = await _firebaseService.isDataAlreadyUploaded();

      if (dataExists) {
        print('Data already exists in Firebase. Skipping upload.');
        return;
      }

      // Upload categories
      await _firebaseService.uploadCategories(dummyCategories);
      print('Categories uploaded successfully!');

      // Upload products
      await _firebaseService.uploadProducts(dummyProducts);
      print('Products uploaded successfully!');

      print('All dummy data uploaded successfully!');
    } catch (e) {
      print('Error uploading dummy data: $e');
      rethrow;
    }
  }
}
