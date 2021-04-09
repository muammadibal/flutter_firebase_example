part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String address;
  final String password;

  UserModel(this.id, this.email, {this.address, this.name, this.password});

  UserModel copywith(
    String id,
    String name,
    String email,
    String address,
    String password,
  ) => UserModel(
    this.id,
    this.email,
    address: address ?? this.address,
    name: name ?? this.name,
    password: password ?? this.password,
  );

  @override
  List<Object> get props => [id, name, email, address, password];

}