import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import '../../../../constants/constants.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("FAQ"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          KHeight20,
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: accountProvider.faqList!.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final datas = accountProvider.faqList!.data![index];
                return QAndAWidget(
                  question: datas.questions.toString(),
                  answer: datas.answer.toString(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class QAndAWidget extends StatelessWidget {
  final String question;
  final String answer;
  const QAndAWidget({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q : $question",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            KHeight5,
            Text(
              "A : $answer",
              style: TextStyle(
                color: Color.fromARGB(233, 207, 203, 203),
                fontSize: 16,
              ),
            ),
          ],
        ));
  }
}
