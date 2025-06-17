import 'dart:io';

import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });

  Future<List<BlogModel>> getAllBlogs(String userId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImpl({required this.client});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await client.from("blogs").insert(blog.toMap()).select();

      return BlogModel.fromMap(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      final bucket = client.storage.from("blogImages");

      await bucket.upload(blog.id, image);

      return bucket.getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs(String userId) async {
    try {
      final blogs = await client
          .from("blogs")
          .select('*, profiles (name)')
          .eq("user_id", userId);
      return blogs
          .map(
            (blog) => BlogModel.fromMap(
              blog,
            ).copyWith(userName: blog["profiles"]["name"]),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
