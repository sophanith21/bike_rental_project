enum AsyncValueState { loading, error, success }

class AsyncValue<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;

  AsyncValue.loading()
    : data = null,
      error = null,
      state = AsyncValueState.loading;

  AsyncValue.success(this.data) : error = null, state = AsyncValueState.success;

  AsyncValue.error(this.error) : data = null, state = AsyncValueState.error;
}
