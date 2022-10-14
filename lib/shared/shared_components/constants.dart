import '../../modules/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

String? token = '';

void signOut(context) {
  Cache_Helper.removeData(key: 'token').then((value) {
    navigateToFinish(
      context,
      const LoginScreen(),
    );
  });
}
