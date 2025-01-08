part of legalizer;

class PrivacyScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PrivacyScreen({
    this.company = 'Bldrs.net LLC',
    this.domain = 'Bldrs.net',
    this.email = 'rageh.az@gmail.com',
    this.backgroundColor = Colors.black,
  super.key
  });  // --------------------------------------------------------------------------
  final String company;
  final String domain;
  final String email;
  final Color backgroundColor;
  // --------------------------------------------------------------------------
  List<Widget> generatePrivacyPolicy({
    required BuildContext context,
    required String langCode,
  }){

    final List<Widget> _englishTerms = <Widget>[

    const BigText('Privacy Policy'),
    const SmallText(' '),
    const BigText('Introduction'),
    MediumText('Our privacy policy will help you understand what information we collect at '
        '[$domain], how [$domain] uses it, and what choices you have. '
        '[$company] built the [$domain] app as a free app. This SERVICE is provided by '
        '[$company] at no cost and is intended for use as is. If you choose to use our '
        'Service, then you agree to the collection and use of information in relation with this '
        'policy. The Personal Information that we collect are used for providing and improving the '
        'Service. We will not use or share your information with anyone except as described in this '
        'Privacy Policy. The terms used in this Privacy Policy have the same meanings as in our '
        'Terms and Conditions, which is accessible in our website, unless otherwise defined in'
        ' this Privacy Policy.'),

    const BigText('Information Collection and Use'),
    const MediumText('For a better experience while using our Service, we may require you to provide us with certain'
    ' personally identifiable information, including but not limited to users name, email address,'
    ' gender, location, pictures. The information that we request will be retained by us and used'
    ' as described in this privacy policy. The app does use third party services that may collect'
    ' information used to identify you.'),

    const BigText('Cookies'),
    const MediumText('Cookies are files with small amount of data that is commonly used an anonymous unique '
    'identifier. These are sent to your browser from the website that you visit and are '
    'stored on your devices’s internal memory.'),

    const MediumText('This Services does not uses these “cookies” explicitly. However, the app may use third party '
    'code and libraries that use “cookies” to collection information and to improve their services.'
    " You have the option to 'either' accept or refuse these cookies, and know when a cookie is "
    'being sent to your device. If you choose to refuse our cookies, '
    'you may not be able to use some portions of this Service.'),

    const BigText('Location Information'),
    const MediumText('Some of the services may use location information transmitted from users mobile '
    'phones. We only use this information within the scope necessary for the designated service.'),

    const BigText('Device Information'),
    const MediumText('We collect information from your device in some cases. The information will be utilized '
    'for the provision of better service and to prevent fraudulent acts. Additionally, '
    'such information will not include that which will identify the individual user.'),

    const BigText('Service Providers'),
    const MediumText('We may employ third-party companies and individuals due to the following reasons:'),
    const MediumText('To facilitate our Service;'),
    const MediumText ('To provide the Service on our behalf;'),
    const MediumText('To perform Service-related services; or'),
    const MediumText('To assist us in analyzing how our Service is used.'),
    const MediumText('We want to inform users of this Service that these third parties '
    'have access to your Personal'),
    const MediumText('Information. The reason is to perform the tasks assigned to them on our behalf. '
    'However, they are obligated not to disclose or use the information for any other purpose.'),

    const BigText('Security'),
    const MediumText('We value your trust in providing us your Personal Information, thus we are) striving to use '
    'commercially acceptable means of protecting it. But remember that no method of transmission '
    'over the internet, or method of electronic storage is 100% secure and reliable, and we '
    'cannot guarantee its absolute security.'),

    const BigText('Children’s Privacy'),
    const MediumText('This Services do not address anyone under the age of 13. We do not knowingly '
    'collect personal '
    'identifiable information from children under 13. In the case we discover that a child '
    'under 13 has provided us with personal information, we immediately delete this from our '
    'servers. If you are a parent or guardian and you are aware that your child has '
    'provided us with personal information, please contact us so that we will be able '
    'to do necessary actions.'),

    const BigText('Changes to This Privacy Policy'),
    const MediumText('We may update our Privacy Policy from time to time. Thus, you are advised to review '
    'this page periodically for any changes. We will notify you of any changes by '
    'posting the new Privacy Policy on this page. These changes are effective immediately, '
    'after they are posted on this page.'),

    const BigText('Contact Us'),
    const MediumText('If you have any questions or suggestions about our Privacy Policy, do not '
        'hesitate to contact us.'),
    const MediumText('Contact Information:'),
    const MediumText('Email: [rageh.az@gmail.com]'),

    ];


    return _englishTerms;
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      backgroundColor: backgroundColor,
      body: MaxBounceNavigator(
        child: VerticalFloatingList(
          crossAxisAlignment: CrossAxisAlignment.start,
          columnChildren: <Widget>[

            ...generatePrivacyPolicy(
              context: context,
              langCode: 'en',
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
