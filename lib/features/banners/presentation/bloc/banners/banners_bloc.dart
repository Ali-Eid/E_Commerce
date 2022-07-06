import 'package:bloc/bloc.dart';
import '../../../domain/entities/banners_entities.dart';
import '../../../domain/usecases/get_img_banners.dart';
import 'package:equatable/equatable.dart';

part 'banners_event.dart';
part 'banners_state.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  final GetImagBannersUseCase getImagBanners;
  BannersBloc({required this.getImagBanners}) : super(BannersInitial()) {
    on<BannersEvent>((event, emit) async {
      if (event is getAllBannersImgEvent) {
        emit(LoadingBannersState());
        final failureOrProducts = await getImagBanners();
        failureOrProducts.fold((l) {
          emit(ErrorBannersState(message: l.toString()));
        }, (r) {
          emit(SuccessgetImgBannersImgStates(banners: r));
        });
      }
    });
  }
}
