import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/repo_model.dart';
import '../services/github_service.dart';

class GithubProvider extends ChangeNotifier {
  UserModel? _user;
  List<RepoModel> _repos = [];
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get user => _user;
  List<RepoModel> get repos => _repos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchGithubData(String username) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await GithubService.fetchUser(username);
      _repos = await GithubService.fetchRepos(username);
    } catch (e) {
      _errorMessage = e.toString();
      _user = null;
      _repos = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
