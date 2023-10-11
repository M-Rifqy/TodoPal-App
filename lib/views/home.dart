import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todopal/controllers/todopal_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoPalController _todoPalController = Get.put(TodoPalController());

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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: 'Enter what to do'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                  ),
                  child: Text('Save'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: ListTile(
                title: Text(
                  'Workin on my code',
                ),
                subtitle: Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    Text('Completed'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: ListTile(
                title: Text(
                  'Workin on my code',
                ),
                subtitle: Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    Text('Working..'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
