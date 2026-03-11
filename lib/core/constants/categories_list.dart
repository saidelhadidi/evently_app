import 'package:evently_app/core/models/category_model.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/strings_manager.dart';

abstract class CategoriesList {
  static List<CategoryModel> categories = [
    CategoryModel(
      id: "all",
      name: StringsManager.all,
      icon: AssetsManager.allCategoriesIcon,
      lightImage: "",
      darkImage: "",
    ),
    CategoryModel(
      id: "sport",
      name: StringsManager.sport,
      icon: AssetsManager.sportCategoryIcon,
      lightImage: AssetsManager.sportCategoryLight,
      darkImage: AssetsManager.sportCategoryDark,
    ),
    CategoryModel(
      id: "birthday",
      name: StringsManager.birthday,
      icon: AssetsManager.birthdayCategoryIcon,
      lightImage: AssetsManager.birthdayCategoryLight,
      darkImage: AssetsManager.birthdayCategoryDark,
    ),
    CategoryModel(
      id: "book",
      name: StringsManager.bookClub,
      icon: AssetsManager.bookCategoryIcon,
      lightImage: AssetsManager.bookCategoryLight,
      darkImage: AssetsManager.bookCategoryDark,
    ),
    CategoryModel(
      id: "meeting",
      name: StringsManager.meeting,
      icon: AssetsManager.meetingCategoryIcon,
      lightImage: AssetsManager.meetingCategoryLight,
      darkImage: AssetsManager.meetingCategoryDark,
    ),
    CategoryModel(
      id: "exhibition",
      name: StringsManager.exhibition,
      icon: AssetsManager.exhibitionCategoryIcon,
      lightImage: AssetsManager.exhibitionCategoryLight,
      darkImage: AssetsManager.exhibitionCategoryDark,
    ),
  ];
}
