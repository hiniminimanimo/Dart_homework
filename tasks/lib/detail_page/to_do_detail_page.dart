import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/to_do_entity.dart';

class ToDoDetailPage extends StatelessWidget {
  final ToDo toDo; // 리스트에서 선택한 ToDo 1개를 보여주기
  final VoidCallback onToggleFavorite; // 즐찾 상태 토글하기 위한 콜백, 실제 상태 변경은 HomePage에서
  final VoidCallback onDelete; // 삭제 수행 콜백, 실제 삭제는 HomePage에서

  //디테일 페이지 생성자 - 외부에서 ToDo + 콜백 주입
  ToDoDetailPage({
    required this.toDo,
    required this.onToggleFavorite,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //앱바 - 즐찾 버튼
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: onToggleFavorite,
            icon: Icon(
              toDo.isFavorite ? CupertinoIcons.star_fill : CupertinoIcons.star,
            ),
          ),
        ],
      ),

      body: Container(
        color: Colors.grey.shade200, // 배경색 바디 부분만 깔기
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            //타이틀
            Text(
              toDo.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            //세부사항
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(CupertinoIcons.text_alignleft), // 세부사항 아이콘
                SizedBox(width: 12),
                Text(toDo.desc, style: const TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),

      // 삭제버튼 추가
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(CupertinoIcons.trash, color: Colors.white),
        // 삭제버튼 클릭 시 삭제확인 팝업 뜨기
        onPressed: () async {
          final toDoDelete = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('삭제하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('아니오'), // 삭제 안한다
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('예'), // 삭제 한다
                  ),
                ],
              );
            },
          );
          // 사용자가 예를 누르면 삭제 실행
          if (toDoDelete == true) {
            onDelete();
            Navigator.pop(context); // 디테일 페이지 닫기
          }
        },
      ),
    );
  }
}
