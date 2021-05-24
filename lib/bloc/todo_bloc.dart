import 'dart:async';
import 'dart:math';
import 'package:trinhvanlong/base/base_bloc.dart';
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
class TodoBloc extends BaseBloc {
  StreamController _titleController = new StreamController();
  StreamController _subtitleController = new StreamController();
  StreamController<List<Todo>> _todoListController = StreamController<List<Todo>>();
  Stream get todoListStream => _todoListController.stream;
  Stream get titleStream => _titleController.stream;
  Stream get subTitleStream => _subtitleController.stream;
  List<Todo> _todoListData= List<Todo>();

  void loadList(){}
  void AddTodo(Todo todo){
    _todoListData.add(todo);
    _todoListController.sink.add(_todoListData);
  }
  void UpdateTodo(int index, String title, String subTitle){

    if(title!=null){
      _todoListData[index].title=title;
    }
    if(subTitle!=null){
      _todoListData[index].subtitle=subTitle;
    }
     _todoListController.sink.add(_todoListData);

  }
  void DeleteTodo(Todo todo){
    _todoListData.remove(todo);
    _todoListController.sink.add(_todoListData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if(event is AddTodoEvent){
      var _randomInt = Random();
      Todo _todo = new Todo(_randomInt.nextInt(1000000).toString(),event.title,event.subTitle);
      AddTodo(_todo);
    }
    if(event is UpdateTodoEvent){
        UpdateTodo(event.index,event.title,event.subTitle);
    }
    if(event is DeleteTodoEvent){
        DeleteTodo(event.todo);
    }


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.close();
    _subtitleController.close();
    _todoListController.close();
  }
}
