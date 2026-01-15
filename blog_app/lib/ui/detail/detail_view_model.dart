//1. 상태 클래스 만들기
//post 객제 사용할거라 만들지 않음

//2. 뷰모델 만들기
import 'dart:async';
import 'package:blog_app/data/model/post.dart';
import 'package:blog_app/data/repository/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// PostRepository를 DI로 쓰기 위한 provider (이미 프로젝트에 있다면 이 줄은 빼고 기존 걸 사용)
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

// Post를 상태로 들고 있는 상세 ViewModel
class DetailViewModel extends StateNotifier<Post> {
  DetailViewModel(this._postRepository, Post post) : super(post) {
    listenStream();
  }

  final PostRepository _postRepository;
  StreamSubscription? _streamSubscription;

  void listenStream() {
    final stream = _postRepository.postStream(state.id);
    _streamSubscription = stream.listen((data) {
      if (data != null) {
        state = data;
      }
    });
  }

  Future<bool> deletePost() async {
    return await _postRepository.delete(state.id);
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

//3. 뷰모델 관리자 만들기
final detailViewModelProvider = StateNotifierProvider.autoDispose
    .family<DetailViewModel, Post, Post>((ref, post) {
      final repo = ref.read(postRepositoryProvider);
      return DetailViewModel(repo, post);
    });
