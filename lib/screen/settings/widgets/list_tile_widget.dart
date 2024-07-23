import 'package:flutter/material.dart';
import 'package:musiq/core/sized.dart';

class ListTileWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final bool logout;
  final Function onTap;
  final Widget endWidget;

  const ListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    this.logout = false,
    required this.onTap(),
    this.endWidget = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(62, 95, 95, 95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            constWidth10,
            icon,
            constWidth10,
            Text(
              title,
              style: logout
                  ? theme.textTheme.titleMedium?.copyWith(
                      color: Colors.red,
                    )
                  : theme.textTheme.titleMedium,
            ),
            const Spacer(),
            endWidget,
            constWidth10
          ],
        ),
      ),
    );
  }
}

class MultiListTileWidget extends StatelessWidget {
  final Widget icon1;
  final String title1;
  final Widget icon2;
  final String title2;
  final Function onTap1;
  final Function onTap2;
  final Widget endWidget1;
  final Widget endWidget2;

  const MultiListTileWidget({
    super.key,
    required this.icon1,
    required this.title1,
    required this.icon2,
    required this.title2,
    required this.onTap1(),
    required this.onTap2(),
    this.endWidget1 = const SizedBox(),
    this.endWidget2 = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(62, 95, 95, 95),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => onTap1(),
            child: Row(
              children: [
                constWidth10,
                icon1,
                constWidth10,
                Text(
                  title1,
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                endWidget1,
                constWidth10
              ],
            ),
          ),
          const Divider(
            height: 20,
            color: Colors.grey,
          ),
          InkWell(
            onTap: () => onTap2(),
            child: Row(
              children: [
                constWidth10,
                icon2,
                constWidth10,
                Text(
                  title2,
                  style: theme.textTheme.titleMedium,
                ),
                const Spacer(),
                endWidget2,
                constWidth10
              ],
            ),
          ),
        ],
      ),
    );
  }
}
