# Quiz AI App

[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev/)
[![Dart Version](https://img.shields.io/badge/Dart-3.x-blue.svg)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/IamSmitChitroda/quiz_ai_app)

A cutting-edge, AI-powered quiz application built with Flutter that revolutionizes the learning experience. By combining state-of-the-art artificial intelligence with a sleek, modern user interface, Quiz AI App delivers personalized, engaging, and adaptive learning experiences for users of all levels.

Whether you're a student preparing for exams, a professional looking to expand your knowledge, or an educator creating assessment materials, Quiz AI App provides an intelligent solution for interactive learning and assessment.

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

- **Frontend Framework**: Flutter Web (v3.x)
  - Material Design 3
  - Responsive layouts
  - Web optimized performance
- **State Management**: 
  - BLoC Pattern (flutter_bloc: ^8.x)
  - Cubit for simpler state flows
- **Backend Services**: Firebase
  - Authentication (Email, Google Sign-in)
  - Cloud Firestore (Real-time database)
  - Firebase Hosting
  - Cloud Functions
- **AI Integration**: 
  - OpenAI GPT-4 API for quiz generation
  - GPT-3.5 Turbo for chat support
- **Development Language**: Dart 3.x
- **CI/CD**: 
  - Firebase Hosting
  - GitHub Actions for automated deployment
- **Analytics & Monitoring**:
  - Firebase Analytics
  - Firebase Crashlytics
  - Performance Monitoring

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

## Screenshots

<details>
<summary>Click to view screenshots</summary>

### Dashboard
[Coming Soon]

### Quiz Interface
[Coming Soon]

### AI Chat Support
[Coming Soon]

### Analytics Dashboard
[Coming Soon]

</details>

## Development Roadmap

### Current Version (v1.0.0)
- ✅ AI-powered quiz generation
- ✅ Interactive quiz taking experience
- ✅ User authentication
- ✅ Basic analytics dashboard
- ✅ AI chat support

### Upcoming Features (v1.1.0)
- 🚧 Offline quiz support
- 🚧 Custom quiz templates
- 🚧 Social sharing features
- 🚧 Advanced analytics
- 🚧 Multi-language support

### Future Plans (v2.0.0)
- 📋 Quiz collaboration features
- 📋 Advanced AI adaptivity
- 📋 Gamification elements
- 📋 Educational institution integration
- 📋 Mobile app release

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact & Support

- **Developer**: Smit Chitroda
- **GitHub**: [@IamSmitChitroda](https://github.com/IamSmitChitroda)
- **Live Demo**: [Quiz AI App](https://quiz-ai-app-4bd19.web.app/)
- **Issues**: [GitHub Issues](https://github.com/IamSmitChitroda/quiz_ai_app/issues)
- **Discussions**: [GitHub Discussions](https://github.com/IamSmitChitroda/quiz_ai_app/discussions)

## Show Your Support ⭐

If you find this project useful, please consider:
1. Giving it a star on GitHub
2. Sharing it with others who might benefit
3. Contributing to its development

If you find this project useful, please consider giving it a star on GitHub to show your support!
