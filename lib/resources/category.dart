import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';

class Category {
  final String title;
  final String imageUrl;

  Category({required this.title, required this.imageUrl});
}

Future<List<Category>> fetchCategories() async {
  List<Category> categories = [];

  for (int i = 1; i <= 9; i++) {
    
    String categoryPath = 'category/category$i';
    String title = await fetchFileContents('$categoryPath/title$i.txt');
    String imageUrl = await downloadFileUrl('$categoryPath/image$i.png');

    categories.add(Category(title: title, imageUrl: imageUrl));
  }

  return categories;
}

Future<String> fetchFileContents(String filePath) async {
  Reference storageReference = FirebaseStorage.instance.ref(filePath);

  final data = await storageReference.getData();
  String fileContents = utf8.decode(data!);

  return fileContents;
}

Future<String> downloadFileUrl(String filePath) async {
  Reference storageReference = FirebaseStorage.instance.ref(filePath);
  String downloadURL = await storageReference.getDownloadURL();
  return downloadURL;
}
