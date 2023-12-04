import 'package:flutter/material.dart';

class Filters extends StatelessWidget {
  const Filters({super.key, required this.filters});
  final List<String> filters;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: filters.map((filter) => ButtonWidget(title: filter)).toList(),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String title;
  const ButtonWidget({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 7),
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
          alignment: Alignment.center,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
