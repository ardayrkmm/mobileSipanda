import 'package:flutter/material.dart';
import 'package:mobilecapstone/providers/chatbot.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/pesan.dart';
import 'package:provider/provider.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController pesan = TextEditingController();
    Widget inputPesan() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        height: 56,
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            color: putih,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(44, 0, 0, 0),
                offset: Offset(5, 4),
                blurRadius: 18,
              )
            ],
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: pesan,
                decoration: InputDecoration(
                    hintText: "Masukan pertayaan",
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
            ),
            IconButton(
                onPressed: () {
                  if (pesan.text.isNotEmpty) {
                    final chat =
                        Provider.of<chatbotProvider>(context, listen: false);
                    chat.addUserMessage(pesan.text);
                    chat.sendMessage(pesan.text);
                    pesan.clear();
                  }
                },
                icon: Image.asset("assets/send.png"))
          ],
        ),
      );
    }

    Widget bagianPesan() {
      return Consumer<chatbotProvider>(
        builder: (context, chatbotProvider, child) {
          return Container(
            margin: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: chatbotProvider.messages.length,
              itemBuilder: (context, index) {
                final pesan = chatbotProvider.messages[index];
                return Pesan(
                  pesan: pesan['text'],
                  bot: pesan['bot'],
                );
              },
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: AppBar(
            titleTextStyle: ijoStyle.copyWith(
                fontSize: 18, letterSpacing: 3, fontWeight: FontWeight.bold),
            title: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/sipanda.png"))),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "SIPANDA",
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          bagianPesan(),
          Align(
            alignment: Alignment.bottomCenter,
            child: inputPesan(),
          )
        ],
      ),
    );
  }
}
