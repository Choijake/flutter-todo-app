import 'dart:convert'; // JSON 인코딩, 디코딩

import 'package:http/http.dart' as http; //http 요청
import 'package:todo_flutter/models/task.dart';

import 'globals.dart'; //요청 헤더 정보

class DatabaseServices {
  static Future<Task> addTask(String title) async {//Future 비동기 작업을 나타내는 클래스 타입
    //목록의 제목 저장하는 map 객체
    Map data = {
      "title": title,
    };
    var body = json.encode(data); //json 형식으로 변환
    var url = Uri.parse(baseURL + '/add'); //엔드포인트 지정

    http.Response response = await http.post(
      url, //요청 url
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body); //응답 본문을 다시 map객체로 디코딩
    Task task = Task.fromMap(responseMap); //Task 객체로 변환

    return task;
  }

  static Future<List<Task>> getTasks() async {
    var url = Uri.parse(baseURL);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  static Future<http.Response> updateTask(int id) async {
    var url = Uri.parse(baseURL + '/update/$id');
    http.Response response = await http.put(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteTask(int id) async {
    var url = Uri.parse(baseURL + '/delete/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }
}

//서비스