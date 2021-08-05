import 'package:flutter/material.dart';

class SingleEntry extends StatelessWidget {
  final String title;
  final String body;

  const SingleEntry({Key? key, required this.title, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${title}',
                style: Theme.of(context).textTheme.headline2
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${body}',
                  style: Theme.of(context).textTheme.headline5
              ),
            ],
          ),
        ],

      ),
    );
  }
}
