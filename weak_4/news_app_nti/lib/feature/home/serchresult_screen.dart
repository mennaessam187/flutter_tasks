import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/widget/container_category.dart';
import 'package:news_app_nti/feature/home/article_screen.dart';
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';

class SearchResultScreen extends StatefulWidget {
  final Map<String, List<ArticleModel>> searchResults;

  const SearchResultScreen({super.key, required this.searchResults});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  String selectedCategory = "general";

  final List<String> categories = [
    "general",
    "business",
    "sports",
    "entertainment",
    "health",
    "science",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search Results",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          // Horizontal category list with counts
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 10, left: 24, right: 24),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                final itemCountInCategory =
                    widget.searchResults[category]?.length ?? 0;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  child: ContainerCategory(
                    isSelectedf: isSelected,
                    children: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "$category($itemCountInCategory)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackFontColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Builder(
              builder: (context) {
                final articles = widget.searchResults[selectedCategory] ?? [];
                if (articles.isEmpty) {
                  return Center(
                    child: Text("No results found in $selectedCategory"),
                  );
                }
                return ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ArticleScreen(article: article),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title ?? "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.blacklightFontColor,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            size: 10,
                                            color: AppColor.blacklightFontColor,
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            article.author ?? "Unknown Author",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColor.blacklightFontColor,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " • ",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.blacklightFontColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: Text(
                                            article.publishedAt ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color:
                                                  AppColor.blacklightFontColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 80,
                              width: 112,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColor.blacklightFontColor,
                                image: article.urlToImage != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          article.urlToImage!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: article.urlToImage == null
                                  ? Icon(
                                      Icons.image,
                                      color: AppColor.blacklightFontColor,
                                      size: 30,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
