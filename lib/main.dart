import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Notes',
      theme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isSelected = false;
  List<String> _tasks = [];

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
  }

  Widget _buildTask(String task) {
    return ListTile(
      title: isSelected
          ? Text(
              task,
              style: TextStyle(decoration: TextDecoration.lineThrough),
            )
          : Text(
              task,
            ),
      hoverColor: Colors.grey,
      selectedColor: Colors.greenAccent,
      onTap: () {},
      trailing: IconButton(
        icon: const Icon(Icons.done),
        onPressed: () {
          setState(() {
            _tasks.remove(task);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quick Notes"),
        centerTitle: true,
      ),
      body: _tasks.isNotEmpty
          ? ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return _buildTask(_tasks[index]);
              },
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("lib/assets/nothing.png"),
                  Text("No tasks yet!"),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddTaskModal(addTaskCallback: _addTask);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskModal extends StatefulWidget {
  final Function addTaskCallback;
  const AddTaskModal({super.key, required this.addTaskCallback});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final TextEditingController _taskController = TextEditingController();

  void _submitTask() {
    if (_taskController.text.isNotEmpty) {
      widget.addTaskCallback(_taskController.text);
      Navigator.pop(context);
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskController,
              decoration: const InputDecoration(hintText: 'Add a task'),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: _submitTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
              ),
              child: const Text(
                "Add",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
