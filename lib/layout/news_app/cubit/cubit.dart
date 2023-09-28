import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/layout/news_app/cubit/steats.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
}
