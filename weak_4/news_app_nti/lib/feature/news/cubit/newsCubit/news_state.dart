
import 'package:news_app_nti/feature/myLocation/data/model/newsMode.dart';

abstract class NewsState{}

class NewsInitial extends NewsState{}
class NewsLoading extends NewsState{}
class NewsSuccess extends NewsState
{
  ArticlesResponseModel model;
  NewsSuccess(this.model);
}
class NewsError extends NewsState
{
  String error;
  NewsError(this.error);
}
class NewsLoadingevery extends NewsState{}
class NewsSuccessevery extends NewsState
{
  ArticlesResponseModel model;
  NewsSuccessevery(this.model);
}
class NewsErrorevery extends NewsState
{
  String error;
  NewsErrorevery(this.error);
}
class NewsSearchLoading extends NewsState {}

class NewsSearchSuccess extends NewsState {
  final Map<String, List<ArticleModel>> results;
  NewsSearchSuccess(this.results);
}

class NewsSearchError extends NewsState {
  final String error;
  NewsSearchError(this.error);
}
class AddinBookLoding extends NewsState{

}
class AddinBookLoded extends NewsState{
  List<ArticlesResponseModel> bookMarkModel;
  AddinBookLoded(this.bookMarkModel);
}
class AddinBookError extends NewsState{
 final String error;
  AddinBookError(this.error);
}