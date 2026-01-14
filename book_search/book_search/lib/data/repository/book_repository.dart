import 'dart:convert';

import 'package:book_search/data/model/book.dart';
import 'package:http/http.dart';

class BookRepository {
  Future<List<Book>> searchBooks(String query) async {
    //
    final client = Client();
    final response = await client.get(
      Uri.parse('https://openapi.naver.com/v1/search/book.json?query=$query'),
      headers: {
        'X-Naver-Client-Id': '7VTP__vjTOkuA_S1jACv',
        'X-Naver-Client-Secret': 'SePAm6IieT',
      },
    );

    //Get 요청 시 성공 => 200
    //응답코드가 200일 때!
    //body 데이터를 jsonDecode 함수 사용해서 map으로 바꾼 후 List<Book>로 변환

    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      final items = List.from(map['items']);

      //MappedIterable 이라는 클라스에 함수를 넘겨줄테니
      //나중에 요청하면 그때 List(items)들을 하나씩 반복문을 돌면서
      //내가 넘규준 함수를 실행시켜서 새로운 리스트로 돌려줘!
      final iterable = items.map((e) {
        return Book.fromJson(e);
      });

      final list = iterable.toList();
      return list;
    }
    // 아닐 때, 빈 리스트 반환
    return [];
  }
}
