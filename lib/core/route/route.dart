import 'package:quiz_lab/view/screens/authentication/email_verification_page/email_verification_screen.dart';
import 'package:quiz_lab/view/screens/authentication/forget_password/resetPassword/reset_password_screen.dart';
import 'package:quiz_lab/view/screens/authentication/forget_password/verification/verification_screen.dart';
import 'package:quiz_lab/view/screens/authentication/login/login_screen.dart';
import 'package:quiz_lab/view/screens/authentication/login/mobile_login_screen.dart';
import 'package:quiz_lab/view/screens/authentication/profile_complete/profile_complete_screen.dart';

import 'package:quiz_lab/view/screens/authentication/signUp/signup_screen.dart';
import 'package:quiz_lab/view/screens/authentication/sms_verification_page/sms_verification_screen.dart';
import 'package:quiz_lab/view/screens/authentication/two_factor_screen/two_factor_verification_screen.dart';
import 'package:quiz_lab/view/screens/coin_history/coin_history_screen.dart';

import 'package:quiz_lab/view/screens/guess_the_word/category/guess_word_catagory_screen.dart';
import 'package:quiz_lab/view/screens/guess_the_word/main_screen/guess_the_word_screen.dart';
import 'package:quiz_lab/view/screens/guess_the_word/result/review/review_screen.dart';
import 'package:quiz_lab/view/screens/guess_the_word/sub_category/guess_word_sub_categories_screen.dart';

import 'package:quiz_lab/view/screens/coin_store/coin_store_webview/coin_store_webview_screen.dart';
import 'package:quiz_lab/view/screens/coin_store/deposit_widget/deposit_screen.dart';
import 'package:quiz_lab/view/screens/exam_zone/review-answer/review_answer-screen.dart';
import 'package:quiz_lab/view/screens/quiz_contest/all_contest_screen/all_contest_screen.dart';
import 'package:quiz_lab/view/screens/exam_zone/exam-result/exam_result_screen.dart';
import 'package:quiz_lab/view/screens/exam_zone/widgets/exam_zone_quiz_screen.dart';

import 'package:quiz_lab/view/screens/play_different/daily_quiz/daily_quiz_questions_screen.dart';
import 'package:quiz_lab/view/screens/play_different/daily_quiz/daily_quiz_result/daily_quiz_result_screen.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/fun_n_learn-result/fun_n_learn_result_screen.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/fun_n_learn_description_screen.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/fun_n_learn_list_screen.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/fun_n_learn_questios_screen.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/fun_n_learn_screen.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/fun_n_learn_sub_categories.dart';
import 'package:quiz_lab/view/screens/play_different/fun_n_learn/review-answer/review_answer_screen.dart';
import 'package:quiz_lab/view/screens/profile/profile-edit/profile_edit_screen.dart';
import 'package:quiz_lab/view/screens/profile/profile_screen.dart';
import 'package:quiz_lab/view/screens/general_quiz/quiz-questions/quiz_question_screen.dart';
import 'package:quiz_lab/view/screens/quiz_contest/review-answer/review_answer_screen.dart';
import 'package:quiz_lab/view/screens/splash/splash_screen.dart';
import 'package:quiz_lab/view/screens/coin_store/coin_store_screen.dart';

import 'package:get/get.dart';

