import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class ListPage extends StatelessWidget {
  final String title;
  final String endpoint;

  const ListPage({super.key, required this.title, required this.endpoint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: FutureBuilder<List<ArticleModel>>(
        future: ApiService.fetchData(endpoint),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Gagal memuat konten. Cek koneksi internet. 📶'),
            );
          }

          final data = snapshot.data!;

          if (data.isEmpty) {
            return const Center(child: Text('Data kosong'));
          }

          return ListView.builder(
            itemCount: data.length,

            itemBuilder: (context, index) {
              final item = data[index];

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: InkWell(
                  borderRadius: BorderRadius.circular(15),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailPage(endpoint: endpoint, id: item.id),
                      ),
                    );
                  },

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Hero(
                        tag: item.id,

                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),

                          child: Image.network(
                            item.imageUrl,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              item.title,

                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              item.summary,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
