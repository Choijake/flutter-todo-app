import 'package:flutter/cupertino.dart';
import 'package:todo_flutter/Services/database_services.dart';
import 'package:todo_flutter/models/task.dart';

class TasksData extends ChangeNotifier {
  List<Task> tasks = []; //작업 목록 리스트

  //DatabaseServices의 add API 실행
  void addTask(String taskTitle) async {
    Task task = await DatabaseServices.addTask(taskTitle);
    tasks.add(task);
    notifyListeners(); //Provider -> ChangeNotifier -> 상태 변화 업데이트
  }

  void updateTask(Task task) {
    task.toggle();
    DatabaseServices.updateTask(task.id);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    DatabaseServices.deleteTask(task.id);
    notifyListeners();
  }
}

//컨트롤러