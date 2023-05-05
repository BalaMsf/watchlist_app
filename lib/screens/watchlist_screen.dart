import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist_app/models/watchlist_model.dart';

import '../blocs/watchlist_bloc/watchlist_bloc.dart';
import '../blocs/watchlist_bloc/watchlist_event.dart';
import '../blocs/watchlist_bloc/watchlist_state.dart';
import '../repos/watchlist_repo.dart';
import '../theme_bloc/theme_bloc.dart';
import '../themes/dark_theme.dart';
import '../themes/light_theme.dart';
import '../widgets/contact_list.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<WatchListModel> watchlistAll = [];
  List<WatchListModel> watchlisttabbed = [];
  List<WatchListModel> watchlistFiltered = [];
  final TextEditingController _textEditingController = TextEditingController();
  String? isSelected;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    BlocProvider<ThemeBloc>(create: (context) => ThemeBloc());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return RepositoryProvider(
      create: (context) => WatchListRepo(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WatchlistBloc>(
            create: (context) => WatchlistBloc(
              RepositoryProvider.of<WatchListRepo>(context),
            )..add(
                InitWatchlist(),
              ),
          ),
          // BlocProvider(
          //   create: (context) => ThemeBloc(),
          //   child: BlocBuilder<ThemeBloc, ThemeState>(
          //     builder: (context, state) {
          //       ThemeData themeData = lightThemeData;
          //       if (state is ThemeChangeState) {
          //         themeData = state.themeData;
          //       }
          //       return MaterialApp(
          //         theme: themeData,
          //         home: WatchlistScreen(),
          //       );
          //     },
          //   ),
          // )
        ],
        child: Scaffold(
          appBar: applyTheme(context),
          body: SafeArea(
            child: BlocConsumer<WatchlistBloc, WatchlistState>(
              listener: (context, state) {
                if (state is WatchlistLoadedState) {
                  watchlistAll = state.watchlist;
                  context.read<WatchlistBloc>().add(
                        FilteredEvent(
                            watchlistTabbed: watchlisttabbed,
                            watchlistLimit: state.watchlist,
                            currentTabIndex: _tabController.index),
                      );
                }
                if (state is FilterdState) {
                  watchlisttabbed = state.watchlistTabbed;
                  watchlistFiltered = state.watchlistLimit;
                }
              },
              builder: (context, state) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: width,
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: height * 0.02,
                              bottom: height * 0.01),
                          child: TextField(
                            controller: _textEditingController,
                            onChanged: (value) {
                              context.read<WatchlistBloc>().add(
                                    OnSearchEvent(
                                        watchlistTabbed: watchlisttabbed,
                                        query: value.trim(),
                                        watchlistLimit: watchlistFiltered,
                                        currentTabIndex: _tabController.index),
                                  );
                            },
                            style: TextStyle(),
                            decoration: InputDecoration(
                              filled: true,
                              // fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              hintText: "Search..",
                              hintStyle: TextStyle(
                                  fontSize: 20.0,
                                  color: Theme.of(context).hintColor),

                              prefixIcon: const Icon(Icons.search),
                              prefixIconColor: Colors.purple.shade900,
                            ),
                          ),
                        ),
                        TabBar(
                          controller: _tabController,
                          onTap: (tabIndex) {
                            isSelected = '';
                            switch (tabIndex) {
                              case 0:
                                context.read<WatchlistBloc>().add(FilteredEvent(
                                      watchlistTabbed: watchlisttabbed,
                                      watchlistLimit: watchlistAll,
                                      currentTabIndex: tabIndex,
                                    ));
                                _textEditingController.text = '';
                                break;

                              case 1:
                                context.read<WatchlistBloc>().add(FilteredEvent(
                                    watchlistTabbed: watchlisttabbed,
                                    watchlistLimit: watchlistAll,
                                    currentTabIndex: tabIndex));
                                _textEditingController.text = '';
                                break;

                              case 2:
                                context.read<WatchlistBloc>().add(FilteredEvent(
                                    watchlistTabbed: watchlisttabbed,
                                    watchlistLimit: watchlistAll,
                                    currentTabIndex: tabIndex));
                                _textEditingController.text = '';
                                break;
                            }
                          },
                          // labelColor: Colors.black,
                          labelColor: Theme.of(context).secondaryHeaderColor,
                          tabs: const [
                            Tab(
                              text: 'Contact 1',
                            ),
                            Tab(
                              text: 'Contact 2',
                            ),
                            Tab(
                              text: 'Contact 3',
                            ),
                          ],
                        ),
                        watchlistStateHandling(state),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              backgroundColor: const Color(0x00FFFFFF),
                              context: context,
                              builder: (BuildContext context) {
                                return BlocConsumer<WatchlistBloc,
                                    WatchlistState>(
                                  listener: (context, state) {
                                    if (state is FilterdState) {
                                      isSelected = state.selectedSort!;
                                    }
                                  },
                                  builder: (context, state) {
                                    return Container(
                                      height: height * 0.2,
                                      padding: const EdgeInsets.all(15.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Sorting",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Done',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Row(
                                            children: [
                                              const Text(
                                                "Id",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const Spacer(),
                                              TextButton(
                                                onPressed: () {
                                                  // if(state is FilterdState){

                                                  // }
                                                  context
                                                      .read<WatchlistBloc>()
                                                      .add(OnSortEvent(
                                                        watchlistTabbed:
                                                            watchlisttabbed,
                                                        watchlistLimit:
                                                            watchlistFiltered,
                                                        currentTabIndex:
                                                            _tabController
                                                                .index,
                                                        selectedSort: 'asc',
                                                      ));
                                                },
                                                child: Text(
                                                  '0 \u{2193} 9',
                                                  style: TextStyle(
                                                      color: isSelected == null
                                                          ? Colors.black
                                                          : isSelected! == 'asc'
                                                              ? Colors.blue
                                                              : Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<WatchlistBloc>()
                                                      .add(OnSortEvent(
                                                        watchlistTabbed:
                                                            watchlisttabbed,
                                                        watchlistLimit:
                                                            watchlistFiltered,
                                                        currentTabIndex:
                                                            _tabController
                                                                .index,
                                                        selectedSort: 'dsc',
                                                      ));
                                                },
                                                child: Text(
                                                  '9 \u{2191} 0',
                                                  style: TextStyle(
                                                      color: isSelected == null
                                                          ? Colors.black
                                                          : isSelected! == 'dsc'
                                                              ? Colors.blue
                                                              : Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                        child: Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffDDDDDD),
                                blurRadius: 6.0,
                                spreadRadius: 2.0,
                                offset: Offset(0.0, 0.0),
                              )
                            ],
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.sort,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget watchlistStateHandling(WatchlistState state) {
    if (state is WatchlistLoadingState) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is FilterdState) {
      Iterable<WatchListModel> watchList = watchlistFiltered;

      return Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            ContactList(contactList: watchList),
            ContactList(contactList: watchList),
            ContactList(contactList: watchList),
          ],
        ),
      );
    }

    if (state is WatchlistErrorState) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.error),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<WatchlistBloc>().add(Reload());
              },
              child: const Text(
                'Retry',
              ),
            ),
          ],
        ),
      );
    }

    return Container();
  }

  applyTheme(context) {
    return AppBar(
      leading: Icon(
        Icons.menu,
        size: 30,
        color: Colors.white,
      ),
      elevation: 0,
      toolbarHeight: 60,
      title: Text('Watch List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )),
      // backgroundColor: Theme.of(context).primaryColor,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.sunny,
            color: Colors.white,
          ),
          onPressed: () {
            BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(lightTheme()));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.mode_night_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(darkTheme()));
          },
        ),
      ],
    );
  }
}
