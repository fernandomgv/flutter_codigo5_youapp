// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
  required  this.kind,
    required    this.etag,
    required  this.id,
    required  this.snippet,
  });

  String kind;
  String etag;
  String id;
  CommentModelSnippet snippet;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    snippet: CommentModelSnippet.fromJson(json["snippet"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": snippet.toJson(),
  };
}

class CommentModelSnippet {
  CommentModelSnippet({
    required    this.videoId,
    required  this.topLevelComment,
    required  this.canReply,
    required  this.totalReplyCount,
    required  this.isPublic,
  });

  String videoId;
  TopLevelComment topLevelComment;
  bool canReply;
  int totalReplyCount;
  bool isPublic;

  factory CommentModelSnippet.fromJson(Map<String, dynamic> json) => CommentModelSnippet(
    videoId: json["videoId"],
    topLevelComment: TopLevelComment.fromJson(json["topLevelComment"]),
    canReply: json["canReply"],
    totalReplyCount: json["totalReplyCount"],
    isPublic: json["isPublic"],
  );

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "topLevelComment": topLevelComment.toJson(),
    "canReply": canReply,
    "totalReplyCount": totalReplyCount,
    "isPublic": isPublic,
  };
}

class TopLevelComment {
  TopLevelComment({
    required    this.kind,
    required  this.etag,
    required  this.id,
    required  this.snippet,
  });

  String kind;
  String etag;
  String id;
  TopLevelCommentSnippet snippet;

  factory TopLevelComment.fromJson(Map<String, dynamic> json) => TopLevelComment(
    kind: json["kind"],
    etag: json["etag"],
    id: json["id"],
    snippet: TopLevelCommentSnippet.fromJson(json["snippet"]),
  );

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "etag": etag,
    "id": id,
    "snippet": snippet.toJson(),
  };
}

class TopLevelCommentSnippet {
  TopLevelCommentSnippet({
    required    this.videoId,
    required  this.textDisplay,
    required  this.textOriginal,
    required  this.authorDisplayName,
    required  this.authorProfileImageUrl,
    required  this.authorChannelUrl,
    required  this.authorChannelId,
    required  this.canRate,
    required  this.viewerRating,
    required  this.likeCount,
    required  this.publishedAt,
    required  this.updatedAt,
  });

  String videoId;
  String textDisplay;
  String textOriginal;
  String authorDisplayName;
  String authorProfileImageUrl;
  String authorChannelUrl;
  AuthorChannelId authorChannelId;
  bool canRate;
  String viewerRating;
  int likeCount;
  DateTime publishedAt;
  DateTime updatedAt;

  factory TopLevelCommentSnippet.fromJson(Map<String, dynamic> json) => TopLevelCommentSnippet(
    videoId: json["videoId"],
    textDisplay: json["textDisplay"],
    textOriginal: json["textOriginal"],
    authorDisplayName: json["authorDisplayName"],
    authorProfileImageUrl: json["authorProfileImageUrl"],
    authorChannelUrl: json["authorChannelUrl"],
    authorChannelId: AuthorChannelId.fromJson(json["authorChannelId"]),
    canRate: json["canRate"],
    viewerRating: json["viewerRating"],
    likeCount: json["likeCount"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "textDisplay": textDisplay,
    "textOriginal": textOriginal,
    "authorDisplayName": authorDisplayName,
    "authorProfileImageUrl": authorProfileImageUrl,
    "authorChannelUrl": authorChannelUrl,
    "authorChannelId": authorChannelId.toJson(),
    "canRate": canRate,
    "viewerRating": viewerRating,
    "likeCount": likeCount,
    "publishedAt": publishedAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class AuthorChannelId {
  AuthorChannelId({
    required    this.value,
  });

  String value;

  factory AuthorChannelId.fromJson(Map<String, dynamic> json) => AuthorChannelId(
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
  };
}
