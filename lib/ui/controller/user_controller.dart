import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/models/user.dart';
import '../../domain/models/client.dart';
import '../../domain/use_case/user_usecase.dart';

class UserController extends GetxController {
  final RxList<User> _users = <User>[].obs;
  final RxList<Client> _clients = <Client>[].obs;

  final UserUseCase userUseCase = Get.find();

  List<User> get users => _users;
  List<Client> get clients => _clients;

  @override
  void onInit() {
    super.onInit();
    getUsers();
    getClients(); // Asegúrate de llamar a getClients aquí
  }

  getUsers() async {
    logInfo("Getting users");
    List<User> updatedUsers = await userUseCase.getUsers();
    _users.assignAll(updatedUsers);
  }

  addUser(User user) async {
    logInfo("Add user");
    await userUseCase.addUser(user);
    getUsers();
  }

  updateUser(User user) async {
    logInfo("Update user");
    await userUseCase.updateUser(user);
    getUsers();
  }

  deleteUser(int id) async {
    await userUseCase.deleteUser(id);
    getUsers();
  }

  getClients() async {
    logInfo("Getting clients");
    List<Client> updatedClients = await userUseCase.getClients();
    logInfo(updatedClients);
    _clients.assignAll(updatedClients);
  }

  addClient(Client user) async {
    logInfo("Add client");
    await userUseCase.addClient(user);
    getClients();
  }

  updateClient(Client user) async {
    logInfo("Update client");
    await userUseCase.updateClient(user);
    getClients();
  }

  deleteClient(int id) async {
    await userUseCase.deleteClient(id);
    getClients();
  }
}
