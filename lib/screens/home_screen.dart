import 'package:flutter/material.dart';

import '../state/app_state.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'task_manager_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppState _appState = AppState();
  int _currentIndex = 0;

  @override
  void dispose() {
    _appState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _appState,
        builder: (context, _) {
          switch (_currentIndex) {
            case 0:
              return TaskManagerScreen(state: _appState);
            case 1:
              return StatsScreen(state: _appState);
            case 2:
            default:
              return SettingsScreen(state: _appState);
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        key: const Key('bottomNav'),
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.checklist), label: 'Tasks'),
          NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Stats'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
