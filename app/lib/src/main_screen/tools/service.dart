import 'package:cloud_firestore/cloud_firestore.dart';

import '../../auth/user.dart';
import '../categories/category.dart';
import 'tool_item.dart';

class ToolsService {
  static String get collection => "tools";
  FirebaseFirestore get db => FirebaseFirestore.instance;
  Stream<Iterable<Tool>> stream(Category? category, UserModel? user) {
    var query =
        db.collection(collection).where('userId', isNotEqualTo: user?.id);
    if (category?.id.isNotEmpty == true) {
      query = query.where('categoryId', isEqualTo: category?.id);
    }
    return query.snapshots().map((event) {
      return event.docs.map((e) {
        return Tool.fromMap({
          ...e.data(),
          "id": e.id,
        });
      });
    });
  }

  Stream<Iterable<String>> rentedStream() {
    var query = db.collection(collection);
    return query.snapshots().map((event) {
      return event.docs
          .map((e) {
            return Tool.fromMap({
              ...e.data(),
              "id": e.id,
            });
          })
          .where((element) => element.isRented)
          .map((e) => e.id);
    });
  }

  Stream<Iterable<Tool>> myToolsStream(UserModel user) {
    var query = db.collection(collection).where('userId', isEqualTo: user.id);

    return query.snapshots().map((event) => event.docs.map((e) => Tool.fromMap({
          ...e.data(),
          "id": e.id,
        })));
  }

  Stream<Tool> tool(Tool tool) {
    return db.collection(collection).doc(tool.id).snapshots().map((event) {
      return Tool.fromMap({
        ...event.data() ?? {},
        "id": event.id,
      });
    });
  }
}
