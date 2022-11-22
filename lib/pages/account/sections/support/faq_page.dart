import 'package:flutter/material.dart';
import 'package:nuox_project/pages/account/account_services/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../constants/constants.dart';

class FAQPage extends StatelessWidget {
  FAQPage({super.key});
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          centerTitle: true,
          title: const Text("FAQ"),
        ),
        body: SmartRefresher(
          controller: refreshController,
          onRefresh: () async {
            bool result = await accountProvider.getFAQ();
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(15),
            children: [
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              const Divider(
                color: Colors.white,
              ),
              kHeight,
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  //border: Border.all(color: Colors.grey)
                ),
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
        ));
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
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            kHeight5,
            Text(
              "A : $answer",
              style: const TextStyle(
                color: Color.fromARGB(233, 207, 203, 203),
                fontSize: 16,
              ),
            ),
          ],
        ));
  }
}
