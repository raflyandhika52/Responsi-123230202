import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/article_model.dart';
import '../services/api_service.dart';

class DetailPage extends StatelessWidget {
  final String endpoint;
  final int id;

  const DetailPage({super.key, required this.endpoint, required this.id});

  Future<void> openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ArticleModel>(
        future: ApiService.fetchDetail(endpoint, id),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Gagal memuat detail. Pastikan koneksi internet stabil. 📶',
              ),
            );
          }

          final article = snapshot.data!;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,

                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  background: Hero(
                    tag: article.id,

                    child: Image.network(article.imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        article.title,

                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        article.summary,

                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final article = await ApiService.fetchDetail(endpoint, id);

          openUrl(article.url);
        },

        child: const Icon(Icons.open_in_browser),
      ),
    );
  }
}
