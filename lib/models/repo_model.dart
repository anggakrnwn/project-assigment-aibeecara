class RepoModel {
  final String name;
  final String description;
  final int stargazersCount;
  final String language;

  RepoModel({
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.language,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] ?? '',
      description: json['description'] ?? 'No description',
      stargazersCount: json['stargazers_count'] ?? 0,
      language: json['language'] ?? 'Unknown',
    );
  }
}
