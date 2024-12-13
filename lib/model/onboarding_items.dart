class OnboardingItems {
  final String title;
  final String disc;
  final String imagePath;
  OnboardingItems({
    required this.title,
    required this.disc,
    required this.imagePath,
  });
  factory OnboardingItems.getItems(Map item) {
    return OnboardingItems(
      disc: item["desc"],
      imagePath: item["imagePath"],
      title: item["title"],
    );
  }
}
