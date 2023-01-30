import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/api_service.dart';
import 'package:hor_pao/model/models.dart';
import 'package:hor_pao/state/user/user_state_notifier.dart';

final userRepoProvider = Provider((ref) => ApiServices());

final userDataProvider = FutureProvider<List<User>>((ref) {
  final data = ref.watch(userNotifierProvider.notifier).getUsers();
  return data;
});

final userNotifierProvider = StateNotifierProvider<UserStateNotifier, List<User>>((ref) {
  return UserStateNotifier(
    apiServices: ref.watch(userRepoProvider),
  );
});
