import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter/Services/database_services.dart';
import 'package:todo_flutter/models/task.dart';
import 'package:todo_flutter/models/tasks_data.dart';

import '../task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;

  //비동기로 데이터베이스에서 할 일 목록을 가져오는 함수
  getTasks() async {
    tasks = await DatabaseServices.getTasks();
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {}); //화면 갱신
  }

  //getTask로 초기 상태가 설정될 때 데이터베이스에서 목록을 가져옴
  //useEffect 훅의 기능과 비슷하다고 생각
  @override
  void initState() { 
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(
          //Provider.of로 가장 가까운 상위 Provider를 찾아 task 갯수를 가져옴
          //context 현재 위젯이 속한 위젯 트리의 위치와 정보
          '${Provider.of<TasksData>(context).tasks.length} Things To Do',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        //데이터를 구독, 해당 데이터가 변경될 때마다 자동으로 새로운 값을 빌더 함수에 전달
        child: Consumer<TasksData>(
          builder: (context, tasksData, child) {
            //스크롤 가능한 리스트 위젯
            return ListView.builder(
                itemCount: tasksData.tasks.length,//항목 수를 지정
                itemBuilder: (context, index) {//각 항목의 위젯을 생성
                  Task task = tasksData.tasks[index];
                  return TaskTile(
                    task: task,
                    tasksData: tasksData,
                  );
                });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.blueGrey,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {//모달에 표시될 위젯을 반환
              return const AddTaskScreen();
            },
          );
        },
      ),

    );
  }
}