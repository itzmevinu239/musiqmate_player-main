import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsCondition extends StatelessWidget {
  TermsCondition({super.key, this.radius = 8, required this.mdFileName1})
      : assert(mdFileName1.contains('.md'));
  final double radius;
  final String mdFileName1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future:
                Future.delayed(const Duration(milliseconds: 150)).then((value) {
              return rootBundle.loadString("assets/Dialogue/$mdFileName1");
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                  data: snapshot.data!,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          )),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: const Text("Close"),
            ),
          )
        ],
      ),
    );
  }
}
