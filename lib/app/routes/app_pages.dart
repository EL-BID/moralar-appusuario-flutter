import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mega_flutter/mega_flutter.dart';
import 'package:moralar_widgets/moralar_widgets.dart';

import '../modules/answers/bindings/answers_binding.dart';
import '../modules/answers/views/answers_view.dart';
import '../modules/contacts/bindings/contacts_binding.dart';
import '../modules/contacts/views/contacts_view.dart';
import '../modules/course_details/bindings/course_details_binding.dart';
import '../modules/course_details/views/course_details_view.dart';
import '../modules/courses/bindings/courses_binding.dart';
import '../modules/courses/views/courses_view.dart';
import '../modules/create_password/bindings/create_password_binding.dart';
import '../modules/create_password/views/create_password_view.dart';
import '../modules/drawer/drawer.dart';
import '../modules/first_access/bindings/first_access_binding.dart';
import '../modules/first_access/views/first_access_view.dart';
import '../modules/informative/bindings/informative_binding.dart';
import '../modules/informative/views/informative_details_view.dart';
import '../modules/informative/views/informative_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/filed_view.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/properties/bindings/properties_binding.dart';
import '../modules/properties/views/filter_view.dart';
import '../modules/properties/views/properties_view.dart';
import '../modules/property_details/bindings/property_details_binding.dart';
// import '../modules/property_details/views/maps_view.dart';
import '../modules/property_details/views/property_details_view.dart';
import '../modules/quiz/bindings/quiz_binding.dart';
import '../modules/quiz/views/quiz_view.dart';
import '../modules/quizzes/bindings/quizzes_binding.dart';
import '../modules/quizzes/views/quizzes_view.dart';
import '../modules/registration_data/bindings/registration_data_binding.dart';
import '../modules/registration_data/views/family_data_view.dart';
import '../modules/registration_data/views/personal_data_view.dart';
import '../modules/scheduling/bindings/scheduling_binding.dart';
import '../modules/scheduling/views/scheduling_view.dart';
import '../modules/schedulings/bindings/schedulings_binding.dart';
import '../modules/schedulings/views/schedulings_view.dart';
import '../modules/terms/bindings/terms_binding.dart';
import '../modules/terms/views/terms_view.dart';
import '../modules/timeline/bindings/timeline_binding.dart';
import '../modules/timeline/views/timeline_view.dart';
import '../modules/videos/bindings/videos_binding.dart';
import '../modules/videos/views/videos_view.dart';
import '../modules/watch_video/bindings/watch_video_binding.dart';
import '../modules/watch_video/views/watch_video_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(
        onDelayCompleted: () {
          if (MegaFlutter.instance.auth.currentUser != null) {
            final user = MegaFlutter.instance.auth.currentUser as FamilyHolder;
            debugPrint('BEARER TOKEN ${user.token.accessToken}');
            if (user.isFirstAcess == true) {
              Get.offAndToNamed(Routes.LOGIN);
              Get.toNamed(Routes.FIRST_ACCESS);
            } else {
              Get.offAndToNamed(Routes.TIMELINE);
            }
          } else {
            Get.offAndToNamed(Routes.LOGIN);
          }
        },
      ),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(
        onSignedIn: () {
          Get.back();
          Get.offAndToNamed(Routes.TIMELINE);
        },
        recoveryPassword: () => Get.toNamed(Routes.RECOVERY_PASSWORD),
        firstAccess: Routes.FIRST_ACCESS,
        terms: Routes.TERMS,
      ),
    ),
    GetPage(
      name: _Paths.TIMELINE,
      page: () => TimelineView(),
      binding: TimelineBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULINGS,
      page: () => SchedulingsView(),
      binding: SchedulingsBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULING,
      page: () => SchedulingView(),
      binding: SchedulingBinding(),
    ),
    GetPage(
      name: _Paths.QUIZZES,
      page: () => QuizzesView(),
      binding: QuizzesBinding(),
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => QuizView(),
      binding: QuizBinding(),
    ),
    GetPage(
      name: _Paths.COURSES,
      page: () => CoursesView(),
      binding: CoursesBinding(),
    ),
    GetPage(
      name: _Paths.COURSE_DETAILS,
      page: () => CourseDetailsView(),
      binding: CourseDetailsBinding(),
    ),
    GetPage(
      name: _Paths.VIDEOS,
      page: () => VideosView(),
      binding: VideosBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTS,
      page: () => ContactsView(),
      binding: ContactsBinding(),
    ),
    GetPage(
      name: _Paths.PROPERTIES,
      page: () => PropertiesView(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: _Paths.FIRST_ACCESS,
      page: () => FirstAccessView(),
      binding: FirstAccessBinding(),
    ),
    GetPage(
      name: _Paths.PROPERTY_DETAILS,
      page: () => PropertyDetailsView(),
      binding: PropertyDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FILTER,
      page: () => FilterView(),
      binding: PropertiesBinding(),
    ),
    GetPage(
      name: _Paths.INFORMATIVE,
      page: () => InformativeView(),
      binding: InformativeBinding(),
    ),
    GetPage(
      name: _Paths.INFORMATIVE_DETAILS,
      page: () => InformativeDetailView(),
      binding: InformativeBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.FILED,
      page: () => FiledView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_PASSWORD,
      page: () => CreatePasswordView(),
      binding: CreatePasswordBinding(),
    ),
    GetPage(
      name: _Paths.PERSONAL_DATA,
      page: () => PersonalDataView(),
      binding: RegistrationDataBinding(),
    ),
    GetPage(
      name: _Paths.FAMILY_DATA,
      page: () => FamilyDataView(),
      binding: RegistrationDataBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_PASSWORD,
      page: () => RecoveryPasswordView(),
      binding: RecoveryPasswordBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      transition: Transition.leftToRightWithFade,
      page: () => const FamilyDrawer(),
      binding: TimelineBinding(),
    ),
    GetPage(
      name: _Paths.ANSWERS,
      page: () => AnswersView(),
      binding: AnswersBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_VIDEO,
      page: () => WatchVideoView(),
      binding: WatchVideoBinding(),
    ),
    // GetPage(
    //   name: _Paths.MAPS,
    //   page: () => MapsView(),
    //   binding: PropertyDetailsBinding(),
    // ),
    GetPage(
      name: _Paths.TERMS,
      page: () => TermsView(),
      binding: TermsBinding(),
    ),
  ];
}
