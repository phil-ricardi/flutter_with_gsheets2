import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const _kpages = <String, IconData>{
  'home': Icons.add,
  'map': Icons.map,
  'add': Icons.home,
  'message': Icons.message,
  'people': Icons.people,
};

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final user = FirebaseAuth.instance.currentUser!;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        initialIndex: 2,
        animationDuration: const Duration(seconds: 1),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
            title: Text(
              user.email!,
            ),
          ),
          body: Column(
            children: [
              const Text(
                'Signed In as',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                user.email!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.message, size: 32),
                label: const Text(
                  'Send Message',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/invoice'),
                icon: const Icon(Icons.inventory_rounded, size: 32),
                label: const Text(
                  'Invoice',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/contract'),
                icon: const Icon(Icons.inventory_rounded, size: 32),
                label: const Text(
                  'Invoice',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    for (final icon in _kpages.values) Icon(icon, size: 32),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: ConvexAppBar.badge(
            const <int, dynamic>{3: '99+'},
            style: TabStyle.reactCircle,
            items: <TabItem>[
              for (final entry in _kpages.entries)
                TabItem(
                  icon: entry.value,
                  title: entry.key,
                ),
            ],
          ),
        ));
  }
}
