class ApiEndPoints {
  // Base Url
  static const String baseUrl = "http://app.acibd.com/vision_bc/api/";
  //Authentication
  static String signIn = "login";
  static String insertSelfie = "selfie_insert";
  static String changePassword = "change_pw";
  //Authentication

  //HomePage
  static String promoList = "get_promo_list";
  static String dashboardData = "get_outlet_by_type_new";

//HomePage

  //Work
  static String beatList = "get_beat";
  static String outletList = "get_cm_outlet_by_beat";
  //Work

//visit store
  static String visitStore = "cm_visit_insert";
  static String giftHandover = "cm_gift_handover_insert";
//visit store
}
