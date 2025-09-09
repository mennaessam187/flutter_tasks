import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/feature/home/exploreScreen.dart';
import 'package:news_app_nti/feature/home/serchresult_screen.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_cubit.dart';
import 'package:news_app_nti/feature/news/cubit/newsCubit/news_state.dart';

class SearchScreenexplor extends StatefulWidget {
  const SearchScreenexplor({super.key});

  @override
  State<SearchScreenexplor> createState() => _SearchScreenexplorState();
}

class _SearchScreenexplorState extends State<SearchScreenexplor> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.formfieldbackground,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.formfieldbackground,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColor.formfieldbackground,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onFieldSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          await NewsCubit.get(
                            context,
                          ).searchInTopHeadlines(value);
                          final state = NewsCubit.get(context).state;
                          if (state is NewsSearchSuccess) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SearchResultScreen(
                                  searchResults: state.results,
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ExploreScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColor.baseFontColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
