import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_projects/models/search_model.dart';
import 'package:flutter_projects/modules/search/bloc/states.dart';

import '../../../shared/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/shared_components/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void searchData(String text) {
    emit(SearchLoadingState());
    Dio_Helper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState(error.toString()));
    });
  }
}
