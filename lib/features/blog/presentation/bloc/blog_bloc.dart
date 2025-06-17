import 'dart:io';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _allBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlog})
    : _uploadBlog = uploadBlog,
      _allBlogs = getAllBlog,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onGetAllBlog);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final params = UploadBlogParams(
      userId: event.userId,
      title: event.title,
      content: event.content,
      image: event.image,
      topics: event.topics,
    );

    final res = await _uploadBlog(params);

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onGetAllBlog(BlogFetchAllBlogs event, Emitter<BlogState> emit) async {
    final res = await _allBlogs(event.userId);

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogDisplaySuccess(blogs)),
    );
  }
}
