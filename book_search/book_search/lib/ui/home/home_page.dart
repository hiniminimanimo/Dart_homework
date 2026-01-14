import 'package:book_search/ui/home/home_view_model.dart';
import 'package:book_search/ui/home/widgets/home_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _textController = TextEditingController();
  bool _isFocused = false; // 포커스 상태를 기억할 변수

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void onSearch(String text) {
    // 뷰모델의 searchBooks 메서드 호출
    ref.read(homeViewModelProvider.notifier).searchBooks(text);
    print('onSearch 호출됨: $text');
  }

  @override
  Widget build(BuildContext context) {
    // 상태 구독 (값이 변하면 리빌드)
    final homeState = ref.watch(homeViewModelProvider);
    final books = homeState.books;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  setState(() {
                    _isFocused = hasFocus;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    // 포커스 여부에 따라 색상 변경
                    border: Border.all(
                      color: _isFocused ? Colors.grey[600]! : Colors.grey[400]!,
                      width: _isFocused ? 2.0 : 1.0, // 포커스되면 두께도 살짝 두껍게
                    ),
                  ),
                  child: TextField(
                    controller: _textController,
                    onSubmitted: onSearch, // 엔터 입력 시 검색
                    decoration: const InputDecoration(
                      hintText: '검색어를 입력하세요',
                      // 힌트 텍스트 색상 변경
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 176, 176, 176),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8), // 검색창과 아이콘 사이 간격
            Container(
              width: 50,
              height: 50,
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  onSearch(_textController.text); // 버튼 클릭 시 검색
                },
              ),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 세 줄로 보여주기
          childAspectRatio: 3 / 4, // 책 비율 (세로로 조금 길게)
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: books.length, // 데이터 개수만큼 표시
        itemBuilder: (context, index) {
          final book = books[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return HomeBottomSheet(book);
                },
              );
            },
            child: Image.network(
              book.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
          );
        },
      ),
    );
  }
}
