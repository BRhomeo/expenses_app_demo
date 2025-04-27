import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  String _explanation = '';
  String? _selectedAnswer;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does financial wellness mean?',
      'options': [
        'Having a lot of money in my bank account',
        'Feeling financially secure today and having freedom of choice for the future',
        'Not thinking about money at all, ever!',
      ],
      'correctAnswerIndex': 1,
      'explanation':
          'Financial wellness means feeling in control of your money, covering your monthly and seasonal expenses today, and planning for the future with confidence!',
    },
    {
      'question':
          'Do you need to be a financial expert to advance your financial wellness?',
      'options': ['Yes', 'No'],
      'correctAnswerIndex': 1,
      'explanation':
          'No, you don’t need to 1e a financial expert! Just like staying healthy doesn’t require being a doctor, financial wellness is about awareness, taking small steps, making smart decisions, and staying consistent with your money habits.',
    },
    {
      'question':
          'Which of these best describes the journey to financial freedom?',
      'options': [
        'You just need to make more money and everything will work out',
        'There are stages—Dependency → Solvency → Stability → Security → Independence → Freedom',
        'If you’re smart with money, you never have to worry about it',
      ],
      'correctAnswerIndex': 1,
      'explanation':
          'Financial wellness is a journey with clear stages. The goal is to move from one stage to the next through small actionable steps.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _answerQuestion(String selectedOption) {
    setState(() {
      _selectedAnswer = selectedOption;
      _explanation = _questions[_currentQuestionIndex]['explanation'];
      _animationController.forward(from: 0.0); // Start fade-in animation
    });
  }

  void _nextQuestion() {
    setState(() {
      _selectedAnswer = null;
      _explanation = '';
      _animationController.reset();
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Quiz finished - you can navigate to a results screen or do something else
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quiz Finished!')),
        );
      }
    });
  }

  void _learnMore() {
    // Implement your "Learn More" functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Learn More action')),
    );
  }

  void _goToTool() {
    // Implement navigation back to the income/expense tool or another relevant screen
    Navigator.pop(context); // Example: Go back to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final options = currentQuestion['options'] as List<String>;
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz (${_currentQuestionIndex + 1}/${_questions.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _explanation.isEmpty
                      ? () => _answerQuestion(option)
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    backgroundColor: _selectedAnswer == option
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                    foregroundColor: _selectedAnswer == option
                        ? Theme.of(context).colorScheme.onSecondary
                        : null,
                    disabledBackgroundColor: _selectedAnswer == option
                        ? _questions[_currentQuestionIndex]
                                    ['correctAnswerIndex'] ==
                                options.indexOf(option)
                            ? Colors.green[900]
                            : Colors.red[900]
                        : _questions[_currentQuestionIndex]
                                    ['correctAnswerIndex'] ==
                                options.indexOf(option)
                            ? Colors.green[900]
                            : Colors.grey[700],
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                        color: (_selectedAnswer?.length ?? 0) > 0
                            ? Theme.of(context).textTheme.bodyMedium?.color
                            : null),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            if (_explanation.isNotEmpty)
              FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(_explanation),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (_explanation.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _learnMore,
                    child: const Text('Learn More'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: isLastQuestion ? _goToTool : _nextQuestion,
                    child: Text(isLastQuestion ? 'Back to main page' : 'Next'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
