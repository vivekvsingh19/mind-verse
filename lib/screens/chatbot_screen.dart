import 'package:flutter/material.dart';
import 'dart:math';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> messages = [
    ChatMessage(
      text: "Hello! I'm your MindCare AI companion (Prototype v1.0). I'm here to provide mental health support and coping strategies. How are you feeling today? 🌟\n\n*Note: This is a prototype chatbot for demonstration purposes.*",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
  ];

  final List<String> encouragingMessages = [
    "You're doing great by reaching out! 🌟",
    "Taking care of your mental health is a sign of strength! 💪",
    "Every small step counts in your wellness journey! 🌱",
    "I'm here to support you through this! 🤗",
    "Your feelings are valid and you matter! 💙",
    "You're braver than you believe! ✨",
  ];

  String _getRandomEncouragement() {
    final random = Random();
    return encouragingMessages[random.nextInt(encouragingMessages.length)];
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate bot response
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        messages.add(ChatMessage(
          text: _generateBotResponse(text),
          isUser: false,
          timestamp: DateTime.now(),
        ));
      });
      _scrollToBottom();
      
      // Sometimes send an encouraging follow-up message (prototype feature)
      // if (Random().nextBool() && Random().nextBool()) { // 25% chance
      //   Future.delayed(const Duration(milliseconds: 2000), () {
      //     setState(() {
      //       messages.add(ChatMessage(
      //         text: "${_getRandomEncouragement()}\n\n*[Prototype Feature: Random encouragement]*",
      //         isUser: false,
      //         timestamp: DateTime.now(),
      //       ));
      //     });
      //     _scrollToBottom();
      //   });
      // }
    });
  }

  String _generateBotResponse(String userMessage) {
    String message = userMessage.toLowerCase();
    
    // Enhanced responses with prototype indication
    if (message.contains('anxious') || message.contains('anxiety')) {
      return "I understand you're feeling anxious. 😌 Let's try some breathing exercises together!\n\n🔹 Try the 4-7-8 technique:\n• Breathe in for 4 counts\n• Hold for 7 counts\n• Exhale for 8 counts\n\nWould you like me to guide you through this or suggest other coping strategies?\n\n*[Prototype Response - In full version, this would include audio guidance]*";
    } 
    else if (message.contains('sleep') || message.contains('insomnia') || message.contains("can't sleep")) {
      return "Sleep issues can really affect your wellbeing. 🌙 Here are some evidence-based tips:\n\n🔹 Create a bedtime routine\n🔹 Avoid screens 1 hour before bed\n🔹 Try progressive muscle relaxation\n🔹 Keep your room cool and dark\n\nWould you like me to guide you through a relaxation exercise?\n\n*[Prototype Response - Full version would include personalized sleep tracking]*";
    } 
    else if (message.contains('overwhelmed') || message.contains('stressed') || message.contains('stress')) {
      return "Feeling overwhelmed is completely valid. 🤗 Let's break this down together:\n\n🔹 What's the most urgent thing on your mind right now?\n🔹 Can we identify just ONE small step you can take today?\n🔹 Remember: You don't have to solve everything at once\n\nWould you like to try a quick grounding exercise (5-4-3-2-1 technique)?\n\n*[Prototype Response - Full version would offer personalized stress management plans]*";
    } 
    else if (message.contains('lonely') || message.contains('alone') || message.contains('isolated')) {
      return "I hear you, and I want you to know that feeling lonely doesn't mean you're alone in this journey. 💙\n\n🔹 Your feelings are completely valid\n🔹 Many people experience loneliness\n🔹 Connection can start with small steps\n\nWould you like to explore our peer support community or try some self-compassion exercises?\n\n*[Prototype Response - Full version would connect you with real support groups]*";
    } 
    else if (message.contains('panic') || message.contains('panic attack')) {
      return "I'm here with you. Let's focus on the present moment. 🧘‍♀️\n\n🔹 BREATHE: Take slow, deep breaths\n🔹 GROUND: Name 5 things you can see, 4 you can touch, 3 you can hear\n🔹 REMIND: This feeling will pass\n\nYou're safe right now. Would you like me to guide you through a grounding exercise?\n\n*[Prototype Response - Full version would include crisis intervention features]*";
    } 
    else if (message.contains('yes') && message.contains('please')) {
      return "Wonderful! I'm glad you're open to coping strategies. 🌟 Here are some techniques I can help you with:\n\n🔹 Deep breathing exercises\n🔹 Mindfulness techniques\n🔹 Progressive muscle relaxation\n🔹 Cognitive reframing\n🔹 Grounding exercises\n\nWhich one interests you most, or would you like me to recommend one based on how you're feeling?\n\n*[Prototype Response - Full version would offer interactive guided sessions]*";
    } 
    else if (message.contains('motivation') || message.contains('motivated')) {
      return "Let's find that spark together! ✨ Here are some motivation boosters:\n\n🔹 Remember your 'why' - what matters most to you?\n🔹 Start small - even 1% progress counts\n🔹 Celebrate tiny wins\n🔹 Be kind to yourself\n\nWhat's one small thing you accomplished today, no matter how minor? Sometimes acknowledging progress helps us find motivation for the next step.\n\n*[Prototype Response - Full version would include personalized goal tracking]*";
    } 
    else if (message.contains('sad') || message.contains('depressed') || message.contains('down')) {
      return "Thank you for sharing that with me. Your feelings matter, and it's okay to not be okay sometimes. 💙\n\n🔹 Sadness is a natural human emotion\n🔹 You're taking a positive step by reaching out\n🔹 Small acts of self-care can help\n\nWould you like to try some gentle mood-lifting activities, or would you prefer to talk more about what's contributing to these feelings?\n\n*[Prototype Response - Full version would include mood tracking and professional referrals]*";
    } 
    else if (message.contains('help') || message.contains('support')) {
      return "I'm here to help! 🤝 As your MindCare companion, I can assist with:\n\n🔹 Coping strategies for stress & anxiety\n🔹 Sleep hygiene tips\n🔹 Mindfulness & breathing exercises\n🔹 Emotional support & validation\n🔹 Crisis resources (when needed)\n\nWhat specific area would you like support with today?\n\n*[Prototype Response - Full version would include professional therapy connections]*";
    } 
    else if (message.contains('thank') || message.contains('thanks')) {
      return "You're so welcome! 😊 It takes courage to reach out and prioritize your mental health. I'm proud of you for taking this step.\n\nIs there anything else you'd like to explore together today?\n\n*[Prototype Response - Your wellbeing journey matters]*";
    } 
    else {
      // Default response with more empathy and options
      return "Thank you for sharing that with me. Your feelings and experiences are completely valid. 💙\n\nI'm here to support you. Would you like to:\n\n🔹 Try a quick breathing exercise\n🔹 Explore coping strategies\n🔹 Talk through what's on your mind\n🔹 Learn about mindfulness techniques\n\nWhat feels right for you in this moment?\n\n*[Prototype Response - In the full version, I'd have more personalized responses based on your history]*";
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'AI Chatbot (Prototype)',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey[50],
        child: Column(
          children: [
            // Chat welcome message
            
            
            // Messages list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return MessageBubble(message: message);
                },
              ),
            ),
            
            // Message input
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: _sendMessage,
                      maxLines: null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _sendMessage(_messageController.text),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickReplyButton(String text) {
    return InkWell(
      onTap: () => _sendMessage(text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF4A90E2).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF4A90E2).withOpacity(0.3),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xFF4A90E2),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.psychology,
                color: Theme.of(context).colorScheme.primary,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft: message.isUser ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : Colors.black87,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
