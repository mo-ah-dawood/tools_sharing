import 'package:cloud_firestore/cloud_firestore.dart' hide Order, Transaction;

import '../../auth/user.dart';
import '../settings/transaction.dart';
import '../settings/wallet_service.dart';
import 'order_item.dart';

class OrdersService {
  static String get collection => "orders";
  static String get cartCollection => "carts";
  static String get transactions => WalletService.collection;
  FirebaseFirestore get db => FirebaseFirestore.instance;

  Future generateCart(UserModel user) {
    return db.collection(cartCollection).doc(user.id).set(
          Order(
            date: Timestamp.now(),
            userId: user.id,
          ).toMap(),
        );
  }

  Stream<Iterable<Order>> stream(UserModel? user, bool byMe) {
    Query<Map<String, dynamic>> query;
    if (byMe) {
      query = db.collection(collection).where('userId', isEqualTo: user?.id);
    } else {
      query =
          db.collection(collection).where('itemUsers', arrayContains: user?.id);
    }
    return query.orderBy('date', descending: true).snapshots().map((event) {
      return event.docs.map((e) {
        return Order.fromMap({
          ...e.data(),
          "id": e.id,
        });
      });
    });
  }

  Future setRecieved(Order order, List<OrderItem> items) {
    order = order.copyWith(
      items: order.items
          .map(
            (e) => items.any((element) => element.toolId == e.toolId)
                ? e.copyWith(received: true)
                : e,
          )
          .toSet(),
    );
    return db.runTransaction((transaction) async {
      db.collection(collection).doc(order.id).update(order.toMap());
      var price = items.fold(
          0.0, (previousValue, element) => previousValue + element.price);
      var user = items.map((e) => e.userId).toSet().first;
      await db.collection(transactions).add(Transaction(
            reference: order.id,
            date: Timestamp.now(),
            id: '',
            type: TransactionType.paid,
            userId: user,
            value: price,
          ).toMap());
    });
  }

  Stream<Order?> myCart(UserModel user) {
    return db.collection(cartCollection).doc(user.id).snapshots().map((event) {
      if (!event.exists) {
        return null;
      }
      return Order.fromMap({...event.data() ?? {}, "id": event.id});
    });
  }

  Future addToCart(Order order, OrderItem item) {
    return db
        .collection(cartCollection)
        .doc(order.id)
        .update(order.withItem(item).toMap());
  }

  Future updateInCart(Order order, OrderItem item) {
    return db
        .collection(cartCollection)
        .doc(order.id)
        .update(order.withItem(item).toMap());
  }

  Future removeFromCart(Order order, OrderItem item) {
    return db
        .collection(cartCollection)
        .doc(order.id)
        .update(order.withoutItem(item).toMap());
  }

  Future checkOut(Order order) async {
    return db.runTransaction((transaction) async {
      var res = await db.collection(collection).add(order.toMap());
      await db.collection(cartCollection).doc(order.id).delete();
      for (var item in order.items) {
        await db.collection('tools').doc(item.toolId).update({
          'endDate':
              Timestamp.fromDate(DateTime.now().add(Duration(days: item.days)))
        });
      }
      await db.collection(transactions).add(Transaction(
            reference: res.id,
            date: Timestamp.now(),
            id: '',
            type: TransactionType.pay,
            value: order.price * -1,
            userId: order.userId,
          ).toMap());
    });
  }
}
