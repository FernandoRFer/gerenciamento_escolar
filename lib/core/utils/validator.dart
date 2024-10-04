mixin Validator {
  String? descripitonValidator(String? value) {
    if (value?.isEmpty ?? true) {
      if (value!.length >= 50) {
        return "máximo de 50 caracteres";
      }
      return "Campo obrigatório";
    }
    return null;
  }

  ///Max 500 Characters
  String? mediumTextValidator(String? value) {
    if (value?.isEmpty ?? true) {
      if (value!.length >= 500) {
        return "máximo de 500 caracteres";
      }
      return "Campo obrigatório";
    }
    return null;
  }
}
