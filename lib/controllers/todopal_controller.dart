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

  Future updateTodo(id, text) async {
    try {
      var request = await http
          .put(Uri.parse('http://192.168.0.112:80/api/todos/$id'), headers: {
        'Accept': 'Application/json',
      }, body: {
        text: text,
      });

      if (request.statusCode == 200) {
        print('Updated');
      } else {
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future addTodo({required String textdata}) async {

    var data = {
      'text': textdata,
    };

    try {
      loading.value = true;
      var request = await http.post(
        todosurl,
        headers: {
          'Accept': 'Application/json',
        },
        body: data,
      );

      if (request.statusCode == 201) {
        loading.value = false;
        print('Added');
      } else {
        loading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      loading.value = false;
      print(e.toString());
    }
  }
}
