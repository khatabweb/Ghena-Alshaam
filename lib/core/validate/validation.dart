class Validations {

  static String? email(String? value){
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regexp = RegExp(pattern);
    if(value!.isEmpty) {
      return "الحقل فارغ";
    } else if (!regexp.hasMatch(value)) {
      return 'EX: example@example.com';
    } else {
      return null;
    }
  }

  static String? phone(String? value){
    if(value!.isEmpty) {
      return "الحقل فارغ";
    } else if (value.length != 10) {
      return  "يرجى إدخال رقم الهاتف المكون من 10 أرقام";
    } else {
      return null;
    }
  }

  static String? password(String? value){
    if(value!.isEmpty) {
      return  "الحقل فارغ";
    } else if(value.length < 8) {
      return "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل";
    } else {
      return null;
    }
  }

  static String? conPassword(String? value){
    if(value!.isEmpty) {
      return  "الحقل فارغ";
    } else if(value != password(value)) {
      return "كلمة المرور غير متطابقة";
    } else {
      return null;
    }
  }

  static String? code(String? value){
    if(value!.isEmpty) {
      return  "الحقل فارغ";
    } else if(value.length < 4) {
      return "كود خاطئ";
    } else {
      return null;
    }
  }

  static String? name(String? value){
    if(value!.isEmpty) {
      return "الحقل فارغ";
    } else if(value.length < 3) {
      return "يجب ألا يقل الاسم عن 3 أحرف";
    } else {
      return null;
    }
  }

  static String? any(String? value){
    if(value!.isEmpty) {
      return "الحقل فارغ";
    } else {
      return null;
    }
  }
}