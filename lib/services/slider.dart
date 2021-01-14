class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Simple interface, easy to use, easy to see");
  sliderModel.setTitle("Notes Faster");
  sliderModel.setImageAssetPath("assets/images/step1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Provided many options to help you");
  sliderModel.setTitle("Smarter Notes");
  sliderModel.setImageAssetPath("assets/images/step2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Statistics of all work done and not completed");
  sliderModel.setTitle("Statistics");
  sliderModel.setImageAssetPath("assets/images/step3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
