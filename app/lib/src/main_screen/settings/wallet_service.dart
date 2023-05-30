import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;

import '../../auth/user.dart';
import 'transaction.dart';

class WalletService {
  static String get collection => "transactions";
  FirebaseFirestore get db => FirebaseFirestore.instance;

  Stream<Iterable<Transaction>> stream(UserModel? user) {
    return db
        .collection(collection)
        .where('userId', isEqualTo: user?.id)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        return Transaction.fromMap({
          ...e.data(),
          "id": e.id,
        });
      });
    });
  }

  Future charge(UserModel user, double value) {
    return db.collection(collection).add(
          Transaction(
            id: '',
            reference: '',
            value: value,
            type: TransactionType.charge,
            date: Timestamp.now(),
            userId: user.id,
          ).toMap(),
        );
  }
}
