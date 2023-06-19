import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LoadUserEvent extends LoginEvent {
  String? email;
  String? password;

  LoadUserEvent({this.email, this.password});

  @override
  List<Object?> get props => [email,password];
}
