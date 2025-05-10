import 'package:go_router/go_router.dart';
import 'package:movilizate/core/routes/app_routes.dart';
import 'package:movilizate/views/auth/login_page.dart';
import 'package:movilizate/views/fuel/fuel_page.dart';
import 'package:movilizate/views/navigation/navigation_bar_page.dart';
import 'package:movilizate/views/splash/splash_page.dart';

GoRouter appRouter() => GoRouter(
  // Cambiar initialLocation al splash
  initialLocation: AppRoutes.splash,
  routes: publicRoutes(),
);

List<RouteBase> publicRoutes() => [
  /* <---- AUTH -----> */
  GoRoute(
    path: AppRoutes.splash,
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: AppRoutes.navigation,
    builder: (context, state) => const NavigationBarPage(),
  ),
  GoRoute(
    path: AppRoutes.authLogin,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: AppRoutes.fuelStationPage,
    builder: (context, state) => const FuelPage(),
  ),
];
