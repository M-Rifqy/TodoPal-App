import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todopal/views/constants.dart';
import 'package:todopal/models/todopal_model.dart';

class TodoPalController extends GetxController {
  RxBool loading = false.obs;
  Rx<List<TodoPalModel>> todos = Rx<List<TodoPalModel>>([]);

  @override
  void onInit() {
    super.onInit();
    getAllTodo();
  }

  Future getAllTodo() async {
    try {
      todos.value.clear();
      loading.value = true;
      var response = await http.get(
        todosurl,
        headers: {
          'Accept': 'Application/json',
        },
      );

      if (response.statusCode == 200) {
        loading.value = false;
        final content = json.decode(response.body)['todos'];
        for (var item in content) {
          todos.value.add(TodoPalModel.fromJson(item));
        }
      } else {
        loading.value = false;

        print(json.decode(response.body));
      }
    } catch (e) {
      loading.value = false;

      print(e.toString());
    }
  }
}
