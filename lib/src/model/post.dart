import 'package:flutter_instagram/src/model/instagram_user.dart';

class Post {
  final String? id;
  final String? thumbnail;
  final String? description;
  final int? likeCount;
  final InstagramUser? user;
  final String? uid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  Post({
    this.id,
    this.thumbnail,
    this.description,
    this.likeCount,
    this.user,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Post.fromJson(String docId, Map<String, dynamic> json) {
    return Post(
      id: json['id'] == null ? '' : json['id'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      description: json['description'] == null ? '' : json['description'] as String,
      likeCount: json['likeCount'] == null ? 0 : json['likeCount'] as int,
      user: json['user'] == null ? null : InstagramUser.fromJson(json['user']),
      uid: json['uid'] == null ? '' : json['uid'] as String,
      createdAt: json['createdAt'] == null ? DateTime.now() : json['createdAt'].toDate(),
      updatedAt: json['updatedAt'] == null ? DateTime.now() : json['updatedAt'].toDate(),
      deletedAt: json['deletedAt'] == null ? null : json['deletedAt'].toDate(),
    );
  }

  factory Post.init(InstagramUser user) {
    var now = DateTime.now();
    return Post(
      thumbnail: '',
      user: user,
      uid: user.uid,
      description: '',
      createdAt: now,
      updatedAt: now,
    );
  }

  Post copyWith({
    String? id,
    String? thumbnail,
    String? description,
    int? likeCount,
    InstagramUser? user,
    String? uid,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return Post(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      user: user ?? this.user,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'description': description,
      'likeCount': likeCount,
      'user': user!.toMap(),
      'uid': uid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
    };
  }
}
