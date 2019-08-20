import 'dart:io';

void main() {
//  performTasks();
  AsyncTasks();
}

void performTasks() {
  tasks1();
  tasks2();
  tasks3();
}

void AsyncTasks() async {
  tasks1();
  String res = await tasks2Async();
  tasks2Async();
  tasks3();
  tasks3Async();
  task4(res);
}

void tasks1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

void tasks2() {
  Duration threeSeconds = Duration(seconds: 3);
  sleep(threeSeconds);

  String result = 'task 2 data';
  print('Task 2 complete');
}

Future<String> tasks2Async() async {
  Duration threeSeconds = Duration(seconds: 3);
  String result;
  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void tasks3() {
  String result = 'task 3 data';
  print('Task 3 complete');
}

void tasks3Async() async {
  String result = 'task 3 data';
  print('Task 3 complete');
}

void task4(String val) {
  String result = 'task 3 data';
  print('Task 4 complete: $val');
}
