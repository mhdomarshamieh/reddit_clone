class UserModel {
  final String name;
  final String profilePicture;
  final String banner;
  final String uid;
  final bool isAuthenticated; // if guest or not
  final int karma;
  final List<dynamic> awards;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.name,
    required this.profilePicture,
    required this.banner,
    required this.uid,
    required this.isAuthenticated,
    required this.karma,
    required this.awards,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          profilePicture == other.profilePicture &&
          banner == other.banner &&
          uid == other.uid &&
          isAuthenticated == other.isAuthenticated &&
          karma == other.karma &&
          awards == other.awards);

  @override
  int get hashCode =>
      name.hashCode ^
      profilePicture.hashCode ^
      banner.hashCode ^
      uid.hashCode ^
      isAuthenticated.hashCode ^
      karma.hashCode ^
      awards.hashCode;

  @override
  String toString() {
    return 'UseModel{ name: $name, profilePicture: $profilePicture, banner: $banner, uid: $uid, isAuthenticated: $isAuthenticated, karma: $karma, awards: $awards,}';
  }

  UserModel copyWith({
    String? name,
    String? profilePicture,
    String? banner,
    String? uid,
    bool? isAuthenticated,
    int? karma,
    List<dynamic>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePicture': profilePicture,
      'banner': banner,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'karma': karma,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePicture: map['profilePicture'] as String,
      banner: map['banner'] as String,
      uid: map['uid'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      karma: map['karma'] as int,
      awards: map['awards'] as List<dynamic>,
    );
  }

//</editor-fold>
}
