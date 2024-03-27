import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:neo_cafe_24/features/menu_screen/domain/use_cases/category_use_case.dart';
import 'package:neo_cafe_24/features/profile/domain/entities/profile_entity.dart';
import 'package:neo_cafe_24/features/profile/domain/use_cases/profile_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase profileUseCase;
  ProfileBloc(this.profileUseCase) : super(ProfileInitial()) {
    on<GetProfileInfoEvent>((event, emit) async {
      print('Загрузка пошла');
      emit(
        ProfileLoading(),
      );

      try {
        final profile = await profileUseCase.call(
          NoParams(),
        );
        print('Запрос прошел');
        emit(
          ProfileLoaded(
            profile: profile,
          ),
        );
        print('Вернул состояние');
      } catch (e) {
        emit(
          ProfileError(
            errorText: e.toString(),
          ),
        );
        print(e.toString());
      }
    });
  }
}
