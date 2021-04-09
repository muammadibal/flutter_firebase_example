part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserModel changeValue({
    String name = "",
    String address = "",
  }) => UserModel(this.uid, this.email, name: name, address: address);

  Future<UserModel> getDataUser() async => await UserServices.getDataUserFirestore(this.uid);
}