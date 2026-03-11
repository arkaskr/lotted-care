import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AiDocChatPage extends StatefulWidget {
  const AiDocChatPage({super.key});

  @override
  State<AiDocChatPage> createState() => _AiDocChatPageState();
}

class _AiDocChatPageState extends State<AiDocChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': 'Hello! I\'m Lotted AI, your personal health assistant. Based on what you\'ve shared, I understand you\'re experiencing some symptoms. Let\'s figure this out together. Could you tell me more about how you\'re feeling?',
      'time': 'Recent'
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    
    setState(() {
      _messages.insert(0, {
        'isUser': true,
        'text': _messageController.text,
        'time': 'Just now',
      });
      _messageController.clear();
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.insert(0, {
            'isUser': false,
            'text': 'I see. How long have you been experiencing this, and is the pain or discomfort constant or does it come and go?',
            'time': 'Just now',
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF0D1B2A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F8F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_rounded, color: Color(0xFF2ECC71), size: 18),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lotted AI Doc',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D1B2A),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2ECC71),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Online and ready to help',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF5D6D7E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded, color: Color(0xFF0D1B2A)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(
                  text: message['text'],
                  isUser: message['isUser'],
                  time: message['time'],
                );
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble({required String text, required bool isUser, required String time}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFFE8F8F5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy_rounded, color: Color(0xFF2ECC71), size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: isUser ? const Color(0xFF2ECC71) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: isUser ? const Radius.circular(20) : Radius.zero,
                      bottomRight: isUser ? Radius.zero : const Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser ? Colors.white : const Color(0xFF0D1B2A),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFFAEB6BF),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (isUser) const SizedBox(width: 32), // Spacer to balance out the avatar on left
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                 color: const Color(0xFFF0F4F7),
                 borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                style: const TextStyle(fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: Color(0xFFAEB6BF), fontWeight: FontWeight.normal),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF2ECC71),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2ECC71).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
