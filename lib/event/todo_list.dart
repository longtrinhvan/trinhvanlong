// import 'package:flutter_app/base/bloc_event.dart';
// import 'package:flutter_app/model/todo.dart';
import 'package:trinhvanlong/base/bloc_event.dart';
import 'package:trinhvanlong/model/todo.dart';



class AddTodoEvent extends BaseEvent {

  String title;
  String subTitle;
  AddTodoEvent(this.title,this.subTitle);
}

class UpdateTodoEvent extends BaseEvent {
  int index;
  String title;
  String subTitle;
    UpdateTodoEvent(this.index,this.title,this.subTitle);
}

class DeleteTodoEvent extends BaseEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}
