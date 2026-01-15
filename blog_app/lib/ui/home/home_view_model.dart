//1. 상태 클래스 만들기
//List<Post> posts;

//2. 뷰모델 만들기
import 'dart:async';
import 'package:blog_app/data/repository/post_repository.dart';
import 'package:blog_app/data/model/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeViewModel extends Notifier<List<Post>> {
  @override
  List<Post> build() {
    getAllPosts();
    return [];
  }

  void getAllPosts() async {
    final postRepository = PostRepository();
    //final posts = await postRepository.getAll();
    //state = posts ?? [];
    final stream = postRepository.postListStream();
    final streamSubscription = stream.listen((posts) {
      state = posts;
    });

    /// 이 뷰 모델이 없어질 때 넘겨준 함수 호출
    ref.onDispose(() {
      //구독하고 있는 스트림의 구독을 끊어줘야 메모리에서 안전하게 제거
      //구독을 끊어주는 방법은 스트림 리쓴 할 때 리턴받는 스트림섭스크립션 클래스의
      //cancel() 메서드를 호출하면 됨
      streamSubscription.cancel();
    });
  }
}

//3. 뷰모델 관리자 만들기
final homeViewModelProvider = NotifierProvider<HomeViewModel, List<Post>>(() {
  return HomeViewModel();
});
