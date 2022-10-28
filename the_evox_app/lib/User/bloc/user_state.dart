part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final bool isLogged;
  final User? user;

  const UserState({this.isLogged = false, this.user});
}

class UserInitialState extends UserState {
  const UserInitialState() : super(isLogged: false, user: null);
}

class UserLoggin extends UserState {
  final User newUser;
  const UserLoggin(this.newUser) : super(isLogged: true, user: newUser);
}
