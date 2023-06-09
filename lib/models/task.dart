class Task {
  final int id;
  final String title;
  bool done;

  Task({
    required this.id,
    required this.title,
    this.done = false,
  });
  
  //Task 객체 생성을 위한 함수
  factory Task.fromMap(Map taskMap) {
    return Task(
      id: taskMap['id'],
      title: taskMap['title'],
      done: taskMap['done'],
    );
  }
  void toggle() {
    done = !done;
  }
}

//Task 클래스를 정의