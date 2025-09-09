# Quiz AI App

A modern, interactive quiz application built with Flutter that leverages AI to generate and manage quizzes.

## Live Demo

🚀 Try it out: [Quiz AI App](https://quiz-ai-app-4bd19.web.app/)

## Overview

Quiz AI App is a web-based application that allows users to:
- Generate AI-powered quizzes
- Take quizzes with interactive UI
- View detailed results and summaries
- Access a dashboard with quiz statistics

## Tech Stack

- **Frontend**: Flutter Web
- **State Management**: BLoC Pattern
- **Backend**: Firebase
- **AI Integration**: OpenAI API (for quiz generation)

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

- **Quiz Generation**: AI-powered quiz creation
- **Interactive UI**: Modern and responsive design
- **Results Summary**: Detailed performance analysis
- **Dashboard**: Quiz management and statistics

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Firebase CLI (for deployment)

### Installation

1. Clone the repository
```bash
git clone https://github.com/IamSmitChitroda/quiz_ai_app.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the application
```bash
flutter run -d chrome --web-hostname localhost --web-port 1887
```

## Building for Production

```bash
flutter build web
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).

## Contact

- Developer: IamSmitChitroda
- Repository: [GitHub](https://github.com/IamSmitChitroda/quiz_ai_app)
- Live Demo: [Quiz AI App](https://quiz-ai-app-4bd19.web.app/)
