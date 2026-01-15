import 'package:blog_app/data/model/post.dart';
import 'package:blog_app/ui/write/write_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class WritePage extends ConsumerStatefulWidget {
  WritePage(this.post);
  Post? post;

  @override
  ConsumerState<WritePage> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
  // 제목, 작성자, 내용
  late TextEditingController titleController = TextEditingController(
    text: widget.post?.title ?? '',
  );
  late TextEditingController writerController = TextEditingController(
    text: widget.post?.writer ?? '',
  );
  late TextEditingController contentController = TextEditingController(
    text: widget.post?.content ?? '',
  );

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    writerController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final writeState = ref.watch(writeViewModelProvider(widget.post));
    final vm = ref.read(writeViewModelProvider(widget.post).notifier);
    if (writeState.isWriting) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Center(child: CircularProgressIndicator())),
      );
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: false,
          title: Text('글쓰기'),
          actions: [
            GestureDetector(
              onTap: () async {
                final result = formKey.currentState?.validate() ?? false;
                if (result) {
                  final insertResult = await vm.insertPost(
                    title: titleController.text,
                    content: contentController.text,
                    imageUrl: writeState.imageUrl!,
                    writer: writerController.text,
                  );
                  if (insertResult) {
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              TextFormField(
                controller: titleController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(hintText: '제목'),
                validator: (value) {
                  //trim : 문자열 앞 뒤로 공백 제거
                  if (value?.trim().isEmpty ?? true) {
                    return '제목을 입력해주세요';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: writerController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(hintText: '작성자'),
                validator: (value) {
                  //trim : 문자열 앞 뒤로 공백 제거
                  if (value?.trim().isEmpty ?? true) {
                    return '작성자를 입력해주세요';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 300,
                child: TextFormField(
                  controller: contentController,
                  maxLines: null,
                  expands: true, //크기를 늘리려면 반드시 설정해줘야함
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(hintText: '내용'),
                  validator: (value) {
                    //trim : 문자열 앞 뒤로 공백 제거
                    if (value?.trim().isEmpty ?? true) {
                      return '내용을 입력해주세요';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () async {
                    // 이미지 피커 객체 생성
                    ImagePicker imagePicker = ImagePicker();

                    //이미지 피커 객체의 픽이미지라는 메서드 호출
                    XFile? xFile = await imagePicker.pickImage(
                      source: ImageSource.gallery,
                    );
                    print('경로 : ${xFile?.path}');
                    if (xFile != null) {
                      vm.uploadImage(xFile);
                    }
                  },
                  child: writeState.imageUrl == null
                      ? Container(
                          width: 100,
                          height: 100,
                          color: Colors.blueGrey,
                          child: Icon(Icons.image, color: Colors.white),
                        )
                      : SizedBox(
                          height: 100,
                          child: Image.network(writeState.imageUrl!),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
