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
      var request = await http.put(Uri.parse('$todosurl/$id'), headers: {
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

Future editTodo(int id, String newText) async {
  try {
    var request = await http.put(
      Uri.parse('$todosurl/$id'),
      headers: {
        'Accept': 'Application/json',
      },
      body: {
        'text': newText, // Only update the text field, not completed
      },
    );

    if (request.statusCode == 200) {
      print('Edited');
      final editedTodo = todos.value.firstWhere((todo) => todo.id == id);
      editedTodo.text = newText; // Update the text field
    } else {
      print(json.decode(request.body));
    }
  } catch (e) {
    print(e.toString());
  }
}


Future deleteTodo(int id) async {
  try {
    print('Deleting todo with ID: $id');
    var request = await http.delete(
      Uri.parse('$todosurl/$id'),
      headers: {
        'Accept': 'Application/json',
      },
    );

    print('Delete request URL: $todosurl/$id');

if (request.statusCode == 200) {
  print('Deleted');
  // Remove the deleted todo from the local list of todos
  todos.value.removeWhere((todo) => todo.id == id);

  // Create a new RxList to trigger UI update
  todos.value = RxList([...todos.value]);

  // Update the UI
  update();
} else {
  print('Delete request failed with status code ${request.statusCode}');
  print(json.decode(request.body));
}

  } catch (e) {
    print('Error in deleteTodo: $e');
  }
}

}
