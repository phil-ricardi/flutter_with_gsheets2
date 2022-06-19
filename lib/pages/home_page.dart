import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Signed In',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.message, size: 26),
              label: Text(
                'Send Message',
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/invoice'),
              icon: const Icon(Icons.inventory_rounded, size: 26),
              label: Text(
                'Invoice',
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/contract'),
              icon: const Icon(Icons.inventory_rounded, size: 26),
              label: Text(
                'Contract Form',
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/admin'),
              icon: const Icon(Icons.admin_panel_settings,
                  size: 26, color: Colors.red),
              label: Text(
                'Admin',
                style: GoogleFonts.workSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for (final icon in _kpages.values) Icon(icon, size: 28),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: ConvexAppBar.badge(
          const <int, dynamic>{3: '12'},
          style: TabStyle.reactCircle,
          items: <TabItem>[
            for (final entry in _kpages.entries)
              TabItem(
                icon: entry.value,
                title: entry.key,
              ),
          ],
        ),
      ),
    );
  }
}
