import 'dart:io';
import 'package:blog_app/core/error/app_failure.dart';
import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;

  BlogRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        userId: userId,
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await remoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      return right(await remoteDataSource.uploadBlog(blogModel));
    } on ServerException catch (e) {
      return left(AppFailure(e.message));
    }
  }

  @override
  Future<Either<AppFailure, List<Blog>>> getAllBlogs(String userId) async {
    try {
      final blogs = await remoteDataSource.getAllBlogs(userId);

      return right(blogs);
    } on ServerException catch (e) {
      return left(AppFailure(e.toString()));
    }
  }
}
