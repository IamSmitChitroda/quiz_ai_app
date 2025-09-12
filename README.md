# Quiz AI App

A modern, interactive quiz application built with Flutter that leverages AI to generate and manage quizzes. This application combines the power of artificial intelligence with an intuitive user interface to create engaging learning experiences.

## Live Demo

🚀 Try it out: [Quiz AI App](https://quiz-ai-app-4bd19.web.app/)

## Overview

Quiz AI App is a sophisticated web-based application that empowers users to:
- Generate personalized AI-powered quizzes on any topic
- Take interactive quizzes with real-time feedback
- View comprehensive results and performance analytics
- Access an intuitive dashboard with detailed quiz statistics
- Chat with AI to clarify concepts and get explanations
- Create and share custom quizzes with others

## Tech Stack

- **Frontend Framework**: Flutter Web
- **State Management**: BLoC (Business Logic Component) Pattern
- **Backend Services**: Firebase (Authentication, Firestore, Hosting)
- **AI Integration**: OpenAI API (GPT for quiz generation and chat)
- **Development Language**: Dart
- **CI/CD**: Firebase Hosting with GitHub Actions
- **Analytics**: Firebase Analytics

## Project Structure

```
lib/
├── core/
│   └── config/          # App configuration files
├── features/
│   ├── dashboard/       # Dashboard feature
│   ├── question_answer/ # Q&A functionality
│   ├── quiz/           # Quiz management
│   └── quiz_generation/ # AI quiz generation
```

## Features

- **AI-Powered Quiz Generation**:
  - Custom quiz creation based on any topic
  - Adjustable difficulty levels
  - Multiple question formats
  
- **Interactive User Interface**:
  - Modern and responsive design
  - Cross-platform compatibility
  - Smooth animations and transitions
  - Mobile-friendly layout

- **Smart Learning Features**:
  - Real-time answer validation
  - Detailed explanations for each question
  - Progress tracking
  - Performance analytics

- **Dashboard & Analytics**:
  - Comprehensive quiz history
  - Performance statistics and trends
  - Topic-wise analysis
  - Progress tracking over time

- **AI Chat Support**:
  - Concept clarification
  - Instant doubt resolution
  - Learning recommendations
  - Interactive explanations

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (2.19.0 or higher)
- Firebase CLI (for deployment)
- OpenAI API key
- A code editor (VS Code recommended)

### Installation

1. Clone the repository
```bash
git clone https://github.com/IamSmitChitroda/quiz_ai_app.git
cd quiz_ai_app
```

2. Set up environment variables
- Create a `.env` file in the root directory
- Add your OpenAI API key and Firebase configuration

3. Install dependencies
```bash
flutter pub get
```

4. Configure Firebase
```bash
firebase login
firebase init
```

5. Run the application
```bash
flutter run -d chrome --web-hostname localhost --web-port 1887
```

6. Access the application
```bash
http://localhost:1887/
```

### Environment Setup

Create a `.env` file with the following variables:
```
OPENAI_API_KEY=your_api_key_here
FIREBASE_API_KEY=your_firebase_api_key
```

## Building for Production

```bash
flutter build web
```

## Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please ensure your PR follows our contribution guidelines.

## Troubleshooting

Common issues and their solutions:

- **Build Errors**: Make sure you have the latest Flutter SDK
- **Firebase Issues**: Verify your Firebase configuration
- **API Errors**: Check your OpenAI API key and usage limits

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

- Developer: IamSmitChitroda
- Email: [Your Email]
- Repository: [GitHub](https://github.com/IamSmitChitroda/quiz_ai_app)
- Live Demo: [Quiz AI App](https://quiz-ai-app-4bd19.web.app/)

## Star ⭐ the Repository

If you find this project useful, please consider giving it a star on GitHub to show your support!
