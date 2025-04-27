import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/github_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GithubProfileViewer());
}

class GithubProfileViewer extends StatelessWidget {
  const GithubProfileViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GithubProvider(),
      child: MaterialApp(
        title: 'Github Profile Viewer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
