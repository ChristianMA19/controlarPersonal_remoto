import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/user.dart';
import '../models/client.dart';
import '../repositories/repository.dart';

class UserUseCase {
  final Repository _repository = Get.find();

  UserUseCase();

  Future<List<User>> getUsers() async {
    logInfo("Getting users  from UseCase");
    return await _repository.getUsers();
  }

  Future<bool> addUser(User user) async => await _repository.addUser(user);

  Future<bool> updateUser(User user) async =>
      await _repository.updateUser(user);

  deleteUser(int id) async => await _repository.deleteUser(id);

  Future<List<Client>> getClients() async {
    logInfo("Getting users  from UseCase");
    return await _repository.getClients();
  }

  Future<bool> addClient(Client user) async => await _repository.addClient(user);

  Future<bool> updateClient(Client user) async =>
      await _repository.updateClient(user);

  deleteClient(int id) async => await _repository.deleteClient(id);
}
