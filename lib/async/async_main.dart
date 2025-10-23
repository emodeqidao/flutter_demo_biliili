

import 'dart:async';

void main() {

  Future.delayed(Duration(seconds: 1), () => print('delayed')).then((value) {
    scheduleMicrotask(() => print("micro task"));
    print("then 1");
  }).then((value) => print("then 2"));

  /*
  //先把事件推到 event queue 中，等待当前事件执行完毕后再执行
  // Duration.zero 或者 Duration(seconds: 1)  不是一个精确的时间
  // 不是等待一秒 ，而是至少等待一秒，事件才能加到event queue上面才有可能被执行
  Future.delayed(Duration.zero, () => print('event 0'));
  Future(() => print('event 1'));
  Future.delayed(Duration(seconds: 1), () => print('event 2'));

  scheduleMicrotask(() => print('microtask 1'));
  Future.microtask(() => print('microtask 2'));
  Future.value(123).then((value) => print('microtask 3'));

  print("main 1");
  // 直接运行
  Future.sync(() => print('sync 1'));
  Future.value(getName());
  print("main 2");

   */
}

String getName() {
  print('getName');
  return 'xixi';
}

