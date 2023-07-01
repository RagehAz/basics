import 'package:flutter/services.dart';

class Iconz {
  // -----------------------------------------------------------------------------

  const Iconz();

  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkAssetExists(String? bldrsThemeAsset) async {
    bool _exists = false;

    /// This method should check if bldrs_theme asset exists or not
    /// and to be called from the project that depends on bldrs_theme
    if (bldrsThemeAsset != null) {
      await rootBundle.load(bldrsThemeAsset).then((_) {
        _exists = true;
      }).catchError((error) {
        _exists = false;
      });
    }

    return _exists;
  }
  // -----------------------------------------------------------------------------
  /// DEPRECATED : no need to use in package parameter if you use a path that include [libDirectory]
  // static const String bldrsTheme = 'bldrs_theme';
  // -----------------------------------------------------------------------------
  /// DIRECTORY TO PACKAGE
  // static const String packageDirectory = 'packages/basics/super_stop_watch/bldrs_theme';
  /// DIRECTORY TO LIB
  static const String libDirectory = 'packages/basics/super_stop_watch/bldrs_theme';
  // --------------------
  static const String iconDirectory = '$libDirectory/assets/icons';
  static const String _artworkPath = '$libDirectory/assets/aw';
  // --------------------
  /// artworks
  static const String bldrsNameEn = '$_artworkPath/aw_bldrs_name_en.svg' ;
  static const String bldrsNameSquare = '$_artworkPath/aw_bldrs_name_square.svg' ;
  static const String bldrsAppIcon = '$_artworkPath/aw_bldrs_app_icon.png' ;
  static const String bldrsNameSingleLine = '$_artworkPath/aw_bldrs_name_single_line.svg' ;
  static const String whiteGradient = '$_artworkPath/white_gradient.svg';
  static const String blackGradient = '$_artworkPath/black_gradient.svg';
  static const String headerShadow = '$_artworkPath/header_shadow.svg';
  static const String footerShadow = '$_artworkPath/footer_shadow.svg';

