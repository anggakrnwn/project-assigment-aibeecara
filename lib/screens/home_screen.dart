import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/github_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  void _searchUser() {
    final username = _controller.text.trim();
    if (username.isNotEmpty) {
      Provider.of<GithubProvider>(context, listen: false)
          .fetchGithubData(username);
    }
  }

  @override
  Widget build(BuildContext context) {
    final githubProvider = Provider.of<GithubProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Profile Viewer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Github Username',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchUser,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildContent(githubProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(GithubProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    if (provider.user == null) {
      return const Center(child: Text('No user found.'));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildUserCard(provider),
          const SizedBox(height: 20),
          _buildRepoList(provider),
        ],
      ),
    );
  }

  Widget _buildUserCard(GithubProvider provider) {
    final user = provider.user!;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
          radius: 30,
        ),
        title: Text(user.username),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.bio.isNotEmpty) Text(user.bio),
            if (user.location.isNotEmpty) Text('📍 ${user.location}'),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildRepoList(GithubProvider provider) {
    final repos = provider.repos;

    if (repos.isEmpty) {
      return const Text('No repositories found.');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(repo.name),
            subtitle: Text(repo.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text('${repo.stargazersCount}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
