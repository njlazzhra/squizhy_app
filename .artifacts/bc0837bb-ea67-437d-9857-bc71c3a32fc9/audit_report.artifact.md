# Squizhy App Audit Report

This report presents a thorough audit of the existing **Squizhy** Flutter application prior to any further modifications, evaluated against academic presentation standards and Mobile Programming Lab UTS requirements.

---

## A. Existing Project Structure
- **Module**: `squizhy_app` (Flutter project)
- **Core Architecture**:
  - `lib/main.dart`: Root entry point initializing `ChangeNotifierProvider<QuizProvider>` and `MaterialApp` with custom light theme and responsive container layout.
  - `lib/providers/quiz_provider.dart`: Centralized state management for user name, category selection, active questions, score calculation, custom quiz creation, code lookup, and gameplay tracking.
  - `lib/models/`: Data models (`question.dart`, `custom_quiz.dart`).
  - `lib/data/`: `quiz_question.dart` containing pre-built question sets (*Wawasan Umum*, *Matematika Dasar*, *Computer Science*).
  - `lib/theme/`: `app_colors.dart` (Burgundy `#59171B`, Peach `#FED7B8`, Dusty Rose `#B98B7E`, Cream `#F8E6D7`, background `#FFF8F2`), `app_theme.dart` (Light theme with Poppins font family).
  - `lib/widgets/`: Modular reusable widgets (`quiz_option_card.dart`, `score_card.dart`).
  - `lib/screens/`:
    - `splash_screen.dart`: Initial splash screen displaying the brand logo for 2 seconds.
    - `welcome_screen.dart`: Main welcoming screen with brand illustration, top-right info icon, and 3 mode selection buttons.
    - `name_input_screen.dart`: Name input screen that assigns a random standard quiz category upon starting.
    - `quiz_category_screen.dart`: Category selector screen.
    - `quiz_screen.dart`: Standard quiz gameplay screen with progress bar and option cards.
    - `result_screen.dart`: Displays score summary, answer report button, and play again option.
    - `about_screen.dart`: App explanation and usage instructions.
    - `create_quiz_screen.dart`: Form for crafting custom quizzes and setting answer keys and optional explanations.
    - `share_code_screen.dart`: Displays shareable quiz code (`SQZ-XXXX`) with copy-to-clipboard action.
    - `enter_code_screen.dart`: Input screen for joining a shared custom quiz by code.
    - `custom_quiz_screen.dart` & `custom_result_screen.dart`: Gameplay and result screens for custom shared quizzes.
    - `quiz_report_screen.dart` & `custom_quiz_report_screen.dart`: Detailed answer review report with correct/incorrect badges and explanations.

---

## B. Verified Working Features
1. **Splash & Welcome Flow**: Clean branding splash transitioning into a welcoming screen with 3 clear interaction modes.
2. **Standard Quiz (Random Category)**: Name input followed by random assignment of *Wawasan Umum*, *Matematika Dasar*, or *Computer Science*.
3. **Custom Quiz Creator & Sharing**: Teachers/creators can craft quizzes, set options and answer keys, and generate 4-digit codes (`SQZ-XXXX`).
4. **Code-based Quiz Joining**: Students/takers can input a shared code to load and attempt custom quizzes.
5. **Answer Review Report**: Post-quiz review screen breaking down user answers versus correct answers with explanations.
6. **Responsive Layout**: Constrained mobile width container (`max-width: 600px`) preventing awkward stretching on tablets and web viewports.

---

## C. UI/UX Issues
- Spacing consistency and card padding can be polished for a more refined academic presentation look.
- Button hierarchy between primary actions (*Start Standard Quiz*) and secondary actions (*Craft Your Own Quiz*, *Enter Quiz Code*) can be visually distinguished more clearly.

---

## D. Recommended Changes by Screen
1. **Welcome Screen**: Refine spacing and button contrast to emphasize the primary call-to-action while keeping secondary entry points accessible.
2. **Quiz & Result Screens**: Polish typography hierarchy and card elevations for enhanced aesthetic presentation.
3. **Report Screens**: Ensure crisp visual distinction between correct and incorrect result cards.

---

## E. Potential Risks
- Unhandled empty state validation when entering non-existent quiz codes (mitigated by basic SnackBar feedback).
- State loss if provider is disposed outside the root widget tree (mitigated by root `ChangeNotifierProvider`).

---

## F. Proposed Implementation Order
1. Present audit report and wait for user approval.
2. Perform targeted UI/UX refinements (spacing, typography, button hierarchy).
3. Final review against UTS lab rubric before final presentation.
