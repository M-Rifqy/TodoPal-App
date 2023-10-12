import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todopal/views/constants.dart';

class TodoPalController extends GetxController {
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAllTodo();
  }

  Future getAllTodo() async {
    try {
      loading.value = true;
      var response = await http.get(
        todosurl,
        headers: {
          'Accept': 'Application/json',
        },
      );

      if (response.statusCode == 200) {
        loading.value = false;

        print(json.decode(response.body));
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
