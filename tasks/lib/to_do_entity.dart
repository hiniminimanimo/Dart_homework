//할일 하나를 표현하는 데이터 클래스(앱전체 동일 구조)
class ToDo {
  final String title; // 할일 제목
  final String desc; // 할일 세부설명
  final bool isFavorite; // 즐겨찾기
  final bool isDone; // 완료여부

  // 할일 객체 생성자
  ToDo({
    required this.title,
    required this.desc,
    required this.isFavorite,
    this.isDone = false, // 처음 생성 시 완료되지 않은 상태(체크는 내가 해야함)
  });

  ToDo copyWith({String? title, String? desc, bool? isFavorite, bool? isDone}) {
    return ToDo(
      title: title ?? this.title,
      desc: desc ?? this.desc,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
    );
  }
}
