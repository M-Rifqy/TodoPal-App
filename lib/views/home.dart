import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todopal/controllers/todopal_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoPalController _todoPalController = Get.put(TodoPalController());
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('TodoPal'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter what to do',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Obx(() {
                  return _todoPalController.loading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            await _todoPalController.addTodo(
                              textdata: _controller.text.trim(),
                            );
                            _controller.clear();
                            _todoPalController.getAllTodo();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                          ),
                          child: Text('Save'),
                        );
                }),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                return _todoPalController.loading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics:
                            BouncingScrollPhysics(), // Enable scrolling bounce effect
                        itemCount: _todoPalController.todos.value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: ListTile(
                              title: Text(
                                _todoPalController.todos.value[index].text
                                    .toString(),
                              ),
                              subtitle: Row(
                                children: [
                                  Checkbox(
                                    value: _todoPalController
                                                .todos.value[index].completed ==
                                            1
                                        ? true
                                        : false,
                                    onChanged: (value) async {
                                      await _todoPalController.updateTodo(
                                        _todoPalController
                                            .todos.value[index].id,
                                        _todoPalController
                                            .todos.value[index].text,
                                      );
                                      _todoPalController.getAllTodo();
                                    },
                                  ),
                                  Text(_todoPalController
                                              .todos.value[index].completed ==
                                          1
                                      ? 'Completed'
                                      : 'Not Completed'),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final originalTodo =
                                          _todoPalController.todos.value[index];
                                      final TextEditingController
                                          editController =
                                          TextEditingController(
                                              text: originalTodo.text);

                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Edit Todo'),
                                            content: TextField(
                                                controller: editController),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  final newText =
                                                      editController.text;
                                                  if (originalTodo.id != null) {
                                                    await _todoPalController
                                                        .editTodo(
                                                            originalTodo.id!,
                                                            newText);
                                                  }
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                  _todoPalController
                                                      .getAllTodo();
                                                },
                                                child: Text('Save'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Edit'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (_todoPalController
                                              .todos.value[index].id !=
                                          null) {
                                        await _todoPalController.deleteTodo(
                                            _todoPalController
                                                .todos.value[index].id!);
                                      }
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
