
import 'dart:convert';

import 'package:flutter_codigo5_youapp/models/channel_model.dart';
import 'package:flutter_codigo5_youapp/models/comment_model.dart';
import 'package:flutter_codigo5_youapp/models/play_list_items_model.dart';
import 'package:flutter_codigo5_youapp/models/video_model.dart';
import 'package:http/http.dart' as http;

import '../util/constants.dart';

class APIService{



  Future<Map<String, dynamic>> getVideoStatistics(String id) async{
    String _path = "${pathProduction}/videos?part=statistics&id=${id}&key=${apiKey}";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> mapVideo = json.decode(response.body);
      List items = mapVideo["items"];
      if (items.length>0 ) {
        Map<String,dynamic> mapVideoStatistics = mapVideo["items"][0]["statistics"];
        return mapVideoStatistics;
      }
    }
    Map<String,dynamic> mapVideoStatistics ={"viewCount": 0,
      "likeCount": 0,
      "favoriteCount": 0,
      "commentCount": 0};
      return mapVideoStatistics;
  }


  Future<List<VideoModel>> getVideos() async{
    String _path = "${pathProduction}/search?part=snippet&key=${apiKey}&maxResults=20&regionCode=PE";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> mapVideo = json.decode(response.body);
      List videos = mapVideo["items"];
      List<VideoModel> videoModelList = videos.map((e) => VideoModel.fromJson(e)).toList();
/*
      videoModelList.forEach((video) async{
        Map<String, dynamic>? mapVideoStatistics = await getVideoStatistics(video.id.videoId);
        print("El videoId antes de traer las estadisticas es: ${video.id.videoId}");
        if(mapVideoStatistics != null){
          video.viewCount = int.parse(mapVideoStatistics["viewCount"].toString());
          video.likeCount = int.parse(mapVideoStatistics["likeCount"].toString());
          video.favoriteCount = int.parse(mapVideoStatistics["favoriteCount"].toString());
          video.commentCount = int.parse(mapVideoStatistics["commentCount"].toString());
          print(video.viewCount );
        }else{
          video.viewCount = 0;
          video.likeCount = 0;
          video.favoriteCount = 0;
          video.commentCount = 0;
        }
      });
*/
      return videoModelList;
    }
    return [];
  }

  Future<List<CommentModel>> getCommentsVideo(String videoId) async{
    String _path = "${pathProduction}/commentThreads?part=snippet,replies&key=${apiKey}&videoId=${videoId}";
//    https://youtube.googleapis.com/youtube/v3/commentThreads?part=snippet,replies&videoId=WBd77lSqIvw&key=AIzaSyDQCVFbpXUb8a7NlMLKwto1e-AfhgmmECQ
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> mapComments = json.decode(response.body);
      List commentsVideo = mapComments["items"];
      List<CommentModel> commentsVideolList = commentsVideo.map((e) => CommentModel.fromJson(e)).toList();

      return commentsVideolList;
    }
    return [];
  }

  Future<List<PlayListItemsModel>> getPlayListItems(String playlistId) async{
    String _path = "${pathProduction}/playlistItems?part=snippet,contentDetails,status&key=${apiKey}&playlistId=${playlistId}";
    print(_path);
//    https://youtube.googleapis.com/youtube/v3/playlistItems?part= snippet,contentDetails,status&playlistId=UU7tiuptCKrRGZNDQJ53Q11w&key=AIzaSyDQCVFbpXUb8a7NlMLKwto1e-AfhgmmECQ
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> mapPlayListItems = json.decode(response.body);
      List playListItems = mapPlayListItems["items"];
      List<PlayListItemsModel> playListItemsList = playListItems.map((e) => PlayListItemsModel.fromJson(e)).toList();

      return playListItemsList;
    }
    return [];
  }

  Future<ChannelModel?> getChannel(String channelId) async{
    String _path = "${pathProduction}/channels?part=snippet,brandingSettings,contentDetails,topicDetails,statistics&id=$channelId&key=${apiKey}";
    Uri _uri = Uri.parse(_path);
    http.Response response = await http.get(_uri);
    if(response.statusCode == 200){
      Map<String, dynamic> myMap = json.decode(response.body);
      Map<String, dynamic> channelMap = myMap["items"][0];
      ChannelModel channelModel = ChannelModel.fromJson(channelMap);
      return channelModel;
    }
    return null;
  }




}