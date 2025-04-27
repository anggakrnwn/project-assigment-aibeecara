import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/repo_model.dart';

class GithubService {
  static const String baseUrl = 'https://api.github.com/users/';

  // Fetch user profile
  static Future<UserModel> fetchUser(String username) async {
    final response = await http.get(Uri.parse('$baseUrl$username'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  // Fetch user repositories
  static Future<List<RepoModel>> fetchRepos(String username) async {
    final response = await http.get(Uri.parse('$baseUrl$username/repos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((repo) => RepoModel.fromJson(repo)).toList();
    } else {
      throw Exception('Failed to load repositories');
    }
  }
}
