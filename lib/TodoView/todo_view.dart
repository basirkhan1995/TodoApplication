import 'package:flutter/material.dart';
import 'package:flutter_sqflite_provider/Json/todo.dart';
import 'package:flutter_sqflite_provider/Provider/provider_db.dart';
import 'package:flutter_sqflite_provider/TodoView/add_todo.dart';
import 'package:flutter_sqflite_provider/TodoView/todo_update.dart';
import 'package:provider/provider.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderDB>(
      builder: (context,notifier,child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddTodo()));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text("Todo"),
          ),

          body: notifier.todo.isEmpty? const Center(child: Text("No Todo")) : ListView.builder(
              itemCount: notifier.todo.length,
              itemBuilder: (context,index){
                Todo todo = notifier.todo[index];
                return ListTile(
                  title: Text(todo.title),

                  //Delete
                  trailing: IconButton(
                    onPressed: ()=>notifier.deleteTodo(todo.todoId!),
                    icon: const Icon(Icons.delete,color: Colors.red,),
                  ),
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateTodo(todo: todo,))),
                );

          }),
        );
      }
    );
  }
}
