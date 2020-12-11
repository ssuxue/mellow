class BooleanExt<T extends Object> {
  T orElse(T block()) {
    if (this is OrElse) {
      return block() ?? Null;
    } else {
      return (this as WithData).data ?? Null;
    }
  }
}

class OrElse extends BooleanExt<Object> {}

class WithData<T> extends BooleanExt<T> {
  final T data;

  WithData(this.data);
}

extension BoolExtension<T> on bool {
  BooleanExt yes(T block()) {
    if (this) {
      return WithData(block());
    } else {
      return OrElse();
    }
  }

  BooleanExt no(T block()) {
    if (this) {
      return OrElse();
    } else {
      return WithData(block());
    }
  }
}
