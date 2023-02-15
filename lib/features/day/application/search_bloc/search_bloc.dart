import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_students/features/day/application/search_bloc/search_events.dart';
import 'package:my_students/features/day/application/search_bloc/search_states.dart';

import '../../data/dataSource/student_remote_datasource_imp.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  SearchBloc() : super(SearchInitialState());
  StudentRemoteDataSourceImp studentRemoteDataSourceImp =
      StudentRemoteDataSourceImp();
  // ignore: prefer_typing_uninitialized_variables
  var students;
  TextEditingController searchController = TextEditingController();
  Stream<SearchStates> mapEventToState(SearchEvents event) async* {
    try {
      if (event is GetSearchResultsEvent) {
        yield SearchLoadingState();
        students = await studentRemoteDataSourceImp.getStudents();
        yield SearchLoadedState(students);
      }
    } catch (e) {
      yield SearchErrorState(e.toString());
    }
  }
}
