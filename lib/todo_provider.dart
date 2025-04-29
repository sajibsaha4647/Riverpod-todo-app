
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, AppState>((ref){
return TodoNotifier();

});

class TodoNotifier extends  StateNotifier<AppState> {
  TodoNotifier():super(AppState.initial());


  void updateQuery(String? query){
    state.queryController?.text = query ?? '';
     state = state.copyWith(queryController: state.queryController) ;
  }

  void createTodoList(String? todoData){
    if (todoData != null && todoData.isNotEmpty) {
      state = state.copyWith(
        myTodo: [
          ...state.myTodo ?? [],
          todoData,
        ],
      );
    }
  }

  void deleteTodo(int index){
    final updatedList = (state.myTodo ?? [])
        .asMap()
        .entries
        .where((entry) => entry.key != index)
        .map((entry) => entry.value)
        .toList();
    state = state.copyWith(myTodo: updatedList);
  }

  void updateTodo(String? query, int index){
    final updatedList = (state.myTodo ?? [])
        .asMap()
        .entries
        .map((entry) => entry.key == index ? (query ?? '') : entry.value)
        .toList();

    state = state.copyWith(myTodo: updatedList);
  }

}

class AppState {
  final int? id;
  final TextEditingController? queryController ;
  final String? myName;
  final List<String>? myTodo ;

  AppState({
    this.id,
    this.myName,
    this.queryController,
    this.myTodo
  });

  factory AppState.initial() {
    return AppState(
      id: 0,
      myName: '',
        queryController: TextEditingController(),
      myTodo: []
    );
  }

  AppState copyWith({
    int? id,
    String? myName,
    TextEditingController? queryController,
    List<String>? myTodo
  }) {
    return AppState(
      id: id ?? this.id,
      myName: myName ?? this.myName,
      queryController: queryController ?? this.queryController,
      myTodo: myTodo ?? this.myTodo,

    );
  }
}
