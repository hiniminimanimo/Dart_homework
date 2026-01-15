import 'package:blog_app/data/model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepository {
  Future<List<Post>?> getAll() async {
    try {
      //1. firestore db 연결(인스턴스 가지고오기)
      final firestore = FirebaseFirestore.instance;
      //2. collection 참조
      final collectionRef = firestore.collection('posts');
      //3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;
      return docs.map((doc) {
        final map = doc.data();
        doc.id;
        final newMap = {'id': doc.id, ...map};
        return Post.fromJson(newMap);
      }).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  //1. Create :  데이터 쓰기
  Future<bool> insert({
    required String title,
    required String content,
    required String writer,
    required String imageUrl,
  }) async {
    try {
      //1. firestore db 연결(인스턴스 가지고오기)
      final firestore = FirebaseFirestore.instance;
      //2. collection 참조 만들기
      final collectionRef = firestore.collection('posts');
      //3. 문서 참조 만들기
      final docRef = collectionRef.doc();
      //4. 값 쓰기
      await docRef.set({
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //2. Read : 특정 ID로 하나의 도큐먼트 가져오기
  Future<Post?> getOne(String id) async {
    try {
      //1. firestore db 연결(인스턴스 가지고오기)
      final firestore = FirebaseFirestore.instance;
      //2. collection 참조
      final collectionRef = firestore.collection('posts');
      //3. 문서 참조
      final docRef = collectionRef.doc(id);
      //4. 값 불러오기
      final doc = await docRef.get();
      return Post.fromJson({'id': doc.id, ...doc.data()!});
    } catch (e) {
      print(e);
      return null;
    }
  }

  //3. Update : 도큐먼트 수정
  Future<bool> update({
    required String id,
    required String title,
    required String content,
    required String writer,
    required String imageUrl,
  }) async {
    try {
      //1. firestore db 연결(인스턴스 가지고오기)
      final firestore = FirebaseFirestore.instance;
      //2. collection 참조
      final collectionRef = firestore.collection('posts');
      //3. 문서 참조
      final docRef = collectionRef.doc(id);
      //4. 값 업데이트(set 메서드 => update 메서드)
      //없데이트할 값 Map 형태로 넣어주기 : id에 해당하는 문서가 없을 때 새로 생성
      //docRef.set(data);
      //업데이트할 값 Map 형태로 넣어주기 : id에 해당하는 문서가 없을 때 에러 발생
      await docRef.update({
        'title': title,
        'content': content,
        'writer': writer,
        'imageUrl': imageUrl,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //4. Delete : 도큐먼트 삭제
  Future<bool> delete(String id) async {
    try {
      //1. firestore db 연결(인스턴스 가지고오기)
      final firestore = FirebaseFirestore.instance;
      //2. collection 참조
      final collectionRef = firestore.collection('posts');
      //3. 문서 참조
      final docRef = collectionRef.doc(id);
      //4. 값 삭제
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Post>> postListStream() {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore
        .collection('posts')
        .orderBy('createdAt', descending: true);
    // 최신순 정렬 추가
    final stream = collectionRef.snapshots();
    final newStream = stream.map((event) {
      return event.docs
          .map((e) {
            try {
              return Post.fromJson({'id': e.id, ...e.data()});
            } catch (e) {
              // 데이터 파싱 실패 시 해당 항목은 제외 (로그 출력 등 가능)
              return null;
            }
          })
          .where((e) => e != null)
          .cast<Post>()
          .toList();
    });
    return newStream;
  }

  Stream<Post?> postStream(String id) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('posts');
    final docRef = collectionRef.doc(id);
    final stream = docRef.snapshots();
    final newStream = stream.map((e) {
      if (e.data() == null) {
        return null;
      }
      return Post.fromJson({'id': e.id, ...e.data()!});
    });
    return newStream;
  }
}
