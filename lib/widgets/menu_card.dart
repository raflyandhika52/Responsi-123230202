import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? imageUrl;

  const MenuCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        child: imageUrl != null
            ? Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(
                          color: color.withOpacity(0.2),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacity(0.8),
                            color.withOpacity(0.3),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, size: 56, color: Colors.white),
                        const SizedBox(height: 15),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color.withOpacity(0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 60, color: color),
                    const SizedBox(height: 15),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
