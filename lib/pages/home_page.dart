import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/menu_card.dart';
import 'list_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = '';
  bool showBanner = false;

  Future<void> getUsername() async {
    username = await AuthService.getUsername();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUsername();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => showBanner = true);
    });
  }

  Future<void> logout() async {
    await AuthService.logout();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '👋 Selamat datang, ${username.isEmpty ? 'Teman' : username}',
        ),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              opacity: showBanner ? 1 : 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 240,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade600, Colors.indigo.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 24,
                        left: 24,
                        child: Text(
                          'Makan Bang!',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Positioned(
                        top: 88,
                        left: 24,
                        right: 24,
                        child: Text(
                          'Jangan lupa makan walau tidak ada yang mengingatkan :)',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.white70),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Kategori Pilihan',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuCard(
                  title: 'Beef',
                  icon: Icons.newspaper,
                  color: Colors.blue,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ListPage(title: 'Beef', endpoint: 'articles'),
                      ),
                    );
                  },
                ),
                MenuCard(
                  title: 'Chicken',
                  icon: Icons.article,
                  color: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ListPage(title: 'Chicken', endpoint: 'blogs'),
                      ),
                    );
                  },
                ),
                MenuCard(
                  title: 'Pork',
                  icon: Icons.analytics,
                  color: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ListPage(
                          title: 'Pork',
                          endpoint: 'reports',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Makan Favorite mu',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Colors.indigo.shade100,
                    child: const Icon(
                      Icons.food_bank,
                      size: 36,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                title: const Text('Makanan Favorite mu'),
              
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ListPage(title: 'Makanan Favorite', endpoint: 'articles'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
