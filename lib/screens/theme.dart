import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  String _explanation = '';
  String? _selectedAnswer;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does financial wellness mean?',
      'options': [
        'Having a lot of money in my bank account',
        'Feeling financially secure today and having freedom of choice for the future',
        'Not thinking about money at all, ever!',
      ],
      'correctAnswer': 'B',
      'explanation':
          'Financial wellness means feeling in control of your money, covering your monthly and seasonal expenses today, and planning for the future with confidence!',
    },
    {
      'question':
          'Do you need to be a financial expert to advance your financial wellness?',
      'options': ['Yes', 'No'],
      'correctAnswer': 'B',
      'explanation':
          'No, you don’t need to be a financial expert! Just like staying healthy doesn’t require being a doctor, financial wellness is about awareness, taking small steps, making smart decisions, and staying consistent with your money habits.',
    },
    {
      'question':
          'Which of these best describes the journey to financial freedom?',
      'options': [
        'You just need to make more money and everything will work out',
        'There are stages—Dependency → Solvency → Stability → Security → Independence → Freedom',
        'If you’re smart with money, you never have to worry about it',
      ],
      'correctAnswer': 'B',
      'explanation':
          'Financial wellness is a journey with clear stages. The goal is to move from one stage to the next through small actionable steps.',
    },
  ];

  void _answerQuestion(String selectedOption) {
    setState(() {
      _selectedAnswer = selectedOption;
      _explanation = _questions[_currentQuestionIndex]['explanation'];
    });
  }

  void _nextQuestion() {
    setState(() {
      _selectedAnswer = null;
      _explanation = '';
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

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final options = currentQuestion['options'] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Quiz (<span class="math-inline">\{\_currentQuestionIndex \+ 1\}/</span>{_questions.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              currentQuestion['question'],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedAnswer == option
                        ? Theme.of(context).colorScheme.secondary
                        : null,
                    foregroundColor: _selectedAnswer == option
                        ? Theme.of(context).colorScheme.onSecondary
                        : null,
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            if (_explanation.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(_explanation),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (_explanation.isNotEmpty)
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: const Text('Next Question'),
                  ),
                const SizedBox(width: 8),
                if (_explanation.isNotEmpty)
                  ElevatedButton(
                    onPressed: _learnMore,
                    child: const Text('Learn More'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
