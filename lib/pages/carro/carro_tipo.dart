
enum CarroTipo {
  CLASSICOS,
  ESPORTIVOS,
  LUXO
}

extension CarroTipoExtension on CarroTipo {
  // String get name => describeEnum(this);

  getName() {
    switch (this) {
      case CarroTipo.CLASSICOS:
        return 'classicos';
      case CarroTipo.ESPORTIVOS:
        return 'esportivos';
      case CarroTipo.LUXO:
        return 'luxo';
      default:
        return '';
    }
  }

}