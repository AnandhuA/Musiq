import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:musiq/data/add_to_library_funtions.dart';
import 'package:musiq/models/library_model.dart';

part 'featch_library_state.dart';

class FeatchLibraryCubit extends Cubit<FeatchLibraryState> {
  FeatchLibraryCubit() : super(FeatchLibraryInitial());

  featchLibrary() async {
    emit(FeatchLibraryLaodingState());
    try {
      final List<LibraryModel> libraryModelList =
          await AddToLibrary.getAllLibraryItems(
              types: ["Artist", "album", "playlist", "mix"]);
      emit(FeatchLibrarySuccessState(libraryModel: libraryModelList));
    } catch (e) {
      log("$e");
    }
  }
}
