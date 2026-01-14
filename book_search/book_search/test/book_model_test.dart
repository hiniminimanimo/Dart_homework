import 'dart:convert';

import 'package:book_search/data/model/book.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('book model test', () {
    String dummyData = """
 {
    "title": "Harry! (Gedichte)",
    "link": "https://search.shopping.naver.com/book/catalog/32524001879",
    "image": "https://shopping-phinf.pstatic.net/main_3252400/32524001879.20250612073005.jpg",
    "author": "",
    "discount": "25540",
    "publisher": "Books on Demand",
    "pubdate": "20210519",
    "isbn": "9783753499949",
    "description": "Liebe zieht sich wie ein roter Faden \\ndurch unser Leben: \\nLebens- und Liebesgedichte"
  }
""";
    // 1. Map으로 변환
    Map<String, dynamic> map = jsonDecode(dummyData);
    // 2. 객체로 변환
    Book book = Book.fromJson(map);
    expect(book.title, 'Harry! (Gedichte)');
    print(book.toJson());
  });
}
