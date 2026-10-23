import '../models/question.dart';

const List<Question> quizQuestions = [
  Question(
    id: 'q1',
    category: 'Science',
    question: 'Which planet is known as the Red Planet?',
    options: ['Venus', 'Mars', 'Jupiter', 'Mercury'],
    correctAnswerIndex: 1,
    explanation: 'Mars looks reddish because its surface contains iron oxide.',
  ),
  Question(
    id: 'q2',
    category: 'Geography',
    question: 'What is the largest ocean on Earth?',
    options: [
      'Atlantic Ocean',
      'Indian Ocean',
      'Pacific Ocean',
      'Arctic Ocean',
    ],
    correctAnswerIndex: 2,
    explanation: 'The Pacific Ocean is the largest and deepest ocean.',
  ),
  Question(
    id: 'q3',
    category: 'Science',
    question: 'What is the chemical symbol for water?',
    options: ['CO2', 'O2', 'NaCl', 'H2O'],
    correctAnswerIndex: 3,
    explanation:
        'A water molecule contains two hydrogen atoms and one oxygen atom.',
  ),
  Question(
    id: 'q4',
    category: 'Technology',
    question: 'What does CPU stand for?',
    options: [
      'Central Processing Unit',
      'Computer Personal Unit',
      'Central Program Utility',
      'Control Processing User',
    ],
    correctAnswerIndex: 0,
    explanation:
        'The CPU executes instructions and processes data in a computer.',
  ),
  Question(
    id: 'q5',
    category: 'Mathematics',
    question: 'What is 12 × 8?',
    options: ['84', '96', '108', '88'],
    correctAnswerIndex: 1,
    explanation: '12 multiplied by 8 equals 96.',
  ),
  Question(
    id: 'q6',
    category: 'Geography',
    question: 'What is the capital city of Japan?',
    options: ['Seoul', 'Beijing', 'Tokyo', 'Bangkok'],
    correctAnswerIndex: 2,
    explanation: 'Tokyo is the capital of Japan.',
  ),
  Question(
    id: 'q7',
    category: 'Science',
    question: 'Which gas do plants absorb during photosynthesis?',
    options: ['Oxygen', 'Nitrogen', 'Hydrogen', 'Carbon dioxide'],
    correctAnswerIndex: 3,
    explanation:
        'Plants use carbon dioxide, water, and light to produce sugars.',
  ),
  Question(
    id: 'q8',
    category: 'General Knowledge',
    question: 'How many days are there in a leap year?',
    options: ['366', '365', '364', '360'],
    correctAnswerIndex: 0,
    explanation: 'A leap year has 366 days, including February 29.',
  ),
  Question(
    id: 'q9',
    category: 'Technology',
    question: 'Which of these is a programming language?',
    options: ['Bluetooth', 'Python', 'Wi-Fi', 'HDMI'],
    correctAnswerIndex: 1,
    explanation: 'Python is a widely used programming language.',
  ),
  Question(
    id: 'q10',
    category: 'General Knowledge',
    question: 'How many colors are traditionally listed in a rainbow?',
    options: ['Five', 'Six', 'Seven', 'Eight'],
    correctAnswerIndex: 2,
    explanation: 'The traditional list contains seven rainbow colors.',
  ),
];
