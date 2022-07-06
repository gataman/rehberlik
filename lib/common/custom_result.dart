class CustomResult {
  bool isSuccess;
  String message;
  bool isLoading;
  double linearValue;
  bool hasLinearProgress;

  CustomResult(
      {this.isSuccess = true,
      this.message = "İşlem başarıyla gerçekleşti.",
      this.isLoading = false,
      this.linearValue = 0.0,
      this.hasLinearProgress = false});

  @override
  String toString() {
    return 'CustomResult{isSuccess: $isSuccess, message: $message, isLoading: $isLoading, linearValue: $linearValue, hasLinearProgress: $hasLinearProgress}';
  }
}
