class UserModel {
  final String username;
  final String avatarUrl;
  final String bio;
  final String location;
  final int publicRepos;
  final int followers;
  final int following;

  UserModel({
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.location,
    required this.publicRepos,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      bio: json['bio'] ?? 'No bio available',
      location: json['location'] ?? 'No location',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }
}
