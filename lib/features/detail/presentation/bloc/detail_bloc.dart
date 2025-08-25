// BLoC 상태관리 예시입니다.
// 필요에 따라 Provider, Riverpod 등 다른 상태관리 패턴으로 변경 가능합니다.

import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    // 이벤트 처리 구현
  }
}

// TODO: DetailEvent, DetailState 클래스 구현 필요
