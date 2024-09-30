/// For Init states with no initial data.
/// if a models is needed please make a custom one e.g. LoginInitState at lib/modules/common/login/cubit
class InitState<T> extends BaseState<T> {
  const InitState();
}

/// For Loading states.
class LoadingState<T> extends BaseState<T> {
  const LoadingState();
}

/// For Pagination if needed.
class LoadMoreState<T> extends BaseState<T> {
  final T data;

  LoadMoreState({required this.data});
}

/// For finished state with models.
class SuccessState<T> extends BaseState<T> {
  final T data;

  SuccessState({required this.data});
}

/// For Error state with optional error message.
class ErrorState<T> extends BaseState<T> {
  final String? msg;

  ErrorState({required this.msg});
}

/// For finished state with no models returned or needed.
class DoneState<T> extends BaseState<T> {
  const DoneState();
}

/// A Shared base class for all cubits states weather it`s shared like above states or custom ones.
class BaseState<T> {
  const BaseState();

  factory BaseState.init() = InitState<T>;

  factory BaseState.done() = DoneState<T>;

  factory BaseState.loading() = LoadingState<T>;

  factory BaseState.loadMore({required T data}) = LoadMoreState<T>;

  factory BaseState.success({required T data}) = SuccessState<T>;

  factory BaseState.error({required String? msg}) = ErrorState<T>;

  T? getSuccessData() {
    if (this is SuccessState) {
      return (this as SuccessState<T>).data;
    } else if (this is LoadMoreState) {
      return (this as LoadMoreState<T>).data;
    }
    return null;
  }

  String? getErrorMessage() {
    if (this is ErrorState) {
      return (this as ErrorState<T>).msg;
    }
    return null;
  }
}