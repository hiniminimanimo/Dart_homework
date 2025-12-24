import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/detail_page/to_do_detail_page.dart';
import 'package:tasks/to_do_entity.dart';

// 할일 카드 한개를 화면에 보여주는 위젯
class ToDoView extends StatelessWidget {
  const ToDoView({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
    required this.onDelete,
  });

  final ToDo toDo; // 화면에 표시되는 실제 할일
  final VoidCallback onToggleFavorite; //즐찾 상태 토글 콜백
  final VoidCallback onToggleDone; //완료 상태 토글 콜백
  final VoidCallback onDelete; // 삭제 실행 콜백

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // 카드 전체 눌렀을 때 디테일 페이지로 이동하기
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // 데이터를 디테일 페이지로 전달
            builder: (_) => ToDoDetailPage(
              toDo: toDo, // 할일
              onToggleFavorite: onToggleFavorite, // 즐찾
              onDelete: onDelete, // 삭제하면 리스트에서도 제거
            ),
          ),
        );
      },

      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // 패딩 수평 16
          child: Row(
            children: [
              // 완료 토글
              IconButton(
                onPressed: onToggleDone,
                icon: Icon(
                  toDo.isDone
                      ? CupertinoIcons.check_mark_circled_solid
                      : CupertinoIcons.circle,
                ),
              ),

              const SizedBox(width: 12),
              // 타이틀 (완료 토글 체크 시 취소선 적용)
              Expanded(
                child: Text(
                  toDo.title,
                  style: TextStyle(
                    fontSize: 16,
                    decoration: toDo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // 즐겨찾기 토글(상태에 따라 채워진 별, 빈별)
              IconButton(
                onPressed: onToggleFavorite,
                icon: Icon(
                  toDo.isFavorite
                      ? CupertinoIcons.star_fill
                      : CupertinoIcons.star,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
