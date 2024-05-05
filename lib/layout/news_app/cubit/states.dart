abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavState extends NewsState {}

class NewsBusinessLoadingState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsGetBusinessErorrState extends NewsState
{
  late final String erorr;
  NewsGetBusinessErorrState(this.erorr);
}

class NewsSportsLoadingState extends NewsState {}

class NewsGetSportsSuccessState extends NewsState {}

class NewsGetSportsErorrState extends NewsState
{
  late final String erorr;
  NewsGetSportsErorrState(this.erorr);
}

class NewsScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErorrState extends NewsState
{
  late final String erorr;
  NewsGetScienceErorrState(this.erorr);
}

class NewsSearchLoadingState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchErorrState extends NewsState
{
  late final String erorr;
  NewsGetSearchErorrState(this.erorr);
}
