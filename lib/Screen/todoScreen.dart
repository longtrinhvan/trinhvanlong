import 'package:flutter/material.dart';
import 'package:trinhvanlong/bloc/todo_bloc.dart';
import 'package:trinhvanlong/model/todo.dart';


class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<String> items = ["title 1", "title 2"];
  String val = "";
  TodoBloc _todoBloc = new TodoBloc();

  void showalertdialog(int index,
      String _title, String _subTitle) {

    String a;
    String b;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(_title==null?"Thêm":"Thoát"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (String text) {
                a = text;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.person),
                hintText: _title==null?"title":_title,
              ),
            ),
            TextField(
                onChanged: (String text) {
                  b = text;
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.contact_page_rounded),
                  hintText: _title==null?"subtitle":_subTitle,
                )),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if(_title==null){
                      _todoBloc.event.add(AddTodoEvent(a, b));
                    }
                    else{
                      _todoBloc.event.add(UpdateTodoEvent(index,a,b));
                    }

                  },
                  child: Text(_title==null?"Thêm":"Thoát"),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(35, 0, 0, 0) ,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Thoát"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hiển thị"),
        leading: Center(
          child: Switch(
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value;
                print(isSwitched);
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              Icons.search,
              color: Colors.black,
            ),
            title: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (pattern) async {},
              onChanged: (text){
                text = text.toLowerCase();
                setState(() {
                  // _todoBloc.event.add(KeySearch(text));
                });
              },
              decoration: InputDecoration(
                hintText: "tìm kiếm .....",
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(child:   Container(
            padding: EdgeInsets.all(10),
            child: StreamBuilder(
              stream: _todoBloc.todoListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && isSwitched==true) {
                  List<Todo> a = snapshot.data;
                  return ListView.builder(
                    itemCount: a.length,
                    itemBuilder: (context, index) => ListTile(
                      onTap:(){showalertdialog(index,a[index].title,a[index].subtitle);} ,
                      leading: Image.network(
                        'https://duckienad.com/wp-content/uploads/2020/04/son-tung-mtp-512x384.jpg',
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(a[index].title),
                      subtitle: Text(a[index].subtitle),
                      trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _todoBloc.event.add(DeleteTodoEvent(a[index]));
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle_outline,
                          )),
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      child: Text('Rỗng'),
                    ),
                  );
                }
              },
            ),
          ))

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showalertdialog(null,null,null);
        },
        child: Text("Thêm"),
      ),
    );
  }

  void onAddTodo(String title, String subtitle) {}
}