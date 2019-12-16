import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _CardDetailsScreenState createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.cardColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Hero(
        tag: widget.id,
        child: Container(
          color: backgroundColor,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: backgroundColor,
                pinned: true,
                iconTheme: theme.primaryIconTheme.copyWith(color: Colors.black54),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ООО "Агро-Сбыт"',
                        style: theme.textTheme.subhead.copyWith(color: theme.accentColor),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          Text(
                            'Дмитрий Фукалов',
                            style: theme.textTheme.caption.copyWith(color: Colors.black87),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '14 ноя 12:01',
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Добрый день! В связи с небольшой поломкой и поздней загузкой, произошла задержка в сроках доставки груза. Авомобиль на выгрузке будет 20.10.2018',
                        style: theme.textTheme.body1.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Material(
        color: backgroundColor,
        elevation: 8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.newline,
                maxLines: 7,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Написать ответ...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              color: theme.accentColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
