part of 'prompt_bloc.dart';

@immutable
abstract class PromptState {}

class PromptInitial extends PromptState {}

class PromptGeneratingImageLoadState extends PromptState {}

class PromptGeneratingImageSuccessState extends PromptState {
  final Uint8List uint8list;

  PromptGeneratingImageSuccessState(this.uint8list);
}

class PromptGeneratingImageErrorState extends PromptState {
  final String errorMessage;

  PromptGeneratingImageErrorState([this.errorMessage = 'An unknown error occurred']);
}
