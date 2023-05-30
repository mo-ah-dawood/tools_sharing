import 'package:cloud_firestore/cloud_firestore.dart';

import 'category.dart';

class CategoriesService {
  static String get collection => "categories";
  FirebaseFirestore get db => FirebaseFirestore.instance;

  Stream<Iterable<Category>> stream() {
    return db
        .collection(collection)
        .snapshots()
        .map((event) => event.docs.map((e) => Category.fromMap({
              ...e.data(),
              "id": e.id,
            })));
  }
}
