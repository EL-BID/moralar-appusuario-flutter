import 'package:flutter/material.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

class VideosProvider extends RemoteProvider {

  Future<List<Video>> getVideos({int page = 1}) async {
    try {
      final endpoint = "${Urls.family.videos}?Page=$page&Limit=3";
      print(endpoint);
      final response = await get(endpoint);
      return (response.data as List)
          .map((item) => Video.fromJson(item))
          .toList();
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }

  Future registerVideoViewed({required String videoId}) async {
    try {
      final endpoint = "${Urls.family.registerView}";
      print(endpoint);
      final response = await post(endpoint,
      body: {
        "videoId" : videoId
      });
      return response.data;
    } on MegaResponseException catch (e) {
      debugPrint(e.message);
      rethrow;
    }
  }
}