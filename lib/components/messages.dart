import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    // print(
    //     "datanya: ${widget.messages[1]["message"].payload["data"][0]["name"]}");
    // print("string : ${widget.messages[1]["message"].payload.toString()}");
    // print('datanya :  ${widget.messages[1]["message"].payload["data"].length}');
    return ListView.separated(
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: widget.messages[index]['isUserMessage']
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(
                        20,
                      ),
                      topRight: const Radius.circular(20),
                      bottomRight: Radius.circular(
                          widget.messages[index]['isUserMessage'] ? 0 : 20),
                      topLeft: Radius.circular(
                          widget.messages[index]['isUserMessage'] ? 20 : 0),
                    ),
                    color: widget.messages[index]['isUserMessage']
                        ? Colors.grey.shade800
                        : Colors.grey.shade900.withOpacity(0.8)),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: widget.messages[index]["message"].payload == null
                    ? Text(
                        widget.messages[index]['message'].text.text[0],
                        style: TextStyle(color: Colors.white),
                      )
                    : buildCard(
                        widget.messages[index]["message"].payload["data"],
                        index)),
          ],
        );
      },
      separatorBuilder: (_, i) =>
          const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
    );
  }

  Widget buildCard(dynamic dataPayload, int index) {
    print(dataPayload.length);
    return Column(
      children: List.generate(
        dataPayload.length,
        (index) =>
            // Column(
            //   children: [
            //     Text(
            //       dataPayload[index]["name"],
            //     ),
            //     Text(
            //       dataPayload[index]["kelas"].toString(),
            //     ),
            //   ],
            // ),
            ListTile(
          leading: Image.network(dataPayload[index]["image"]),
          title: Text(dataPayload[index]["name"]),
          subtitle: Text(
            dataPayload[index]["kelas"].toString(),
          ),
        ),
      ),
    );
  }
}
