import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tools_sharing/src/main_screen/tools/tool_item.dart';

class ManageToolService {
  String get collection => "tools";
  FirebaseFirestore get db => FirebaseFirestore.instance;

  Future add(Tool tool) {
    return db.collection(collection).add(tool.toMap());
  }

  Future update(Tool tool) {
    return db.collection(collection).doc(tool.id).update(tool.toMap());
  }

  Future delete(Tool tool) {
    return db.collection(collection).doc(tool.id).delete();
  }
}
