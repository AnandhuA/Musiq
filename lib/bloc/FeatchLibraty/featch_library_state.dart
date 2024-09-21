part of 'featch_library_cubit.dart';

@immutable
sealed class FeatchLibraryState {}

final class FeatchLibraryInitial extends FeatchLibraryState {}

final class FeatchLibraryLaodingState extends FeatchLibraryState {}

final class FeatchLibrarySuccessState extends FeatchLibraryState {
  final List< LibraryModel> libraryModel;

  FeatchLibrarySuccessState({required this.libraryModel});
}

final class FeatchLibraryErrorState extends FeatchLibraryState {}
