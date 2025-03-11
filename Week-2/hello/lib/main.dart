import 'package:flutter/material.dart';
import 'package:peesonnong/screen/add.todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> todoItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Myapp'),
          backgroundColor: Colors.orange,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todoItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todoItems[index]),
                    subtitle: Text("subtitle"),
                    leading: Checkbox(
                      value: true,
                      onChanged: (bool? value) {
                        // handle the change
                        setState(() {});
                      },
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          todoItems.removeAt(index);
                        });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddTodoScreen()),
                );
                if (result != null) {
                  setState(() {
                    todoItems.add(result);
                  });
                }
              },
              child: Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
