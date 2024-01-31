import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String owner = 'Edith Mary Asiimwe';
  Message selectedMessage = Message(Text(''), '');
  final ScrollController _controller = ScrollController();

  List<Message> messages = [
    Message(
        Text(
            "Hi Allan, I came across your profile on LinkedIn and was impressed by your background in Software Development. We have exciting opportunities at Adidas, and I'd love to discuss how your skills align with our needs."),
        "Edith Mary Asiimwe"),
    Message(
        Text(
            "Hi, thank you for reaching out! I appreciate your kind words. I'm definitely interested in learning more about the opportunities. When would be a good time for us to connect and discuss further?"),
        "Allan Abaho"),
    Message(
        Text(
            "That's great to hear! I'm glad you're open to exploring potential opportunities with us."),
        "Edith Mary Asiimwe"),
    Message(
        Text(
            "How about we schedule a brief call for tomorrow at 2 PM? Does that work for you?"),
        "Edith Mary Asiimwe"),
  ];

  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          owner,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        actions: [
          Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          SizedBox(width: 15),
          Icon(
            Icons.video_call,
            color: Colors.black,
          ),
          SizedBox(width: 15),
          Icon(
            Icons.star_outline,
            color: Colors.black,
          ),
          SizedBox(width: 15),
        ],
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ...messages.map(
                    (e) => Container(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Row(
                              children: [
                                Visibility(
                                  visible: e.sender == 'Edith Mary Asiimwe',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/1.jpg',
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: e.sender == 'Allan Abaho',
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.asset(
                                      'assets/2.jpg',
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  e.sender,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Slidable(
                            startActionPane: ActionPane(
                              children: [
                                SlidableAction(
                                  onPressed: ((context) {
                                    setState(() {
                                      selectedMessage = e;
                                    });
                                  }),
                                  icon: Icons.reply,
                                  backgroundColor: Colors.grey.shade300,
                                ),
                              ],
                              motion: StretchMotion(),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: 55,
                                  bottom: 10,
                                  right: 20,
                                ),
                                child: e.text),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Visibility(
                    visible: selectedMessage.sender != '',
                    child: showSelectedMessage(selectedMessage)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      width: MediaQuery.of(context).size.width * 0.78,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _messageController,
                          decoration: InputDecoration(
                              hintText: 'Write a message...',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column showSelectedMessage(Message message) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.reply, color: Colors.white),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 8, bottom: 4),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/1.jpg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(message.sender),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: message.text,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(Icons.cancel, color: Colors.white),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  void _sendMessage() {
    if (_messageController.text.isEmpty) {
      return;
    }
    Message croppedMessage = selectedMessage;
    if (croppedMessage.sender == '') {
      messages.add(Message(
          Text(
            _messageController.text,
            style: TextStyle(fontSize: 16),
          ),
          'Allan Abaho'));
    } else {
      messages.add(Message(
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/1.jpg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(croppedMessage.sender),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: croppedMessage.text,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    _messageController.text,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          'Allan Abaho'));
    }
    _messageController.clear();
    selectedMessage = Message(Text(''), '');
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {});
  }
}

class Message {
  final Widget text;
  final String sender;

  Message(this.text, this.sender);
}
