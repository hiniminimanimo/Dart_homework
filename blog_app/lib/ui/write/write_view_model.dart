import 'dart:io';

import 'package:blog_app/data/model/post.dart';
import 'package:blog_app/data/repository/post_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

// 1) 상태 클래스
class WriteState {
  final bool isWriting;
  String? imageUrl;
  WriteState(this.isWriting, this.imageUrl);
}

// PostRepository를 DI로 쓰기 위한 provider (이미 있으면 이 줄은 빼고 기존 걸 써)
final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepository();
});

// 2) 뷰모델
class WriteViewModel extends StateNotifier<WriteState> {
  WriteViewModel(this._postRepository, this._arg)
    : super(WriteState(false, _arg?.imageUrl));

  final PostRepository _postRepository;
  final Post? _arg;

  Future<bool> insertPost({
    required String title,
    required String content,
    required String writer,
    required String imageUrl,
  }) async {
    if (state.imageUrl == null) {
      return false;
    }
    // 작성/수정 시작
    state = WriteState(true, state.imageUrl);

    final bool result;
    if (_arg == null) {
      // 새로 작성
      result = await _postRepository.insert(
        title: title,
        content: content,
        imageUrl: state.imageUrl!,
        writer: writer,
      );
    } else {
      // 수정
      result = await _postRepository.update(
        id: _arg.id,
        title: title,
        content: content,
        imageUrl: state.imageUrl!,
        writer: writer,
      );
    }

    await Future.delayed(const Duration(seconds: 3));
    // 작성/수정 종료
    state = WriteState(false, state.imageUrl);

    return result;
  }

  void uploadImage(XFile xFile) async {
    try {
      // firebase Storage 사용법
      // 1. firebase storage 객체 가지고 오기
      final storage = FirebaseStorage.instance;
      // 2. 스토리지 참조 만들기
      Reference ref = storage.ref();
      // 3. 파일 참조 만들기
      Reference fileRef = ref.child(
        '${DateTime.now().millisecondsSinceEpoch}_${xFile.name}',
      );
      // 4. 쓰기!
      await fileRef.putFile(File(xFile.path));
      // 5. 파일에 접근할 수 있는 URL 받기
      String imageUrl = await fileRef.getDownloadURL();
      state = WriteState(state.isWriting, imageUrl);
    } catch (e) {
      print('에러 : $e');
    }
  }
}

// 3) 뷰모델 관리자
final writeViewModelProvider = StateNotifierProvider.autoDispose
    .family<WriteViewModel, WriteState, Post?>((ref, post) {
      final repo = ref.read(postRepositoryProvider);
      return WriteViewModel(repo, post);
    });
