import 'package:controlarpersonal_remoto/data/datasources/remote/authentication_datasource.dart';

import '../../data/datasources/remote/user_datasource.dart';
import '../models/user.dart';

class Repository {
  late AuthenticationDatatasource _authenticationDataSource;
  late UserDataSource _userDatatasource;
  String token = "";

  // the base url of the API should end without the /
  final String _baseUrl =
      "https://retoolapi.dev/KInGzV/datausers";

  Repository() {
    _authenticationDataSource = AuthenticationDatatasource();
    _userDatatasource = UserDataSource();
  }

  Future<bool> login(String email, String password) async {
    return await _authenticationDataSource.login(_baseUrl, email, password);
  }


  Future<bool> logOut() async => await _authenticationDataSource.logOut();

  Future<List<User>> getUsers() async => await _userDatatasource.getUsers();

  Future<bool> addUser(User user) async =>
      await _userDatatasource.addUser(user);

  Future<bool> updateUser(User user) async =>
      await _userDatatasource.updateUser(user);

  Future<bool> deleteUser(int id) async =>
      await _userDatatasource.deleteUser(id);
}
