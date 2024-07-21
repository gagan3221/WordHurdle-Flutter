import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordhurdle/helper_functions.dart';
import 'package:wordhurdle/hurdle_provider.dart';
import 'package:wordhurdle/keyboard_view.dart';
import 'package:wordhurdle/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<HurdleProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.star,
          color: Colors.amber,
          size: 36,
        ),
        title: Text(
          "Word Hurdle",
          style: TextStyle(
              color: Colors.amber, fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.85,
                child: Consumer<HurdleProvider>(
                  builder: (context, provider, child) =>
                      GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4),
                        itemBuilder: (context, index) {
                          final wordle = provider.hurdleBoard[index];
                          return WordleView(wordle: wordle);
                        },
                        itemCount: provider.hurdleBoard.length,
                      ),
                ),
              ),
            ),
            Consumer<HurdleProvider>(
                builder: (context, provider, child) =>
                    KeyboardView(
                      excludedLetters: provider.excludedLetters,
                      onPress: (value) {
                        provider.inputLetter(value);
                      },
                    )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<HurdleProvider>(
                builder: (context, provider, child) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              provider.deleteLetter();
                            },
                            child: const Text(
                              "DELETE",
                              style: TextStyle(color: Colors.amber),
                            )),
                        Consumer<HurdleProvider>(
                          builder: (context, provider, child) => ElevatedButton(

                              onPressed: () {
                                if(provider.count == 5){
                                  if (!provider.isAValidWord) {
                                    //print("Word is not in dictionary");
                                    showMsg(context, "Not a word in my dictionary");
                                  }
                                  if (provider.shouldCheckForAnswer) {
                                    provider.checkAnswer();
                                  }
                                  if (provider.wins) {
                                    showResult(context: context,
                                        title: "You Won!!!",
                                        body: "The word was ${provider.targetWord}",
                                        onPlayAgain: () {
                                          Navigator.pop(context);
                                          provider.reset();

                                        },
                                        onCancel: () {
                                          Navigator.pop(context);

                                        });
                                  } else if (provider.noAttemptsLeft) {
                                    showResult(context: context,
                                        title: "You Lost!!!",
                                        body: "The word was ${provider.targetWord}",
                                        onPlayAgain: (){
                                          Navigator.pop(context);
                                          provider.reset();


                                        },
                                        onCancel: (){
                                          Navigator.pop(context);
                                        });
                                  }
                                }else{
                                  null;
                                }
                              },
                              child: const Text(
                                "SUBMIT",
                                style: TextStyle(color: Colors.amber),
                              )),
                        ),
                      ],
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
