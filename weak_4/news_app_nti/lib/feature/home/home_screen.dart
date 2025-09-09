import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/utils/image.dart';
import 'package:news_app_nti/core/widget/card_popular.dart';
import 'package:news_app_nti/core/widget/homeAppBar.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_cubit.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_state.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Widget buildImageCard(String image, String title, String subtitle) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
    ),
    child: Stack(
      children: [
        Positioned(
          bottom: 16,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.clip,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 66,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              color: Color.fromRGBO(0, 0, 0, 0.3),
            ),
          ),
        ),
      ],
    ),
  );
}

class _HomeScreenState extends State<HomeScreen> {
  int pageSize = 3;
  String sortby = "popularity";
  int currentPage = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    NewsCubit.get(context).getNewsevery(pageSize: pageSize, sortBy: sortby);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Homeappbar(),
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingevery) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsSuccessevery) {
                  final articles = state.model.articles ?? [];

                  return Column(
                    children: [
                      CarouselSlider.builder(
                        carouselController: _carouselController, // ✅ دلوقتي صح
                        itemCount: articles.length >= 3 ? 3 : articles.length,
                        itemBuilder: (context, index, realIndex) {
                          final article = articles[index];
                          return buildImageCard(
                            article.urlToImage ?? Appimage.welImage,
                            article.title ?? "No Title",
                            article.description ?? "No Description",
                          );
                        },
                        options: CarouselOptions(
                          height: 220,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          autoPlayInterval: Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentPage = index;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnimatedSmoothIndicator(
                        activeIndex: currentPage,
                        count: articles.length >= 3 ? 3 : articles.length,
                        effect: ScrollingDotsEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          spacing: 8,
                          activeDotColor: Colors.indigo,
                          dotColor: Colors.grey.shade300,
                          activeDotScale: 1.2,
                        ),
                        onDotClicked: (index) {
                          _carouselController.animateToPage(index);
                        },
                      ),
                    ],
                  );
                } else if (state is NewsErrorevery) {
                  return Center(child: Text(state.error));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most Popular",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      "See More",
                      style: TextStyle(
                        color: AppColor.baseFontColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<NewsCubit, NewsState>(
              builder: (context, state) {
                if (state is NewsLoadingevery) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NewsSuccessevery) {
                  final articles = state.model.articles ?? [];

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 17);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: articles.length >= 3 ? 3 : articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return PopularCard(modelar: article);
                        },
                      ),
                    ),
                  );
                } else if (state is NewsErrorevery) {
                  return Center(child: Text(state.error));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
