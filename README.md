# MindCare - Digital Psychological Intervention System

A comprehensive digital mental health platform designed specifically for college students, providing stigma-free support through multiple interfaces including mobile app and web dashboard.

## 🌟 Features

### Mobile App (Flutter)
- **AI Chatbot Support**: Interactive mental health assistant with quick-reply buttons
- **Resources Hub**: Multilingual guides, audio meditations, and video content
- **Peer Support Community**: Anonymous posting and safe space for students
- **Personal Profile**: Wellness check-ins, mood tracking, and progress monitoring

### Web Dashboard
- **Student Portal**: Comprehensive mental health tracking and resource access
- **Counselor Panel**: Patient management, appointment scheduling, and progress monitoring
- **Admin Analytics**: System-wide insights, risk analysis, and usage metrics
- **Multi-role Support**: Seamless switching between student, counselor, and admin views

## 🏗️ Architecture

### Mobile App Structure
```
lib/
├── main.dart                 # App entry point with platform detection
├── screens/
│   ├── main_navigation.dart  # Bottom navigation controller
│   ├── chatbot_screen.dart   # AI assistant interface
│   ├── resources_screen.dart # Multilingual resource library
│   ├── peer_support_screen.dart # Community features
│   └── profile_screen.dart   # User wellness tracking
└── web/
    ├── web_dashboard.dart    # Main web interface
    ├── dashboard_widgets.dart # Reusable dashboard components
    ├── counselor_panel.dart  # Healthcare provider interface
    └── admin_panel.dart      # System administration
```

### Key Components

#### Mobile Experience
1. **Chatbot Screen**
   - Context-aware AI responses
   - Quick reply buttons for common concerns
   - Continuous conversation flow
   - Emotional support and resource recommendations

2. **Resources Hub**
   - Multi-language content (English, Hindi, Tamil, Telugu, Bengali, Marathi)
   - Content filtering by category and language
   - Various media types (guides, audio, video)
   - Offline capability for downloaded content

3. **Peer Support Community**
   - Anonymous posting system
   - Safe space guidelines
   - Support groups by topic
   - Community moderation features

4. **Profile & Wellness Tracking**
   - Daily mood check-ins
   - Wellness streak tracking
   - Achievement system
   - Privacy controls

#### Web Dashboard Experience
1. **Student Portal**
   - Comprehensive overview dashboard
   - Advanced analytics and insights
   - Resource management
   - Appointment scheduling

2. **Counselor Panel**
   - Patient management system
   - Schedule and session tracking
   - Risk assessment tools
   - Emergency protocol access

3. **Admin Analytics**
   - System-wide mental health metrics
   - Usage analytics
   - Risk analysis and alerts
   - Report generation

## 🎨 Design Principles

### Stigma-Free Design
- Anonymous interaction options
- Non-clinical, friendly interface
- Warm color schemes and approachable icons
- Emphasis on community and peer support

### Accessibility
- Multi-language support
- Clear typography and high contrast
- Voice interaction capabilities
- Offline functionality for core features

### Privacy & Security
- Anonymous posting systems
- End-to-end encryption for sensitive data
- GDPR compliance
- Granular privacy controls

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Web browser for dashboard testing

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd mind verse
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run on mobile**
   ```bash
   flutter run
   ```

4. **Run on web (dashboard)**
   ```bash
   flutter run -d chrome
   ```

### Platform Detection
The app automatically detects the platform:
- **Mobile/Tablet**: Shows mobile-optimized interface with bottom navigation
- **Web**: Shows dashboard interface with sidebar navigation and role-based views

## 📱 Mobile App Features

### Bottom Navigation Tabs
1. **Chatbot** - AI-powered mental health support
2. **Resources** - Educational content and tools
3. **Community** - Peer support and forums
4. **Profile** - Personal wellness tracking

### Key Screens
- Interactive chatbot with contextual responses
- Filterable resource library with multilingual content
- Anonymous community posting with moderation
- Comprehensive wellness tracking and insights

## 💻 Web Dashboard Features

### Role-Based Access
- **Student View**: Personal dashboard, resources, community
- **Counselor View**: Patient management, scheduling, assessments
- **Admin View**: System analytics, user management, reports

### Dashboard Widgets
- Real-time mental health metrics
- Usage analytics and trends
- Risk assessment tools
- Emergency intervention protocols

## 🔧 Technical Implementation

### State Management
- StatefulWidget for local state
- Provider pattern for global state (future enhancement)
- Reactive UI updates

### Data Persistence
- Local storage for user preferences
- Secure storage for sensitive data
- Cloud sync for cross-device access

### APIs & Integration
- RESTful API architecture
- Real-time chat capabilities
- Push notification system
- Analytics and reporting APIs

## 🌐 Multi-language Support

Supported languages:
- English (Primary)
- Hindi
- Tamil
- Telugu
- Bengali
- Marathi

Content localization includes:
- User interface elements
- Resource content
- Audio meditations
- Emergency contact information

## 🔒 Privacy & Security

### Data Protection
- Anonymous user identification
- Encrypted data transmission
- Secure local storage
- HIPAA-compliant infrastructure

### Privacy Features
- Granular privacy controls
- Anonymous posting options
- Data deletion rights
- Consent management

## 📊 Analytics & Insights

### Student Analytics
- Mood trend tracking
- Resource usage patterns
- Community engagement metrics
- Progress indicators

### System Analytics
- Platform usage statistics
- Resource effectiveness
- Community health metrics
- Risk assessment data

## 🆘 Emergency Features

### Crisis Support
- 24/7 emergency contact system
- Immediate escalation protocols
- Crisis resource directory
- Location-based emergency services

### Risk Assessment
- Automated risk detection
- Counselor alert systems
- Intervention tracking
- Follow-up protocols

## 🤝 Contributing

We welcome contributions to improve MindCare! Please read our contributing guidelines and code of conduct.

### Development Guidelines
- Follow Flutter best practices
- Maintain accessibility standards
- Ensure privacy compliance
- Test on multiple platforms

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support, please contact:
- Technical Issues: [tech-support@mindcare.app]
- Mental Health Crisis: [Emergency contact information]
- General Inquiries: [info@mindcare.app]

## 🙏 Acknowledgments

- Mental health professionals for guidance
- Student community for feedback
- Open source Flutter community
- Accessibility advocates

---

**Important Note**: This application is designed to support mental health but is not a replacement for professional medical advice, diagnosis, or treatment. Always seek the advice of qualified health providers for any mental health concerns.