  static const String welcomeToBldrsBanner_22x18 = '$_artworkPath/welcome.svg'; /// w22 * h18
  // --------------------
  /// COMMUNICATION
  static const String comApple = '$iconDirectory/com_apple.svg';
  static const String comEmail = '$iconDirectory/com_email.svg';
  static const String comFacebook = '$iconDirectory/com_facebook.svg';
  static const String comFacebookWhite = '$iconDirectory/com_facebook_white.svg';
  static const String comInstagram = '$iconDirectory/com_instagram.svg';
  static const String comLinkedin = '$iconDirectory/com_linkedin.svg';
  static const String comMap = '$iconDirectory/com_map.svg';
  static const String comPhone = '$iconDirectory/com_phone.svg';
  static const String comTwitter = '$iconDirectory/com_twitter.svg';
  static const String comWebsite = '$iconDirectory/com_website.svg';
  static const String comWhatsapp = '$iconDirectory/com_whatsapp.svg';
  static const String comGooglePlay = '$iconDirectory/com_google_play.svg';
  static const String comYoutube = '$iconDirectory/com_youtube.svg';
  static const String comTikTok = '$iconDirectory/com_tiktok.svg';
  static const String comPinterest = '$iconDirectory/com_pinterest.svg';
  static const String comGooglePlus = '$iconDirectory/com_google_plus.svg';
  // --------------------
  /// dev
  static const String dvBlankSVG = '$iconDirectory/dv_blank.svg';
  static const String dvGouran = '$iconDirectory/dv_gouran.svg';
  static const String dvRageh = '$iconDirectory/dv_rageh.svg';
  static const String dvRageh2 = '$iconDirectory/dv_rageh2.svg';
  static const String dvRagehWhite = '$iconDirectory/dv_rageh_white.svg';
  static const String dvRagehIcon = '$iconDirectory/dv_rageh_icon.svg';
  static const String dvBlankPNG = '$iconDirectory/dv_blank.png';
  static const String dvBlackHole = '$iconDirectory/dv_black_hole.png';
  static const String dvDonaldDuck = '$iconDirectory/dv_donald_duck.png';
  // --------------------
  /// FLYER TYPE
  static const String bxPropertiesOn = '$iconDirectory/ft_properties_on.svg';
  static const String bxPropertiesOff = '$iconDirectory/ft_properties_off.svg';
  static const String bxNewPropertiesOn =  '$iconDirectory/ft_properties_new_on.svg';
  static const String bxNewPropertiesOff =  '$iconDirectory/ft_properties_new_off.svg';
  static const String bxResalePropertiesOn =  '$iconDirectory/ft_properties_resale_on.svg';
  static const String bxResalePropertiesOff =  '$iconDirectory/ft_properties_resale_off.svg';
  static const String bxRentPropertiesOn =  '$iconDirectory/ft_properties_rent_on.svg';
  static const String bxRentPropertiesOff =  '$iconDirectory/ft_properties_rent_off.svg';
  static const String bxDesignsOn = '$iconDirectory/ft_designs_on.svg';
  static const String bxDesignsOff = '$iconDirectory/ft_designs_off.svg';
  static const String bxProductsOn = '$iconDirectory/ft_products_on.svg';
  static const String bxProductsOff = '$iconDirectory/ft_products_off.svg';
  static const String bzUndertakingOn = '$iconDirectory/ft_projects_on.svg';
  static const String bxUndertakingOff = '$iconDirectory/ft_projects_off.svg';
  static const String bxTradesOn = '$iconDirectory/ft_trades_on.svg';
  static const String bxTradesOff = '$iconDirectory/ft_trades_off.svg';
  static const String bxEquipmentOn = '$iconDirectory/ft_equipment_on.svg';
  static const String bxEquipmentOff = '$iconDirectory/ft_equipment_off.svg';
  static const String bxOwnerOn = '$iconDirectory/ft_owner_on.svg';
  static const String bxOwnerOff = '$iconDirectory/ft_owner_off.svg';
  // --------------------
  /// GENERAL ICONS
  static const String back = '$iconDirectory/gi_back.svg';
  static const String backArabic = '$iconDirectory/gi_back_arabic.svg';
  static const String dotPyramid = '$iconDirectory/gi_dot_pyramid.svg';
  static const String follow = '$iconDirectory/gi_follow.svg';
  static const String gallery = '$iconDirectory/gi_gallery.svg';
  static const String language = '$iconDirectory/gi_language.svg';
  static const String notification = '$iconDirectory/gi_news.svg';
  static const String password = '$iconDirectory/gi_password.svg';
  static const String save = '$iconDirectory/gi_save.svg';
  static const String saveOff = '$iconDirectory/gi_save_off.svg';
  static const String saveOn = '$iconDirectory/gi_save_on.svg';
  static const String search = '$iconDirectory/gi_search.svg';
  static const String share = '$iconDirectory/gi_share.svg';
  static const String viewsIcon = '$iconDirectory/gi_views.svg';
  static const String filter = '$iconDirectory/gi_filter.svg';
  static const String arrowUp = '$iconDirectory/gi_arrow_up.svg';
  static const String arrowDown = '$iconDirectory/gi_arrow_down.svg';
  static const String arrowRight = '$iconDirectory/gi_arrow_right.svg';
  static const String arrowLeft = '$iconDirectory/gi_arrow_left.svg';
  static const String more = '$iconDirectory/gi_more.svg';
  static const String handShake = '$iconDirectory/gi_handshake.svg';
  static const String savedFlyers = '$iconDirectory/gi_saved_flyers.svg';
  static const String normalUser = '$iconDirectory/gi_normal_user.svg';
  static const String bz = '$iconDirectory/gi_bz.svg';
  static const String bzWhite = '$iconDirectory/gi_bz_white.svg';
  static const String flyer = '$iconDirectory/gi_flyer.svg';
  static const String plus = '$iconDirectory/gi_plus.svg';
  static const String xSmall = '$iconDirectory/gi_small_x.svg';
  static const String check = '$iconDirectory/gi_check.svg';
  static const String xLarge = '$iconDirectory/gi_big_x.svg';
  static const String terms = '$iconDirectory/gi_terms.svg';
  static const String form = '$iconDirectory/gi_form.svg';
  static const String achievement = '$iconDirectory/gi_achievements.svg';
  static const String advertise = '$iconDirectory/gi_advertise.svg';
  static const String marketing = '$iconDirectory/gi_marketing.svg';
  static const String gears = '$iconDirectory/gi_gears.svg';
  static const String exit = '$iconDirectory/gi_exit.svg';
  static const String scholar = '$iconDirectory/gi_scholar.svg';
  static const String earth = '$iconDirectory/gi_earth.svg';
  static const String locationPin = '$iconDirectory/gi_location_pin.svg';
  static const String locationPinBlack = '$iconDirectory/gi_location_pin_black.svg';
  static const String statistics = '$iconDirectory/gi_statistics.svg';
  static const String calendar = '$iconDirectory/gi_calendar.svg';
  static const String dashBoard = '$iconDirectory/gi_dashboard.svg';
  static const String redAlert = '$iconDirectory/gi_red_alert.svg';
  static const String yellowAlert = '$iconDirectory/gi_yellow_alert.svg';
  static const String dollar = '$iconDirectory/gi_dollar.svg';
  static const String camera = '$iconDirectory/gi_camera.svg';
  static const String clock = '$iconDirectory/gi_clock.svg';
  static const String info = '$iconDirectory/gi_info.svg';
  static const String ankhBlack = '$iconDirectory/gi_ankh_black.svg';
  static const String phoneGallery = '$iconDirectory/gi_phone_gallery.svg';
  static const String cameraButton = '$iconDirectory/gi_camera_button.svg';
  static const String addFlyer = '$iconDirectory/gi_add_flyer.svg';
  static const String flyerScale = '$iconDirectory/gi_flyer_scale.svg';
  static const String flyerCollection = '$iconDirectory/gi_flyer_collection.svg';
  static const String flyerGrid = '$iconDirectory/gi_flyer_grid.svg';
  static const String fingerTap = '$iconDirectory/gi_finger_tap.svg';
  static const String flyerPin = '$iconDirectory/gi_flyer_pin.svg';
  static const String flyerPinPNG = '$iconDirectory/gi_flyer_pin_png.png';
  static const String stop = '$iconDirectory/gi_stop.svg';
  static const String play = '$iconDirectory/gi_play.svg';
  static const String pause = '$iconDirectory/gi_pause.svg';
  static const String bigMac = '$iconDirectory/gi_bigmac.svg';
  static const String verifyFlyer =  '$iconDirectory/gi_verify_flyer.svg';
  static const String phone =  '$iconDirectory/gi_phone.svg';
  static const String users =  '$iconDirectory/gi_users.svg';
  static const String star =  '$iconDirectory/gi_star.svg';
  static const String sexyStar = '$iconDirectory/gi_sexy_star.svg';
  static const String emoji =  '$iconDirectory/gi_emoji.svg';
  static const String keyword =  '$iconDirectory/gi_keyword.svg';
  static const String mobilePhone =  '$iconDirectory/gi_phone.svg';
  static const String target =  '$iconDirectory/gi_target.svg';
  static const String power =  '$iconDirectory/gi_power.svg';
  static const String circleDot =  '$iconDirectory/gi_circle_dot.svg';
  static const String reload =  '$iconDirectory/gi_reload.svg';
  static const String lab = '$iconDirectory/gi_lab.svg';
  static const String cleopatra = '$iconDirectory/gi_cleopatra.svg';
  static const String sphinx = '$iconDirectory/gi_sphinx.svg';
  static const String keywords = '$iconDirectory/gi_keywords.svg';
  static const String paste = '$iconDirectory/gi_paste.svg';
  static const String male = '$iconDirectory/gi_male.svg';
  static const String female = '$iconDirectory/gi_female.svg';
  static const String crop = '$iconDirectory/gi_crop.svg';
  static const String resize = '$iconDirectory/gi_resize.svg';
  static const String flag = '$iconDirectory/gi_flag.svg';
  static const String spark = '$iconDirectory/gi_spark.svg';
  static const String trigger = '$iconDirectory/gi_trigger.svg';
  static const String bzBadgeWhite = '$iconDirectory/gi_white_bz_badge.svg';
  static const String hashtag = '$iconDirectory/gi_hashtag.svg';
  static const String colors = '$iconDirectory/gi_colors.svg';
  static const String feed = '$iconDirectory/gi_feed.svg';
  static const String amazon = '$iconDirectory/gi_amazon.svg';
  static const String gtamazon = '$iconDirectory/gi_gtamazon.svg';
  static const String alibaba = '$iconDirectory/gi_alibaba.svg';
  static const String gtalibaba = '$iconDirectory/gi_gtalibaba.svg';
  static const String house = '$iconDirectory/gi_house.svg';
  static const String arrowYellowUp = '$iconDirectory/gi_arrow_yellow_up.svg';
  static const String arrowYellowRight = '$iconDirectory/gi_arrow_yellow_right.svg';
  static const String arrowYellowDown = '$iconDirectory/gi_arrow_yellow_down.svg';
  static const String arrowYellowLeft = '$iconDirectory/gi_arrow_yellow_left.svg';
  static const String arrowWhiteUp  = '$iconDirectory/gi_arrow_white_up.svg';
  static const String arrowWhiteRight  = '$iconDirectory/gi_arrow_white_right.svg';
  static const String arrowWhiteDown  = '$iconDirectory/gi_arrow_white_down.svg';
  static const String arrowWhiteLeft  = '$iconDirectory/gi_arrow_white_left.svg';
  static const String arrowBlackUp  = '$iconDirectory/gi_arrow_black_up.svg';
  static const String arrowBlackRight  = '$iconDirectory/gi_arrow_black_right.svg';
  static const String arrowBlackDown  = '$iconDirectory/gi_arrow_black_down.svg';
  static const String arrowBlackLeft  = '$iconDirectory/gi_arrow_black_left.svg';
  static const String shop  = '$iconDirectory/gi_shop.svg';
  static const String masterCard  = '$iconDirectory/gi_mastercard.svg';
  static const String paypal  = '$iconDirectory/gi_paypal.svg';
  static const String visa  = '$iconDirectory/gi_visa.svg';
  static const String love  = '$iconDirectory/gi_love.svg';
  static const String pfd = '$iconDirectory/gi_pdf.svg';
  // --------------------
  /// PYRAMIDS
  static const String pyramidsYellow = '$iconDirectory/pyramids_yellow.svg';
  static const String pyramidsWhite = '$iconDirectory/pyramids_white.svg';
  static const String pyramidsGlass = '$iconDirectory/pyramids_glass.svg';
  static const String pyramidsCrystal = '$iconDirectory/pyramids_crystal.svg';
  static const String pyramidzYellow = '$iconDirectory/pyramidz_yellow.svg';
  static const String pyramidzWhite = '$iconDirectory/pyramidz_white.svg';
  static const String pyramidSingleYellow = '$iconDirectory/pyramid_single_yellow.svg';
  static const String pyramidSingleWhite = '$iconDirectory/pyramid_single_white.svg';
  static const String pyramid = '$iconDirectory/gi_pyramid.svg';
  static const String pyramidsYellowClean = '$iconDirectory/pyramids_yellow_clean.svg';
  static const String pyramidsWhiteClean = '$iconDirectory/pyramids_white_clean.svg';
  // --------------------
  /// USER TYPE
  static const String balloonArrowed = '$iconDirectory/balloon_arrowed.svg';
  static const String balloonCircle = '$iconDirectory/balloon_circle.svg';
  static const String balloonZeroCornered = '$iconDirectory/balloon_zero_cornered.svg';
  static const String balloonRoundCornered = '$iconDirectory/balloon_round_cornered.svg';
  static const String balloonThinking = '$iconDirectory/balloon_thinking.svg';
  static const String balloonSpeaking = '$iconDirectory/balloon_speaking.svg';
  // --------------------
  static const String contAfrica = '$iconDirectory/cont_africa.svg';
  static const String contAsia = '$iconDirectory/cont_asia.svg';
  static const String contAustralia = '$iconDirectory/cont_australia.svg';
  static const String contEurope = '$iconDirectory/cont_europe.svg';
  static const String contNorthAmerica = '$iconDirectory/cont_north_america.svg';
  static const String contSouthAmerica = '$iconDirectory/cont_south_america.svg';
  // -----------------------------------------------------------------------------
  static List<String> allIconz(){

    return <String>[

      bldrsNameEn,
      bldrsAppIcon,
      whiteGradient,
      blackGradient,
      welcomeToBldrsBanner_22x18,
      comApple,
      comEmail,
      comFacebook,
      comFacebookWhite,
      comInstagram,
      comLinkedin,
      comMap,
      comPhone,
      comTwitter,
      comWebsite,
      comWhatsapp,
      comGooglePlay,
      comYoutube,
      comTikTok,
      comPinterest,
      comGooglePlus,
      dvBlankSVG,
      dvGouran,
      dvRageh,
      dvRageh2,
      dvRagehWhite,
      dvRagehIcon,
      dvBlankPNG,
      dvBlackHole,
      dvDonaldDuck,
      bxPropertiesOn,
      bxPropertiesOff,
      bxDesignsOn,
      bxDesignsOff,
      bxProductsOn,
      bxProductsOff,
      bzUndertakingOn,
      bxUndertakingOff,
      bxTradesOn,
      bxTradesOff,
      bxEquipmentOn,
      bxEquipmentOff,
      bxOwnerOn,
      bxOwnerOff,
      back,
      backArabic,
      dotPyramid,
      follow,
      gallery,
      language,
      notification,
      password,
      save,
      saveOff,
      saveOn,
      search,
      share,
      viewsIcon,
      filter,
      arrowUp,
      arrowDown,
      arrowRight,
      arrowLeft,
      more,
      handShake,
      savedFlyers,
      normalUser,
      bz,
      flyer,
      plus,
      xSmall,
      check,
      xLarge,
      terms,
      achievement,
      advertise,
      marketing,
      gears,
      exit,
      scholar,
      earth,
      locationPin,
      statistics,
      calendar,
      dashBoard,
      redAlert,
      yellowAlert,
      dollar,
      camera,
      clock,
      info,
      ankhBlack,
      phoneGallery,
      cameraButton,
      addFlyer,
      flyerScale,
      flyerCollection,
      flyerGrid,
      fingerTap,
      flyerPin,
      flyerPinPNG,
      stop,
      play,
      pause,
      bigMac,
      pyramidsYellow,
      pyramidsWhite,
      pyramidsGlass,
      pyramidsCrystal,
      pyramidzYellow,
      pyramidzWhite,
      pyramidSingleYellow,
      pyramidSingleWhite,
      balloonCircle,
      balloonThinking,
      balloonArrowed,
      balloonRoundCornered,
      balloonSpeaking,
      balloonZeroCornered,
      contAfrica,
      contAsia,
      contAustralia,
      contEurope,
      contNorthAmerica,
      contSouthAmerica,
      verifyFlyer,
      phone,
      users,
      star,
      emoji,
      keyword,
      mobilePhone,
      target,
      power,
      circleDot,
      reload,
      lab,
      cleopatra,
      sphinx,
      keywords,
      paste,
      male,
      female,
      crop,
      resize,
      flag,
      colors,
    ];

  }
  // -----------------------------------------------------------------------------
}
