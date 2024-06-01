import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:artbox/bloc/prompt_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  late TextEditingController controller;
  late PromptBloc promptBloc;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    promptBloc = PromptBloc();
    promptBloc.add(PromptInitialEvent());
  }

  @override
  void dispose() {
    controller.dispose();
    promptBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generate Images🚀"),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {
          if (state is PromptGeneratingImageErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          if (state is PromptGeneratingImageLoadState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PromptGeneratingImageErrorState) {
            return Center(child: Text("Something went wrong: ${state.errorMessage}"));
          } else if (state is PromptGeneratingImageSuccessState) {
            return buildSuccessState(state);
          } else {
            return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter your prompt",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller,
            cursorColor: Colors.deepPurple,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(12),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 48,
            width: double.maxFinite,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  promptBloc.add(PromptEnteredEvent(prompt: controller.text));
                }
              },
              icon: Icon(Icons.generating_tokens),
              label: Text("Generate"),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSuccessState(PromptGeneratingImageSuccessState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(state.uint8list),
                ),
              ),
            ),
          ),
          Container(
            height: 240,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your prompt",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller,
                  cursorColor: Colors.deepPurple,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  width: double.maxFinite,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                    ),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        promptBloc.add(PromptEnteredEvent(prompt: controller.text));
                      }
                    },
                    icon: Icon(Icons.generating_tokens),
                    label: Text("Generate"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
