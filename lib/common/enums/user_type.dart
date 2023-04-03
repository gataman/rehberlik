enum UserType { student, teacher }

extension UserTypeExtension on UserType {
  int get type {
    switch (this) {
      case UserType.student:
        return 2;
      case UserType.teacher:
        return 1;

      default:
        return 0;
    }
  }
}
