part of 'prompt_bloc.dart';

@immutable
abstract class PromptEvent {}

class PromptInitialEvent extends PromptEvent {}

class PromptEnteredEvent extends PromptEvent {
  final String prompt;

  PromptEnteredEvent({required this.prompt});
}
