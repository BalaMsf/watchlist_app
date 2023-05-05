import 'package:equatable/equatable.dart';

import '../../models/watchlist_model.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();
}

class InitWatchlist extends WatchlistEvent {
  @override
  List<Object> get props => [];
}

class FilteredEvent extends WatchlistEvent {
  final List<WatchListModel> watchlistLimit;
  final List<WatchListModel> watchlistTabbed;
  final int currentTabIndex;
  final String? query;
  final String? selectedSort;
  const FilteredEvent(
      {required this.watchlistTabbed,
      required this.watchlistLimit,
      required this.currentTabIndex,
      this.query,
      this.selectedSort});
  @override
  List<Object> get props => [watchlistLimit, currentTabIndex];
}

class OnSearchEvent extends FilteredEvent {
  const OnSearchEvent(
      {required super.watchlistTabbed,
      required super.query,
      required super.watchlistLimit,
      required super.currentTabIndex});
  @override
  List<Object> get props => [super.watchlistLimit, super.currentTabIndex];
}

class OnSortEvent extends FilteredEvent {
  const OnSortEvent(
      {required super.watchlistTabbed,
      required super.watchlistLimit,
      required super.currentTabIndex,
      super.selectedSort});
  @override
  List<Object> get props => [super.watchlistLimit, super.currentTabIndex];
}

class Reload extends WatchlistEvent {
  @override
  List<Object> get props => [];
}
