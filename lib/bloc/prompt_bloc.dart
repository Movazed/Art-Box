import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:artbox/repos/prompt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promptInitialEvent);
    on<PromptEnteredEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());
    try {
      Uint8List? bytes = await PromptRepo.generateImage(event.prompt);
      if (bytes != null) {
        emit(PromptGeneratingImageSuccessState(bytes));
      } else {
        emit(PromptGeneratingImageErrorState('Failed to generate image.'));
      }
    } catch (e) {
      emit(PromptGeneratingImageErrorState(e.toString()));
    }
  }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    try {
      File imageFile = File('assets/images/prompt.jpg');
      if (imageFile.existsSync()) {
        Uint8List bytes = await imageFile.readAsBytes();
        emit(PromptGeneratingImageSuccessState(bytes));
      } else {
        emit(PromptGeneratingImageErrorState('Initial image file not found at path: ${imageFile.path}'));
      }
    } catch (e) {
      emit(PromptGeneratingImageErrorState(e.toString()));
    }
  }
}
