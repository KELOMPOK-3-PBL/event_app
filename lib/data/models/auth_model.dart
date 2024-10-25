import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String name;
  final String password;

  // Constructor
  const AuthModel({required this.name, required this.password});

  // Convert a JSON map to the UserModel object
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'],
      password: json['password'],
    );
  }

  // Convert the UserModel object to a JSON map
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  // password: json['password'],
  //   };
  // }

  @override
  List<Object?> get props => [name, password];
}
