part of 'services.dart';

class UserServices {
  static CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  static Future setDataUser(UserModel user) async {
    userCollection.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'address': user.address,
    });
  }

  static Future getDataUserFirestore(String id) async {
    DocumentSnapshot snapshot = await userCollection.doc(id).get();

    return UserModel(
      id,
      snapshot.data()['email'],
      address: snapshot.data()['address'],
      name: snapshot.data()['name'],
    );
  }
}