# MindCare - Project Structure Overview

## 📁 Project Architecture

### Mobile App Screens (`lib/screens/`)

#### `main_navigation.dart`
- **Purpose**: Bottom navigation controller for mobile app
- **Features**:
  - 4 main tabs: Chatbot, Resources, Peer Support, Profile
  - Indexed stack for smooth navigation
  - Custom bottom navigation bar with shadows
  - Icon state management (active/inactive)

#### `chatbot_screen.dart`
- **Purpose**: AI-powered mental health chatbot interface
- **Features**:
  - Interactive message bubbles (user vs bot)
  - Quick reply buttons for common concerns
  - Context-aware responses based on keywords
  - Scrollable conversation history
  - Message timestamps and read receipts
  - Typing indicators simulation

#### `resources_screen.dart`
- **Purpose**: Multilingual resource library
- **Features**:
  - Category filters (Anxiety, Depression, Stress, Sleep, etc.)
  - Language selection (6 supported languages)
  - Resource types: Guides, Audio, Video
  - Duration and difficulty indicators
  - Download capabilities for offline access
  - Search and sorting functionality

#### `peer_support_screen.dart`
- **Purpose**: Anonymous community support platform
- **Features**:
  - Three tabs: Feed, Support Groups, Resources
  - Anonymous posting system
  - Like and comment functionality
  - Safe space guidelines
  - Topic-based support groups
  - Community moderation features
  - Crisis support resources

#### `profile_screen.dart`
- **Purpose**: Personal wellness tracking and user management
- **Features**:
  - Weekly mood tracking visualization
  - Daily check-in system with mood, stress, and sleep metrics
  - Wellness streak tracking
  - Achievement system
  - Recent activity timeline
  - Privacy and safety settings
  - Emergency support access

### Web Dashboard (`lib/web/`)

#### `web_dashboard.dart`
- **Purpose**: Main web dashboard with role-based access
- **Features**:
  - Responsive design (desktop, tablet, mobile)
  - Role switching (Student, Counselor, Admin)
  - Sidebar navigation with collapsible menu
  - Top app bar with search and notifications
  - Emergency alert system
  - Platform detection and adaptive UI

#### `dashboard_widgets.dart`
- **Purpose**: Reusable dashboard components and layouts
- **Features**:
  - Overview tab with wellness metrics
  - Mental health tracker with interactive charts
  - Resource management interface
  - Community integration for web
  - Appointment scheduling system
  - Quick action widgets
  - Progress visualization components

#### `counselor_panel.dart`
- **Purpose**: Healthcare provider interface
- **Features**:
  - Patient management system
  - Today's schedule with appointment details
  - Risk assessment and urgent alerts
  - Patient progress tracking
  - Session notes and documentation
  - Emergency protocol access
  - Communication tools

#### `admin_panel.dart`
- **Purpose**: System administration and analytics
- **Features**:
  - System-wide mental health metrics
  - User engagement analytics
  - Risk analysis and trend identification
  - Resource utilization tracking
  - Crisis intervention statistics
  - Report generation and export
  - Performance monitoring

## 🎨 Design System

### Color Scheme
- **Primary**: #6B73FF (Calming blue-purple)
- **Secondary**: Complementary gradient colors
- **Success**: Green variations for positive states
- **Warning**: Orange for medium-risk indicators
- **Error**: Red for high-risk/emergency states
- **Neutral**: Gray palette for text and backgrounds

### Typography
- **Font Family**: Inter (clean, accessible)
- **Hierarchy**: Clear heading, body, and caption styles
- **Accessibility**: High contrast ratios, scalable fonts

### Component Patterns
- **Cards**: Consistent elevation and rounded corners
- **Buttons**: Primary, secondary, and text variants
- **Forms**: Accessible input fields with clear labels
- **Navigation**: Intuitive icons and clear labeling
- **Feedback**: Toast messages, loading states, error handling

## 🔧 Technical Architecture

### State Management
- **Local State**: StatefulWidget for screen-specific data
- **Cross-Screen**: IndexedStack for tab persistence
- **Future Enhancement**: Provider/Riverpod for global state

### Data Models
- **User**: Anonymous identification, preferences, wellness data
- **Messages**: Chat history, timestamps, user/bot identification
- **Resources**: Content metadata, language, category, media type
- **Posts**: Community content, anonymous authoring, engagement metrics
- **Appointments**: Scheduling, participant, session type, status

### Navigation
- **Mobile**: Bottom navigation with 4 main tabs
- **Web**: Sidebar navigation with role-based menu items
- **Deep Linking**: URL-based navigation for web dashboard
- **Responsive**: Adaptive navigation based on screen size

### Platform Detection
- **Mobile**: Full mobile app experience with native features
- **Web**: Dashboard experience optimized for desktop/tablet
- **Responsive**: Adaptive layouts for different screen sizes
- **Progressive**: Enhanced features based on platform capabilities

## 🚀 Key Features Implementation

### Stigma-Free Design
- Anonymous user system (no personal identification required)
- Non-clinical language and friendly interface
- Peer support emphasis over medical terminology
- Community-driven content and shared experiences

### Accessibility
- Screen reader compatible
- High contrast mode support
- Keyboard navigation
- Multiple language support
- Scalable fonts and UI elements

### Privacy & Security
- Local data storage where possible
- Anonymous posting capabilities
- Granular privacy controls
- Secure communication protocols
- GDPR/HIPAA compliance considerations

### Crisis Support
- Emergency contact integration
- Risk assessment algorithms
- Immediate escalation protocols
- 24/7 support resource directory
- Location-based emergency services

## 📱 Mobile-Specific Features

### Bottom Navigation
- Persistent navigation across all screens
- Visual feedback for active tab
- Badge notifications for new content
- Smooth tab transitions

### Gesture Support
- Pull-to-refresh on content screens
- Swipe gestures for navigation
- Long-press for additional options
- Touch-friendly target sizes

### Offline Capabilities
- Downloaded resource access
- Cached conversation history
- Offline mood tracking
- Sync when connection restored

## 💻 Web-Specific Features

### Dashboard Layout
- Sidebar navigation with expandable sections
- Multi-column layouts for dense information
- Draggable widgets for customization
- Keyboard shortcuts for power users

### Role-Based Access
- Dynamic menu based on user role
- Permission-based feature access
- Role switching for multi-role users
- Audit trails for administrative actions

### Advanced Analytics
- Interactive charts and graphs
- Data export capabilities
- Real-time metrics updates
- Comparative analysis tools

## 🔄 Data Flow

### Mobile App Flow
1. User opens app → Main Navigation
2. Select tab → Load screen content
3. Interact with features → Update local state
4. Sync data → Cloud storage (when available)

### Web Dashboard Flow
1. User accesses web URL → Platform detection
2. Role selection → Load appropriate dashboard
3. Navigate to features → Dynamic content loading
4. Perform actions → Real-time updates and sync

### Cross-Platform Sync
- User preferences synchronized
- Wellness data accessible across platforms
- Resource bookmarks and progress
- Community participation history

## 🛠️ Development Workflow

### Code Organization
- Feature-based folder structure
- Reusable component library
- Platform-specific implementations
- Shared business logic

### Testing Strategy
- Widget tests for UI components
- Integration tests for user flows
- Platform-specific testing
- Accessibility testing

### Performance Optimization
- Lazy loading for large datasets
- Image optimization and caching
- Bundle size optimization
- Network request optimization

This architecture provides a comprehensive mental health support system that is both accessible to students and powerful for healthcare providers and administrators.
