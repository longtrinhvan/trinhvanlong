import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_app/base/base_bloc.dart';
// import 'package:flutter_app/base/bloc_event.dart';
// import 'package:flutter_app/event/todo_list.dart';
// import 'package:flutter_app/model/todo.dart';
import 'package:trinhvanlong/base/base_bloc.dart';
import 'package:trinhvanlong/base/bloc_event.dart';
import 'package:trinhvanlong/event/todo_list.dart';
import 'package:trinhvanlong/model/todo.dart';


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
