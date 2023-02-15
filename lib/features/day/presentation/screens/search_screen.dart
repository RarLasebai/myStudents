import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_students/core/utils/widgets/top_nav_bar.dart';
import 'package:my_students/features/day/application/search_bloc/search_bloc.dart';
import 'package:my_students/features/day/application/search_bloc/search_events.dart';

class SearchScreen extends StatelessWidget {
  final String? name;
  const SearchScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchBloc()..add(GetSearchResultsEvent(name!)),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                appBar: TopNavBar(
                  "نتائج البحث",
                  isMainScreen: false,
                ),
                body: const Padding(
                    padding: EdgeInsets.only(right: 46.0, left: 21, top: 27),
                    child: Center()))));
  }
}
