import 'package:flutter/material.dart';

import 'models/task.dart';
import 'models/tasks_data.dart';

class TaskTile extends StatelessWidget {//상태없는 루트 위젯
  final Task task;
  final TasksData tasksData;

  const TaskTile({Key? key, required this.task, required this.tasksData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(//Checkbox 위젯 설정
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checkbox) {
            tasksData.updateTask(task);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration://스타일
            task.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: IconButton(//IconButton 위젯 설정
          icon: const Icon(Icons.clear),
          onPressed: () {
            tasksData.deleteTask(task);
          },
        ),
      ),
    );
  }
}