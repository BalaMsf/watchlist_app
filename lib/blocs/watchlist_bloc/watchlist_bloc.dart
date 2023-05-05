import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_app/models/watchlist_model.dart';
import '/repos/watchlist_repo.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchListRepo _watchListRepo;

  WatchlistBloc(this._watchListRepo) : super(WatchlistLoadingState()) {
    on<InitWatchlist>((event, emit) async {
      emit(WatchlistLoadingState());
      try {
        final watchlist = await _watchListRepo.getWatchList();
        emit(WatchlistLoadedState(watchlist));
      } catch (e) {
        emit(WatchlistErrorState('Something Went Wrong!'));
      }
    });

    on<FilteredEvent>((event, emit) {
      if (event.watchlistLimit.isNotEmpty) {
        emit(WatchlistLoadingState());
        Iterable<WatchListModel> watchlist;
        event.currentTabIndex == 0
            ? watchlist = event.watchlistLimit.take(30)
            : event.currentTabIndex == 1
                ? watchlist = event.watchlistLimit.getRange(30, 60)
                : watchlist = event.watchlistLimit
                    .getRange(60, event.watchlistLimit.length);
        emit(FilterdState(
            watchlistTabbed: watchlist.toList(),
            watchlistLimit: watchlist.toList(),
            currentTabIndex: event.currentTabIndex,
            query: ''));
      } else {
        emit(WatchlistErrorState('Something Went Wrong!'));
      }
    });

    on<OnSearchEvent>((event, emit) async {
      emit(WatchlistLoadingState());
      if (event.query != '') {
        emit(FilterdState(
            watchlistTabbed: event.watchlistTabbed.toList(),
            watchlistLimit: event.watchlistTabbed
                .toList()
                .where(
                  (element) => element.name
                      .toLowerCase()
                      .contains(event.query!.toLowerCase()),
                )
                .toList(),
            currentTabIndex: event.currentTabIndex,
            query: event.query));
      } else {
        emit(FilterdState(
            watchlistTabbed: event.watchlistTabbed.toList(),
            watchlistLimit: event.watchlistTabbed.toList(),
            currentTabIndex: event.currentTabIndex,
            query: ''));
      }
    });

    on<OnSortEvent>((event, emit) {
      emit(WatchlistLoadingState());
      if (event.selectedSort == 'asc') {
        emit(FilterdState(
            watchlistTabbed: event.watchlistTabbed.toList(),
            watchlistLimit: event.watchlistLimit.toList()
              ..sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id))),
            currentTabIndex: event.currentTabIndex,
            selectedSort: event.selectedSort));
      } else if (event.selectedSort == 'dsc') {
        emit(FilterdState(
            watchlistTabbed: event.watchlistTabbed.toList(),
            watchlistLimit: event.watchlistLimit.take(30).toList()
              ..sort((a, b) => int.parse(b.id).compareTo(int.parse(a.id))),
            currentTabIndex: event.currentTabIndex,
            selectedSort: event.selectedSort));
      }
    });

    on<Reload>((event, emit) async {
      emit(WatchlistLoadingState());
      try {
        final watchlist = await _watchListRepo.getWatchList();
        emit(WatchlistLoadedState(watchlist));
      } catch (e) {
        emit(WatchlistErrorState('Something Went Wrong!'));
      }
    });
  }
}
