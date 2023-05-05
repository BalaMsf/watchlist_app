import 'package:equatable/equatable.dart';
import 'package:watchlist_app/models/watchlist_model.dart';

abstract class WatchlistState extends Equatable {}

class WatchlistLoadingState extends WatchlistState {
  @override
  List<Object> get props => [];
}

class WatchlistLoadedState extends WatchlistState {
  final List<WatchListModel> watchlist;
  WatchlistLoadedState(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class WatchlistErrorState extends WatchlistState {
  final String error;
  WatchlistErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class FilterdState extends WatchlistState {
  final List<WatchListModel> watchlistLimit;
  final List<WatchListModel> watchlistTabbed;
  final int currentTabIndex;
  final String? query;
  final String? selectedSort;
  FilterdState(
      {required this.watchlistLimit,
      required this.currentTabIndex,
      required this.watchlistTabbed,
      this.query,
      this.selectedSort});
  @override
  List<Object> get props => [watchlistLimit, currentTabIndex];
}
