import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/models/tasks_data.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String taskTitle = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView( //위젯을 스크롤이 가능한 목록으로 구성
        children: [
          const Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.green,
            ),
          ),
          TextField(
            autofocus: true, //화면이 열리면 자동으로 텍스트 필드에 커서 위치
            onChanged: (val) { //val은 콜백함수의 매개변수이자 입력한 텍스트
              taskTitle = val;
            },
          ),
          const SizedBox(height: 10),
          //Provider로 TasksData 인스턴스 가져온 후 addTask 호출해 입력값 전달
          TextButton(
            onPressed: () {
              if (taskTitle.isNotEmpty) {
                Provider.of<TasksData>(context, listen: false)
                    .addTask(taskTitle);
                Navigator.pop(context); //화면 닫음
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}