import '../../view/screens/1vs1/find-opponents-screen/find_opponent_screen.dart';
import '../../view/screens/1vs1/one_vs_one_battle_screen.dart';
import '../../view/screens/1vs1/play-with-friends-bottom-sheet/rooms/create-room/create_room_screen.dart';
import '../../view/screens/1vs1/play-with-friends-bottom-sheet/rooms/join-room/join_room_screen.dart';
import '../../view/screens/all-categories/all_categories_screen.dart';
import '../../view/screens/authentication/forget_password/forgetpassword/forget_password_screen.dart';
import '../../view/screens/battle-quiz-section/battle_quiz_question_screen.dart';
import '../../view/screens/battle_quiz_result/battle_quiz_result_screen.dart';
import '../../view/screens/bottom_nav_bar/bottom_navigation_bar_screen.dart';
import '../../view/screens/exam_zone/exam_zone_screen.dart';
import '../../view/screens/home_page/homepage-widgets/home-body-sections/exam_zone_section/exam_zone_homepage_category_screen.dart';
import '../../view/screens/guess_the_word/result/guess_word_result_screen.dart';
import '../../view/screens/all-categories/sub-categories/sub_categories_screen.dart';
import '../../view/screens/intro_section/onboard_intro_screen.dart';
import '../../view/screens/leader_board/leader_board_screen.dart';
import '../../view/screens/general_quiz/quiz-result/quiz_result_screen.dart';
import '../../view/screens/general_quiz/review-answer/review_answer_screen.dart';
import '../../view/screens/play_different/daily_quiz/review-answer/review_answer_screen.dart';
import '../../view/screens/privacy_policy/privacy_policy_screen.dart';
import '../../view/screens/quiz_contest/contest_result_screen/contest_result_screen.dart';
import '../../view/screens/quiz_contest/question_screen/contest_questions_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = '/onboard_screen';
  static const String loginScreen = '/login_screen';
  static const String mobileLoginScreen = '/mobile_login_screen';
  static const String signupScreen = '/signUp_screen';
  static const String forgetpasswordScreen = '/forget_password_screen';
  static const String verificationScreen = '/verification_screen';
  static const String resetPassword = '/reset_password_screen';
  static const String bottomNavBarScreen = '/bottom_navigation_screen';
  static const String allCategories = '/all_categories_screen';
  static const String subCategories = '/sub_categories_screen';
  static const String quizQuestionsScreen = '/quiz_questions_screen';
  static const String quizResultScreen = '/quiz_result_screen';
  static const String profileCompleteScreen = "/profile_complete_screen";
  static const String privacyScreen = "/privacy-screen";
  //battle
  static const String battleQuizQuestionsScreen = '/battleq_uiz_questions_screen';
  static const String battleQuizResultScreen = '/battle_quiz_result_screen';
  static const String reviewAnswerScreen = '/review_answer_screen';
  static const String oneVSoneBattleScreen = '/battle_screen';
  static const String findOpponentScreen = '/find_opponent_screen';
  static const String createRoomScreen = '/create_room_screen';
  static const String joinRoomScreen = '/join_room_screen';
  static const String profileScreen = '/profile_screen';
  static const String profileEditScreen = '/profile__edit_screen';
  static const String coinStroeScreen = '/coin_store_screen';
  static const String badgesScreen = '/badges_screen';
  static const String coinHistoryScreen = '/coin_history_screen';
  static const String notificationScreen = '/notification_screen';
  static const String examZoneScreen = '/exam_zone_screen';
  static const String examZoneCategoryScreen = '/exam_zone_category_screen';
  static const String leaderBoardScreen = '/leader_board_screen';
  // guess the word
  static const String guessTheword = "/gess_the_word";
  static const String guessTheWordCategory = "/gess_the_word_category";
  static const String guessTheWordSubCategory = "/gess_the_word_sub_categroy";
  static const String gessThewordResult = "/gess_the_word_result";
  static const String gessThewordResultReview = "/gess_the_word_result_review";

  static const String examZoneQuestionScreen = '/exam_zone_questions_screen';
  static const String examZoneResultScreen = '/exam_zone_result_screen';
  static const String examZoneReviewAnswerScreen = '/exam_zone_review_answer_screen';

  static const String funNlearnScreenScreen = '/fun_n_learn_screen';
  static const String funNlearnSubCategoryScreenScreen = '/fun_n_learn_sub_category_screen';
  static const String funNlearnListScreen = '/fun_n_learn_list_screen';
  static const String funNlearnQuizScreen = '/fun_n_learn_quiz_screen';
  static const String funNlearnDescriptionScreen = '/fun_n_learn_description_screen';
  static const String funNlearnResultScreen = '/fun_n_learn_result_screen';
  static const String funNlearnResultReviewScreen = '/fun_n_learn_result_review_screen';
  static const String dailyQuizQuestionsScreen = '/daily_quiz_questions_screen';
  static const String dailyQuizresultScreen = '/daily_quiz_result_screen';
  static const String dailyQuizresultReviewScreen = '/daily_quiz_result_review_screen';
  static const String quizContestListscreen = '/quiz_contest_List_screen';
  static const String quizContestQuestionscreen = '/quiz_contest_List_questions_screen';
  static const String emailVerificationScreen = "/verify_email_screen";
  static const String smsVerificationScreen = "/verify_sms_screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String quizContestresultScreen = "/quiz-contest-screen";
  static const String dailyquizContestresultScreen = "/_daily_quiz-contest-screen";
  static const String quizContestreviewScreen = "/quiz_contest_review_screen";
  static const String depositsScreen = "/deposits";
  static const String depositsDetailsScreen = "/deposits_details";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String depositWebViewScreen = '/deposit_webView';

  List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboardScreen, page: () => const OnBoardIntroScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: mobileLoginScreen, page: () => const MobileLoginScreen()),
    GetPage(name: signupScreen, page: () => const SignupScreen()),
    GetPage(name: forgetpasswordScreen, page: () => const ForgetPasswordScreen()),
    GetPage(name: verificationScreen, page: () => const VerificationScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: bottomNavBarScreen, page: () => const BottomNavigationBarScreen()),

    GetPage(name: subCategories, page: () => const SubCategoriesScreen(title: "")),
    GetPage(name: allCategories, page: () => const AllCategoriesScreen()),
    GetPage(name: quizQuestionsScreen, page: () => const QuizQuestionsScreen()),
    GetPage(name: quizResultScreen, page: () => const QuizResultScreen()),
    //battle
    GetPage(name: battleQuizQuestionsScreen, page: () => const BattleQuizQuestionsScreen()),
    GetPage(name: battleQuizResultScreen, page: () => const BattleQuizResultScreen()),

    GetPage(name: reviewAnswerScreen, page: () => const ReviewAnswerScreen()),
    GetPage(name: oneVSoneBattleScreen, page: () => const OneVSOneBattleScreen()),
    GetPage(name: findOpponentScreen, page: () => const FindOpponenetScreen()),
    GetPage(name: createRoomScreen, page: () => const CreateRoomScreen()),
    GetPage(name: joinRoomScreen, page: () => const JoinRoomScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: profileEditScreen, page: () => const ProfileEditScreen()),
    GetPage(name: coinStroeScreen, page: () => const CoinStoreScreen()),
    GetPage(name: coinHistoryScreen, page: () => const CoinHistoryScreen()),
    GetPage(name: examZoneScreen, page: () => const ExamZoneScreen()),
    GetPage(name: examZoneCategoryScreen, page: () => const ExamZoneSection()),
    GetPage(name: leaderBoardScreen, page: () => const LeaderBoardScreen()),

    // guess the word
    GetPage(name: guessTheword, page: () => const GuessThewordScreen()),
    GetPage(name: guessTheWordCategory, page: () => const GestheWordCategoryScreen()),
    GetPage(name: guessTheWordSubCategory, page: () => const GuessWordSubCategoryScreen()),
    GetPage(name: gessThewordResult, page: () => const GuessWordResultScreen()),
    GetPage(name: gessThewordResultReview, page: () => const GuessWordReviewResult()),

    GetPage(name: examZoneQuestionScreen, page: () => const ExamZoneQuizScreen()),
    GetPage(name: funNlearnQuizScreen, page: () => const FunNlearnQuizScreen()),
    GetPage(name: examZoneResultScreen, page: () => const ExamResultScreen()),
    GetPage(name: examZoneReviewAnswerScreen, page: () => const ExamReviewAnswerScreen()),

    GetPage(name: funNlearnScreenScreen, page: () => const FunNLearnScreen()),
    GetPage(name: funNlearnSubCategoryScreenScreen, page: () => const FunNLearnSubCategoriesCardScreen(title: '')),
    GetPage(name: funNlearnListScreen, page: () => const FunNlearnListScreen(title: "")),
    GetPage(name: funNlearnDescriptionScreen, page: () => const FunNLearnDescription()),
    GetPage(name: funNlearnResultScreen, page: () => const FunNlearnResultScreen()),
    GetPage(name: funNlearnResultReviewScreen, page: () => const FunNPlayReviewAnswerScreen()),
    GetPage(name: dailyQuizQuestionsScreen, page: () => const DailyQuizQuestionsScreen()),
    GetPage(name: dailyQuizresultScreen, page: () => const DailyQuizResultScreen()),
    GetPage(name: dailyQuizresultReviewScreen, page: () => const DailyQuizReviewAnswerScreen()),
    GetPage(name: quizContestListscreen, page: () => const AllContestScreen()),
    GetPage(name: quizContestQuestionscreen, page: () => const QuizContestQuestions()),
    GetPage(name: emailVerificationScreen, page: () => EmailVerificationScreen(needSmsVerification: Get.arguments[0], isProfileCompleteEnabled: Get.arguments[1])),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen()),
    GetPage(name: twoFactorScreen, page: () => TwoFactorVerificationScreen(isProfileCompleteEnable: Get.arguments)),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen()),
    GetPage(name: quizContestresultScreen, page: () => const QuizContestResultScreen()),
    GetPage(name: dailyquizContestresultScreen, page: () => const DailyQuizResultScreen()),
    GetPage(name: quizContestreviewScreen, page: () => const QuizContestReviewAnswerScreen()),
    GetPage(
        name: depositsScreen,
        page: () => const NewDepositScreen(
              price: '',
              id: '',
            )),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: depositWebViewScreen, page: () => CoinStroreWebViewScreen(redirectUrl: Get.arguments)),
  ];
}
