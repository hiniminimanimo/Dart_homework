import 'package:flutter/material.dart';
import 'package:tasks/main/empty_taskcard.dart';
import 'package:tasks/main/bottom_sheet.dart';
import 'package:tasks/to_do_entity.dart';
import 'package:tasks/main/to_do_view.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<ToDo> todos = []; // 전체 ToDo 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("희은's Tasks"),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        color: Colors.grey.shade400, // 바디영역 전체 배경색
        child:
            todos
                .isEmpty // 할일 하나도 없을때
            ? Column(children: [EmptyTaskcard()]) // 앱 처음 진입 시 보여주는 빈 카드
            // 할일이 하나 이상 생겼을 때
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: todos.length, // 할일의 개수 만큼 리스트 생성
                separatorBuilder: (_, __) => const SizedBox(height: 12),

                // 각각의 할일 카드 생성
                itemBuilder: (context, index) {
                  final t = todos[index];
                  return ToDoView(
                    toDo: t,

                    //즐찾토글
                    onToggleFavorite: () {
                      setState(() {
                        todos[index] = t.copyWith(isFavorite: !t.isFavorite);
                      });
                    },

                    //완료토글
                    onToggleDone: () {
                      setState(() {
                        todos[index] = t.copyWith(isDone: !t.isDone);
                      });
                    },

                    //삭제하기
                    onDelete: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                  );
                },
              ),
      ),

      // 할일 추가 버튼 +++
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 190, 28, 16),
        shape: const CircleBorder(),
        child: const Icon(CupertinoIcons.plus, color: Colors.white),

        //버튼 클릭 시 바텀 시트 오픈
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            builder: (_) => BottomSheetTest(),
          );

          // 바텀 시트에서 할일 객체 반환 시, 리스트에 새 할일 추가
          if (result != ToDo) {
            setState(() {
              todos.add(result);
            });
          }
        },
      ),
    );
  }
}
