import 'package:flutter/material.dart';
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';

class PopularCard extends StatelessWidget {
  final ArticleModel modelar;
  const PopularCard({super.key, required this.modelar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[300],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                (modelar.urlToImage != null && modelar.urlToImage!.isNotEmpty)
                ? Image.network(
                    modelar.urlToImage!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 40),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 40),
                  ),
          ),
        ),

        const SizedBox(height: 8),
        Container(
          width: 200,
          child: Text(
            modelar.title ?? "No Title",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),

        const SizedBox(height: 4),

        // Author
        Text(
          modelar.author ?? "Unknown Author",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
