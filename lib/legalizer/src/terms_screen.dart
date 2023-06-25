part of legalizer;

class TermsScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const TermsScreen({
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
  List<Widget> generateTerms({
    required BuildContext context,
    required String langCode,
  }){

    final List<Widget> _englishTerms = <Widget>[
      const SmallText('Last updated: 2022-08-01'),
      const BigText('1. Introduction'),
      MediumText('Welcome to $company (“Company”, “we”, “our”, “us”)!'),
      MediumText('These Terms of Service (“Terms”, “Terms of Service”) govern your use of our '
          'website located at $domain (together or individually “Service”) operated by $company'),
      const MediumText('Our Privacy Policy also governs your use of our Service and explains how we collect, safeguard and disclose information that results from your use of our web pages.'),
      const MediumText('Your agreement with us includes these Terms and our Privacy Policy (“Agreements”). You acknowledge that you have read and understood Agreements, and agree to be bound of them.'),
      MediumText('If you do not agree with (or cannot comply with) Agreements, then you may not '
          'use the Service, but please let us know by emailing at $email so we can try to find a '
          'solution. These Terms apply to all visitors, users and others who wish to access or use Service.'),
      const BigText('2. Communications'),
      MediumText('By using our Service, you agree to subscribe to newsletters, marketing or '
          'promotional materials and other information we may send. However, you may opt out of '
          'receiving any, or all, of these communications from us by following the unsubscribe '
          'link or by emailing at $email.'),
      const BigText('3. Purchases'),
      const MediumText('If you wish to purchase any product or service made available through Service (“Purchase”), you may be asked to supply certain information relevant to your Purchase including but not limited to, your credit or debit card number, the expiration date of your card, your billing address, and your shipping information.'),
      const MediumText('You represent and warrant that: (i) you have the legal right to use any card(s) or other payment method(s) in connection with any Purchase; and that (ii) the information you supply to us is true, correct and complete.'),
      const MediumText('We may employ the use of third party services for the purpose of facilitating payment and the completion of Purchases. By submitting your information, you grant us the right to provide the information to these third parties subject to our Privacy Policy.'),
      const MediumText('We reserve the right to refuse or cancel your order at any time for reasons including but not limited to: product or service availability, errors in the description or price of the product or service, error in your order or other reasons.'),
      const MediumText('We reserve the right to refuse or cancel your order if fraud or an unauthorized or illegal transaction is suspected.'),
      const BigText('4. Contests, Sweepstakes and Promotions'),
      const MediumText('Any contests, sweepstakes or other promotions (collectively, “Promotions”) made available through Service may be governed by rules that are separate from these Terms of Service. If you participate in any Promotions, please review the applicable rules as well as our Privacy Policy. If the rules for a Promotion conflict with these Terms of Service, Promotion rules will apply.'),
      const BigText('5. Subscriptions'),
      const MediumText('Some parts of Service are billed on a subscription basis ("Subscription(s)"). You will be billed in advance on a recurring and periodic basis ("Billing Cycle"). Billing cycles will be set depending on the type of subscription plan you select when purchasing a Subscription.'),
      MediumText('At the end of each Billing Cycle, your Subscription will automatically renew '
          'under the exact same conditions unless you cancel it or $company cancels it. You may cancel '
          'your Subscription renewal either through your online account management page or by '
          'contacting $email customer support team.'),
      MediumText('A valid payment method is required to process the payment for your subscription.'
          ' You shall provide $company with accurate and complete billing information that may '
          'include '
          'but not limited to full name, address, state, postal or zip code, telephone number, '
          'and a valid payment method information. By submitting such payment information, you '
          'automatically authorize $company to charge all Subscription fees incurred through your '
          'account to any such payment instruments.'),
      MediumText('Should automatic billing fail to occur for any reason, $company reserves the right '
          'to '
          'terminate your access to the Service with immediate effect.'),
      const BigText('6. Free Trial'),
      MediumText('$company may, at its sole discretion, offer a Subscription with a free trial for a '
          'limited period of time ("Free Trial").'),
      const MediumText('You may be required to enter your billing information in order to sign up for Free Trial.'),
      MediumText('If you do enter your billing information when signing up for Free Trial, you '
          'will not be charged by $company until Free Trial has expired. On the last day of Free Trial '
          'period, unless you cancelled your Subscription, you will be automatically charged the applicable Subscription fees for the type of Subscription you have selected.'),
      MediumText('At any time and without notice, $company reserves the right to (i) modify Terms of '
          'Service of Free Trial offer, or (ii) cancel such Free Trial offer.'),
      const BigText('7. Fee Changes'),
      MediumText('$company, in its sole discretion and at any time, may modify Subscription fees for '
          'the Subscriptions. Any Subscription fee change will become effective at the end of the then-current Billing Cycle.'),
      MediumText('$company will provide you with a reasonable prior notice of any change in '
          'Subscription'
          ' fees to give you an opportunity to terminate your Subscription before such change becomes effective.'),
      const MediumText('Your continued use of Service after Subscription fee change comes into effect constitutes your agreement to pay the modified Subscription fee amount.'),
      const BigText('8. Refunds'),
      const MediumText('We issue refunds for Contracts within 30 days of the original purchase of the Contract.'),
      const BigText('9. Content'),
      const MediumText('Our Service allows you to post, link, store, share and otherwise make available certain information, text, graphics, videos, or other material (“Content”). You are responsible for Content that you post on or through Service, including its legality, reliability, and appropriateness.'),
      const MediumText('By posting Content on or through Service, You represent and warrant that: (i) Content is yours (you own it) and/or you have the right to use it and the right to grant us the rights and license as provided in these Terms, and (ii) that the posting of your Content on or through Service does not violate the privacy rights, publicity rights, copyrights, contract rights or any other rights of any person or entity. We reserve the right to terminate the account of anyone found to be infringing on a copyright.'),
      const MediumText('You retain any and all of your rights to any Content you submit, post or display on or through Service and you are responsible for protecting those rights. We take no responsibility and assume no liability for Content you or any third party posts on or through Service. However, by posting Content using Service you grant us the right and license to use, modify, publicly perform, publicly display, reproduce, and distribute such Content on and through Service. You agree that this license includes the right for us to make your Content available to other users of Service, who may also use your Content subject to these Terms.'),
      MediumText('$company has the right but not the obligation to monitor and edit all Content '
          'provided'
          ' by users.'),
      MediumText('In addition, Content found on or through this Service are the property of $company '
          'or '
          'used with permission. You may not distribute, modify, transmit, reuse, download, repost, copy, or use said Content, whether in whole or in part, for commercial purposes or for personal gain, without express advance written permission from us.'),
      const BigText('10. Prohibited Uses'),
      const MediumText('You may use Service only for lawful purposes and in accordance with Terms. You agree not to use Service:'),
      const MediumText('0.1. In any way that violates any applicable national or international law or regulation.'),
      const MediumText('0.2. For the purpose of exploiting, harming, or attempting to exploit or harm minors in any way by exposing them to inappropriate content or otherwise.'),
      const MediumText('0.3. To transmit, or procure the sending of, any advertising or promotional material, including any “junk mail”, “chain letter,” “spam,” or any other similar solicitation.'),
      const MediumText('0.4. To impersonate or attempt to impersonate Company, a Company employee, another user, or any other person or entity.'),
      const MediumText('0.5. In any way that infringes upon the rights of others, or in any way is illegal, threatening, fraudulent, or harmful, or in connection with any unlawful, illegal, fraudulent, or harmful purpose or activity.'),
      const MediumText('0.6. To engage in any other conduct that restricts or inhibits anyone’s use or enjoyment of Service, or which, as determined by us, may harm or offend Company or users of Service or expose them to liability.'),
      const MediumText('Additionally, you agree not to:'),
      const MediumText('0.1. Use Service in any manner that could disable, overburden, damage, or impair Service or interfere with any other party’s use of Service, including their ability to engage in real time activities through Service.'),
      const MediumText('0.2. Use any robot, spider, or other automatic device, process, or means to access Service for any purpose, including monitoring or copying any of the material on Service.'),
      const MediumText('0.3. Use any manual process to monitor or copy any of the material on Service or for any other unauthorized purpose without our prior written consent.'),
      const MediumText('0.4. Use any device, software, or routine that interferes with the proper working of Service.'),
      const MediumText('0.5. Introduce any viruses, trojan horses, worms, logic bombs, or other material which is malicious or technologically harmful.'),
      const MediumText('0.6. Attempt to gain unauthorized access to, interfere with, damage, or disrupt any parts of Service, the server on which Service is stored, or any server, computer, or database connected to Service.'),
      const MediumText('0.7. Attack Service via a denial-of-service attack or a distributed denial-of-service attack.'),
      const MediumText('0.8. Take any action that may damage or falsify Company rating.'),
      const MediumText('0.9. Otherwise attempt to interfere with the proper working of Service.'),
      const BigText('11. Analytics'),
      const MediumText('We may use third-party Service Providers to monitor and analyze the use of our Service.'),
      const BigText('12. No Use By Minors'),
      const MediumText('Service is intended only for access and use by individuals at least eighteen (18) years old. By accessing or using Service, you warrant and represent that you are at least eighteen (18) years of age and with the full authority, right, and capacity to enter into this agreement and abide by all of the terms and conditions of Terms. If you are not at least eighteen (18) years old, you are prohibited from both the access and usage of Service.'),
      const BigText('13. Accounts'),
      const MediumText('When you create an account with us, you guarantee that you are above the age of 18, and that the information you provide us is accurate, complete, and current at all times. Inaccurate, incomplete, or obsolete information may result in the immediate termination of your account on Service.'),
      const MediumText('You are responsible for maintaining the confidentiality of your account and password, including but not limited to the restriction of access to your computer and/or account. You agree to accept responsibility for any and all activities or actions that occur under your account and/or password, whether your password is with our Service or a third-party service. You must notify us immediately upon becoming aware of any breach of security or unauthorized use of your account.'),
      const MediumText('You may not use as a username the name of another person or entity or that is not lawfully available for use, a name or trademark that is subject to any rights of another person or entity other than you, without appropriate authorization. You may not use as a username any name that is offensive, vulgar or obscene.'),
      const MediumText('We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders in our sole discretion.'),
      const BigText('14. Intellectual Property'),
      MediumText('Service and its original content (excluding Content provided by users), '
          'features and functionality are and will remain the exclusive property of $company and its '
          'licensors. Service is protected by copyright, trademark, and other laws of and foreign'
          ' countries. Our trademarks may not be used in connection with any product or service '
          'without the prior written consent of $company.'),
      const BigText('15. Copyright Policy'),
      const MediumText('We respect the intellectual property rights of others. It is our policy to respond to any claim that Content posted on Service infringes on the copyright or other intellectual property rights (“Infringement”) of any person or entity.'),
      MediumText('If you are a copyright owner, or authorized on behalf of one, and you believe '
          'that the copyrighted work has been copied in a way that constitutes copyright '
          'infringement, please submit your claim via email to $email, with the subject line: '
          '“Copyright Infringement” and include in your claim a detailed description of the alleged Infringement as detailed below, under “DMCA Notice and Procedure for Copyright Infringement Claims”'),
      const MediumText('You may be held accountable for damages (including costs and attorneys’ fees) for misrepresentation or bad-faith claims on the infringement of any Content found on and/or through Service on your copyright.'),
      const BigText('16. DMCA Notice and Procedure for Copyright Infringement Claims'),
      const MediumText('You may submit a notification pursuant to the Digital Millennium Copyright Act (DMCA) by providing our Copyright Agent with the following information in writing (see 17 U.S.C 512(c)(3) for further detail):'),
      const MediumText('0.1. an electronic or physical signature of the person authorized to act on behalf of the owner of the copyright’s interest;'),
      const MediumText('0.2. a description of the copyrighted work that you claim has been infringed, including the URL (i.e., web page address) of the location where the copyrighted work exists or a copy of the copyrighted work;'),
      const MediumText('0.3. identification of the URL or other specific location on Service where the material that you claim is infringing is located;'),
      const MediumText('0.4. your address, telephone number, and email address;'),
      const MediumText('0.5. a statement by you that you have a good faith belief that the disputed use is not authorized by the copyright owner, its agent, or the law;'),
      const MediumText('0.6. a statement by you, made under penalty of perjury, that the above information in your notice is accurate and that you are the copyright owner or authorized to act on the copyright owner’s behalf.'),
      MediumText('You can contact our Copyright Agent via email at $email.'),
      const BigText('17. Error Reporting and Feedback'),
      MediumText('You may provide us either directly at $email or via third party sites and tools '
          'with'
          ' information and feedback concerning errors, suggestions for improvements, ideas, problems, complaints, and other matters related to our Service (“Feedback”). You acknowledge and agree that: (i) you shall not retain, acquire or assert any intellectual property right or other right, title or interest in or to the Feedback; (ii) Company may have development ideas similar to the Feedback; (iii) Feedback does not contain confidential information or proprietary information from you or any third party; and (iv) Company is not under any obligation of confidentiality with respect to the Feedback. In the event the transfer of the ownership to the Feedback is not possible due to applicable mandatory laws, you grant Company and its affiliates an exclusive, transferable, irrevocable, free-of-charge, sub-licensable, unlimited and perpetual right to use (including copy, modify, create derivative works, publish, distribute and commercialize) Feedback in any manner and for any purpose.'),
      const BigText('18. Links To Other Web Sites'),
      MediumText('Our Service may contain links to third party web sites or services that are not'
          ' owned or controlled by $company.'),
      MediumText('$company has no control over, and assumes no responsibility for the content, privacy '
          'policies, or practices of any third party web sites or services. We do not warrant the offerings of any of these entities/individuals or their websites.'),
      const MediumText('For example, the outlined Terms of Use have been created using PolicyMaker.io, a free web application for generating high-quality legal documents. PolicyMaker’s Terms and Conditions generator is an easy-to-use free tool for creating an excellent standard Terms of Service template for a website, blog, e-commerce store or app.'),
      const MediumText('YOU ACKNOWLEDGE AND AGREE THAT COMPANY SHALL NOT BE RESPONSIBLE OR LIABLE, DIRECTLY OR INDIRECTLY, FOR ANY DAMAGE OR LOSS CAUSED OR ALLEGED TO BE CAUSED BY OR IN CONNECTION WITH USE OF OR RELIANCE ON ANY SUCH CONTENT, GOODS OR SERVICES AVAILABLE ON OR THROUGH ANY SUCH THIRD PARTY WEB SITES OR SERVICES.'),
      const MediumText('WE STRONGLY ADVISE YOU TO READ THE TERMS OF SERVICE AND PRIVACY POLICIES OF ANY THIRD PARTY WEB SITES OR SERVICES THAT YOU VISIT.'),
      const BigText('19. Disclaimer Of Warranty'),
      const MediumText('THESE SERVICES ARE PROVIDED BY COMPANY ON AN “AS IS” AND “AS AVAILABLE” BASIS. COMPANY MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND, EXPRESS OR IMPLIED, AS TO THE OPERATION OF THEIR SERVICES, OR THE INFORMATION, CONTENT OR MATERIALS INCLUDED THEREIN. YOU EXPRESSLY AGREE THAT YOUR USE OF THESE SERVICES, THEIR CONTENT, AND ANY SERVICES OR ITEMS OBTAINED FROM US IS AT YOUR SOLE RISK.'),
      const MediumText('NEITHER COMPANY NOR ANY PERSON ASSOCIATED WITH COMPANY MAKES ANY WARRANTY OR REPRESENTATION WITH RESPECT TO THE COMPLETENESS, SECURITY, RELIABILITY, QUALITY, ACCURACY, OR AVAILABILITY OF THE SERVICES. WITHOUT LIMITING THE FOREGOING, NEITHER COMPANY NOR ANYONE ASSOCIATED WITH COMPANY REPRESENTS OR WARRANTS THAT THE SERVICES, THEIR CONTENT, OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL BE ACCURATE, RELIABLE, ERROR-FREE, OR UNINTERRUPTED, THAT DEFECTS WILL BE CORRECTED, THAT THE SERVICES OR THE SERVER THAT MAKES IT AVAILABLE ARE FREE OF VIRUSES OR OTHER HARMFUL COMPONENTS OR THAT THE SERVICES OR ANY SERVICES OR ITEMS OBTAINED THROUGH THE SERVICES WILL OTHERWISE MEET YOUR NEEDS OR EXPECTATIONS.'),
      const MediumText('COMPANY HEREBY DISCLAIMS ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, STATUTORY, OR OTHERWISE, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, AND FITNESS FOR PARTICULAR PURPOSE.'),
      const MediumText('THE FOREGOING DOES NOT AFFECT ANY WARRANTIES WHICH CANNOT BE EXCLUDED OR LIMITED UNDER APPLICABLE LAW.'),
      const BigText('20. Limitation Of Liability'),
      const MediumText('EXCEPT AS PROHIBITED BY LAW, YOU WILL HOLD US AND OUR OFFICERS, DIRECTORS, EMPLOYEES, AND AGENTS HARMLESS FOR ANY INDIRECT, PUNITIVE, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGE, HOWEVER IT ARISES (INCLUDING ATTORNEYS’ FEES AND ALL RELATED COSTS AND EXPENSES OF LITIGATION AND ARBITRATION, OR AT TRIAL OR ON APPEAL, IF ANY, WHETHER OR NOT LITIGATION OR ARBITRATION IS INSTITUTED), WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE, OR OTHER TORTIOUS ACTION, OR ARISING OUT OF OR IN CONNECTION WITH THIS AGREEMENT, INCLUDING WITHOUT LIMITATION ANY CLAIM FOR PERSONAL INJURY OR PROPERTY DAMAGE, ARISING FROM THIS AGREEMENT AND ANY VIOLATION BY YOU OF ANY FEDERAL, STATE, OR LOCAL LAWS, STATUTES, RULES, OR REGULATIONS, EVEN IF COMPANY HAS BEEN PREVIOUSLY ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. EXCEPT AS PROHIBITED BY LAW, IF THERE IS LIABILITY FOUND ON THE PART OF COMPANY, IT WILL BE LIMITED TO THE AMOUNT PAID FOR THE PRODUCTS AND/OR SERVICES, AND UNDER NO CIRCUMSTANCES WILL THERE BE CONSEQUENTIAL OR PUNITIVE DAMAGES. SOME STATES DO NOT ALLOW THE EXCLUSION OR LIMITATION OF PUNITIVE, INCIDENTAL OR CONSEQUENTIAL DAMAGES, SO THE PRIOR LIMITATION OR EXCLUSION MAY NOT APPLY TO YOU.'),
      const BigText('21. Termination'),
      const MediumText('We may terminate or suspend your account and bar access to Service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of Terms.'),
      const MediumText('If you wish to terminate your account, you may simply discontinue using Service.'),
      const MediumText('All provisions of Terms which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity and limitations of liability.'),
      const BigText('22. Governing Law'),
      const MediumText('These Terms shall be governed and construed in accordance with the laws of Egypt, which governing law applies to agreement without regard to its conflict of law provisions.'),
      const MediumText('Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights. If any provision of these Terms is held to be invalid or unenforceable by a court, the remaining provisions of these Terms will remain in effect. These Terms constitute the entire agreement between us regarding our Service and supersede and replace any prior agreements we might have had between us regarding Service.'),
      const BigText('23. Changes To Service'),
      const MediumText('We reserve the right to withdraw or amend our Service, and any service or material we provide via Service, in our sole discretion without notice. We will not be liable if for any reason all or any part of Service is unavailable at any time or for any period. From time to time, we may restrict access to some parts of Service, or the entire Service, to users, including registered users.'),
      const BigText('24. Amendments To Terms'),
      const MediumText('We may amend Terms at any time by posting the amended terms on this site. It is your responsibility to review these Terms periodically.'),
      const MediumText('Your continued use of the Platform following the posting of revised Terms means that you accept and agree to the changes. You are expected to check this page frequently so you are aware of any changes, as they are binding on you.'),
      const MediumText('By continuing to access or use our Service after any revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, you are no longer authorized to use Service.'),
      const BigText('25. Waiver And Severability'),
      const MediumText('No waiver by Company of any term or condition set forth in Terms shall be deemed a further or continuing waiver of such term or condition or a waiver of any other term or condition, and any failure of Company to assert a right or provision under Terms shall not constitute a waiver of such right or provision.'),
      const MediumText('If any provision of Terms is held by a court or other tribunal of competent jurisdiction to be invalid, illegal or unenforceable for any reason, such provision shall be eliminated or limited to the minimum extent such that the remaining provisions of Terms will continue in full force and effect.'),
      const BigText('26. Acknowledgement'),
      const MediumText('BY USING SERVICE OR OTHER SERVICES PROVIDED BY US, YOU ACKNOWLEDGE THAT YOU HAVE READ THESE TERMS OF SERVICE AND AGREE TO BE BOUND BY THEM.'),
      const BigText('27. Contact Us'),
      MediumText('Please send your feedback, comments, requests for technical support by email: '
          '$email'
          '.'),
      MediumText('These Terms of Service were created for $domain by PolicyMaker.io on 2022-08-01.'),
    ];

    final List<Widget> _arabicTerms = <Widget>[
      const SmallText('آخر تحديث: 2022-08-01'),
      const BigText('1 المقدمة'),
      MediumText('مرحبًا بك في $company ("الشركة" ، "نحن" ، "لدينا" ، "نحن")!'),
      MediumText('تحكم شروط الخدمة هذه ("الشروط" ، "شروط الخدمة") استخدامك لموقعنا على موقعنا في '
          '$domain (معًا أو "خدمة" بشكل فردي) تديرها $company.'),
      const MediumText('تحكم سياسة الخصوصية الخاصة بنا أيضًا استخدامك لخدمتنا وتشرح كيف نجمع وحماية والكشف عن المعلومات التي تنتج عن استخدامك لصفحات الويب الخاصة بنا.'),
      const MediumText('يتضمن اتفاقك معنا هذه الشروط وسياسة الخصوصية الخاصة بنا ("الاتفاقيات"). أنت تقر بأنك قد قرأت وفهمت اتفاقيات ، وتوافق على الالتزام بها.'),
      MediumText('إذا كنت لا توافق على اتفاقيات (أو لا يمكنك الامتثال لها) ، فلا يجوز لك استخدام '
          'الخدمة ، ولكن يرجى إخبارنا عن طريق البريد الإلكتروني على $email حتى نتمكن من محاولة '
          'العثور'
          ' على حل. تنطبق هذه الشروط على جميع الزوار والمستخدمين وغيرهم الذين يرغبون في الوصول إلى الخدمة أو استخدامها.'),
      const BigText('2. الاتصالات'),
      MediumText('باستخدام خدمتنا ، فإنك توافق على الاشتراك في النشرات الإخبارية أو التسويق أو '
          'المواد الترويجية وغيرها من المعلومات التي قد نرسلها. ومع ذلك ، يمكنك إلغاء الاشتراك في'
          ' تلقي أي ، أو كل هذه الاتصالات منا باتباع رابط إلغاء الاشتراك أو عن طريق البريد '
          'الإلكتروني على $email.'),
      const BigText('3. المشتريات'),
      const MediumText('إذا كنت ترغب في شراء أي منتج أو خدمة متوفرة من خلال الخدمة ("الشراء") ، فقد يُطلب منك تقديم معلومات معينة ذات صلة بالشراء بما في ذلك على سبيل المثال لا الحصر ، رقم بطاقة الائتمان أو الخصم الخاص بك ، تاريخ انتهاء صلاحية بطاقتك وعنوان الفواتير الخاص بك ومعلومات الشحن الخاصة بك.'),
      const MediumText('أنت تمثل وتتعاون: (1) لديك الحق القانوني في استخدام أي بطاقة (بطاقات) أو غيرها من طريقة الدفع فيما يتعلق بأي عملية شراء ؛ وهذا (2) المعلومات التي توفرها لنا صحيحة وصحيحة وكاملة.'),
      const MediumText('قد نستخدم استخدام خدمات الطرف الثالث لغرض تسهيل الدفع واستكمال عمليات الشراء. من خلال تقديم معلوماتك ، فإنك تمنحنا الحق في تقديم المعلومات لهذه الأطراف الثالثة الخاضعة لسياسة الخصوصية الخاصة بنا.'),
      const MediumText('نحن نحتفظ بالحق في رفض طلبك أو إلغاؤه في أي وقت لأسباب بما في ذلك على سبيل المثال لا الحصر: توفر المنتج أو الخدمة أو الأخطاء في وصف أو سعر المنتج أو الخدمة أو الخطأ في طلبك أو أسباب أخرى.'),
      const MediumText('نحن نحتفظ بالحق في رفض طلبك أو إلغاؤه في حالة الاحتيال أو المعاملة غير المصرح بها أو غير القانونية.'),
      const BigText('4. المسابقات ، اليانصيب والعروض الترويجية'),
      const MediumText('قد تخضع أي مسابقات أو اليانصيب أو العروض الترويجية الأخرى (بشكل جماعي ، "العروض الترويجية") من خلال الخدمة بقواعد منفصلة عن شروط الخدمة هذه. إذا شاركت في أي عروض ترويجية ، فيرجى مراجعة القواعد المعمول بها وكذلك سياسة الخصوصية الخاصة بنا. إذا تتعارض قواعد الترقية مع شروط الخدمة هذه ، فسيتم تطبيق قواعد الترويج.'),
      const BigText('5. الاشتراكات'),
      const MediumText('يتم فاتورة بعض أجزاء الخدمة على أساس الاشتراك ("الاشتراك (الاشتراك)"). سيتم فواتيرك مقدمًا على أساس متكرر وفوري ("دورة الفواتير"). سيتم تعيين دورات الفواتير اعتمادًا على نوع خطة الاشتراك التي تختارها عند شراء اشتراك.'),
      MediumText('في نهاية كل دورة فواتير ، سيتم تجديد اشتراكك تلقائيًا في نفس الشروط بالضبط ما '
          'لم تقم بإلغاءه أو $company يلغيه. يمكنك إلغاء تجديد الاشتراك الخاص بك إما من خلال صفحة إدارة'
          ' حسابك عبر الإنترنت أو عن طريق الاتصال بـ $email.'),
      MediumText('مطلوب طريقة دفع صالحة لمعالجة الدفع للاشتراك الخاص بك. يجب عليك توفير معلومات '
          'الفواتير الدقيقة والكاملة التي قد تتضمن على سبيل المثال لا الحصر ، على سبيل المثال لا '
          'الحصر ، الاسم الكامل ، العنوان ، الولاية ، الرمز البريدي أو الرمز البريدي ، رقم الهاتف'
          ' ، ومعلومات طريقة الدفع صالحة. من خلال تقديم معلومات الدفع هذه ، تقوم تلقائيًا بتفويض '
          '$company لشحن جميع رسوم الاشتراك المتكبدة من خلال حسابك لأي أدوات دفع من هذا القبيل.'),
      MediumText('إذا فشل الفوترة التلقائية في الحدوث لأي سبب من الأسباب ، تحتفظ $company بالحق في '
          'إنهاء'
          ' وصولك إلى الخدمة مع تأثير فوري.'),
      const BigText('6. تجربة مجانية'),
      MediumText('يجوز لـ $company ، وفقًا لتقديرها الخاص ، تقديم اشتراك مع تجربة مجانية لفترة زمنية '
          'محدودة ("تجريبية مجانية").'),
      const MediumText('قد يُطلب منك إدخال معلومات الفواتير الخاصة بك من أجل التسجيل للتجربة المجانية.'),
      MediumText('إذا قمت بإدخال معلومات الفواتير الخاصة بك عند التسجيل للتجربة المجانية ، فلن '
          'يتم فرض رسوم عليك من قبل $company حتى تنتهي صلاحية التجربة المجانية. في اليوم الأخير من '
          'الفترة التجريبية المجانية ، ما لم ألغت اشتراكك ، سيتم تلقائيًا فرض رسوم الاشتراك المعمول بها لنوع الاشتراك الذي حددته.'),
      MediumText('في أي وقت ودون إشعار ، تحتفظ $company بالحق في (1) تعديل شروط خدمة العرض التجريبي '
          'المجاني ، أو (2) إلغاء هذا العرض التجريبي المجاني.'),
      const BigText('7. يتغير الرسوم'),
      MediumText('$company ، وفقًا لتقديرها الخاص وفي أي وقت ، قد تعدل رسوم الاشتراك للاشتراكات. سيصبح '
          'أي تغيير في رسوم الاشتراك ساري المفعول في نهاية دورة الفواتير في ذلك الوقت.'),
      MediumText('ستوفر لك $company إشعارًا مسبقًا معقولًا عن أي تغيير في رسوم الاشتراك لمنحك فرصة '
          'لإنهاء اشتراكك قبل أن يصبح هذا التغيير ساري المفعول.'),
      const MediumText('إن استخدامك المستمر للخدمة بعد بدء تشغيل رسوم الاشتراك يشكل حيز التنفيذ موافقتك على دفع مبلغ رسوم الاشتراك المعدل.'),
      const BigText('8. المبالغ المستردة'),
      const MediumText('نقوم بإصدار المبالغ المستردة للعقود في غضون 30 يومًا من الشراء الأصلي للعقد.'),
      const BigText('9. المحتوى'),
      const MediumText('تتيح لك خدمتنا نشر أو ربط أو تخزين ومشاركة وإتاحة بعض المعلومات أو النصوص أو الرسومات أو مقاطع الفيديو أو المواد الأخرى ("المحتوى"). أنت مسؤول عن المحتوى الذي تنشره في الخدمة أو من خلالها ، بما في ذلك شرعية وموثوقيتها وملاءمتها.'),
      const MediumText('من خلال نشر المحتوى على الخدمة أو من خلاله ، فإنك تمثل وتتعاون: (1) المحتوى الخاص بك (أنت تملكه) و/أو لديك الحق في استخدامه والحق في منحنا الحقوق والترخيص على النحو المنصوص عليه في هذه الشروط و (2) أن نشر المحتوى الخاص بك على الخدمة أو من خلال الخدمة لا ينتهك حقوق الخصوصية أو حقوق الدعاية أو حقوق الطبع والنشر أو حقوق العقد أو أي حقوق أخرى لأي شخص أو كيان. نحن نحتفظ بالحق في إنهاء حساب أي شخص وجد أنه ينتهك حقوق الطبع والنشر.'),
      const MediumText('يمكنك الاحتفاظ بأي من حقوقك في أي محتوى تقوم بنشره أو نشره أو عرضه على الخدمة أو من خلاله وأنت مسؤول عن حماية هذه الحقوق. لا نتحمل أي مسؤولية ونتحمل أي مسؤولية عن المحتوى أنت أو أي منشورات طرف ثالث في الخدمة أو من خلالها. ومع ذلك ، من خلال نشر المحتوى باستخدام الخدمة ، تمنحنا الحق والترخيص لاستخدام وتعديل وأداء علني وعرضه علنًا وإعادة إنتاج وتوزيع هذا المحتوى على الخدمة ومن خلاله. أنت توافق على أن هذا الترخيص يتضمن حقنا في إتاحة المحتوى الخاص بك لمستخدمي الخدمة الآخرين ، والذين قد يستخدمون أيضًا المحتوى الخاص بك وفقًا لهذه الشروط.'),
      MediumText('يتمتع $company بالحق ولكن ليس الالتزام بمراقبة وتحرير جميع المحتوى الذي يقدمه '
          'المستخدمون.'),
      MediumText('بالإضافة إلى ذلك ، فإن المحتوى الموجود في هذه الخدمة أو من خلاله هو خاصية $company '
          'أو '
          'تستخدم بإذن. لا يجوز لك توزيع المحتوى المذكور أو تعديله أو إرساله أو إعادة استخدامه أو تنزيله أو إعادة نشره أو نسخه أو استخدامه ، سواء أكان ذلك أو جزئيًا ، لأغراض تجارية أو لتحقيق مكاسب شخصية ، دون إذن كتابي مسبق صريح منا.'),
      const BigText('10. الاستخدامات المحظورة'),
      const MediumText('يمكنك استخدام الخدمة فقط لأغراض قانونية ووفقًا للشروط. أنت توافق على عدم استخدام الخدمة:'),
      const MediumText('0.1. بأي حال من الأحوال ينتهك أي قانون أو لائحة وطني أو دولي معمول به.'),
      const MediumText('0.2. لغرض استغلال أو إيذاء أو محاولة استغلال القاصرين أو إلحاق الضرر به بأي شكل من الأشكال عن طريق تعريضهم لمحتوى غير مناسب أو غير ذلك.'),
      const MediumText('0.3. لنقل أو شراء أي مواد إعلانية أو ترويجية ، بما في ذلك أي "بريد غير مرغوب فيه" أو "خطاب سلسلة" أو "البريد العشوائي" أو أي طلب آخر مماثل.'),
      const MediumText('0.4. لانتحال شخصية أو محاولة انتحال شخصية الشركة أو موظف الشركة أو مستخدم آخر أو أي شخص أو كيان آخر.'),
      const MediumText('0.5. بأي طريقة تنتهك حقوق الآخرين ، أو بأي شكل من الأشكال غير قانونية أو مهددة أو احتيالية أو ضارة ، أو فيما يتعلق بأي غرض أو نشاط غير قانوني أو غير قانوني أو ضار أو ضار.'),
      const MediumText('0.6. للانخراط في أي سلوك آخر يقيد أو يمنع استخدام أي شخص أو التمتع بالخدمة ، أو ، والتي ، كما هو محدد من قبلنا ، قد تؤذي أو الإساءة إلى الشركة أو مستخدمي الخدمة أو تعريضها للمسؤولية.'),
      const MediumText('بالإضافة إلى ذلك ، أنت توافق على عدم:'),
      const MediumText('0.1. استخدم الخدمة بأي طريقة قد تعطيل أو تضخّم الأضرار أو الضرر أو ضعف الخدمة أو تتداخل مع استخدام أي طرف آخر للخدمة ، بما في ذلك قدرته على المشاركة في أنشطة الوقت الحقيقي من خلال الخدمة.'),
      const MediumText('0.2. استخدم أي روبوت أو عنكبوت أو غيره من الأجهزة التلقائية أو العملية أو الوسائل للوصول إلى الخدمة لأي غرض ، بما في ذلك مراقبة أو نسخ أي من المواد الموجودة في الخدمة.'),
      const MediumText('0.3. استخدم أي عملية يدوية لمراقبة أو نسخ أي من المواد الموجودة في الخدمة أو لأي غرض آخر غير مصرح به دون موافقتنا الخطية السابقة.'),
      const MediumText('0.4. استخدم أي جهاز أو برنامج أو روتين يتداخل مع العمل المناسب للخدمة.'),
      const MediumText('0.5. قدم أي فيروسات أو خيول طروادة أو ديدان أو قنابل منطقية أو مواد أخرى ضارة أو ضارة تقنيًا.'),
      const MediumText('0.6. محاولة للوصول غير المصرح به إلى أي أجزاء من الخدمة ، أو تعطيلها أو تعطيلها ، أو الخادم الذي يتم تخزين الخدمة عليه ، أو أي خادم أو كمبيوتر أو قاعدة بيانات متصلة بالخدمة.'),
      const MediumText('0.7. خدمة الهجوم عبر هجوم رفض الخدمة أو هجوم رفض الخدمة الموزع.'),
      const MediumText('0.8. اتخذ أي إجراء قد يلحق الضرر أو تزوير تصنيف الشركة.'),
      const MediumText('0.9. بخلاف ذلك ، حاول التدخل في العمل المناسب للخدمة.'),
      const BigText('11. التحليلات'),
      const MediumText('قد نستخدم مقدمي خدمات الطرف الثالث لمراقبة استخدام خدمتنا وتحليلها.'),
      const BigText('12. لا استخدام من قبل القصر'),
      const MediumText('الخدمة مخصصة فقط للوصول والاستخدام من قبل الأفراد الذين لا يقل عن ثمانية عشر (18) سنة على الأقل. من خلال الوصول إلى الخدمة أو استخدامها ، فإنك تبرر وتمثل أنك لا تقل عن ثمانية عشر (18) سنة من العمر ومع السلطة الكاملة والحق والقدرة على الدخول في هذه الاتفاقية والالتزام بجميع شروط وأحكام الشروط. إذا لم يكن عمرك على الأقل في الثامنة عشرة (18) عامًا ، فأنت محظور من الوصول إلى الخدمة واستخدامها.'),
      const BigText('13. الحسابات'),
      const MediumText('عندما تقوم بإنشاء حساب معنا ، فإنك تضمن أنك فوق سن 18 عامًا ، وأن المعلومات التي توفرها لنا دقيقة وكاملة وحديثة في جميع الأوقات. قد تؤدي المعلومات غير الدقيقة أو غير المكتملة أو القديمة إلى الإنهاء الفوري لحسابك على الخدمة.'),
      const MediumText('أنت مسؤول عن الحفاظ على سرية حسابك وكلمة المرور ، بما في ذلك على سبيل المثال لا الحصر تقييد الوصول إلى الكمبيوتر و/أو حسابك. أنت توافق على قبول المسؤولية عن أي وجميع الأنشطة أو الإجراءات التي تحدث تحت حسابك و/أو كلمة المرور ، سواء كانت كلمة المرور الخاصة بك مع خدمتنا أو خدمة الطرف الثالث. يجب أن تخطرنا فورًا على إدراك أي خرق للأمان أو الاستخدام غير المصرح به لحسابك.'),
      const MediumText('لا يجوز لك استخدام اسم مستخدم اسم شخص أو كيان آخر أو غير متاح بشكل قانوني للاستخدام ، اسم أو علامة تجارية تخضع لأي حقوق لشخص آخر أو كيان آخر غير ذلك ، دون إذن مناسب. لا يجوز لك استخدام اسم مستخدم أي اسم مسيء أو مبتذلة أو فاحشة.'),
      const MediumText('نحن نحتفظ بالحق في رفض الخدمة أو إنهاء الحسابات أو إزالة المحتوى أو تحريره أو إلغاء الطلبات وفقًا لتقديرنا الخاص.'),
      const BigText('14. الملكية الفكرية'),
      MediumText('الخدمة ومحتوىها الأصلي (باستثناء المحتوى الذي يوفره المستخدمون) ، والميزات '
          'والوظائف هي ، وستظل الخاصية الحصرية لـ $company ومرخصيها. الخدمة محمية من قبل حقوق الطبع '
          'والنشر والعلامات التجارية وقوانين أخرى للدول الأجنبية. لا يجوز استخدام علاماتنا '
          'التجارية فيما يتعلق بأي منتج أو خدمة دون موافقة كتابية مسبقة من $company.'),
      const BigText('15. سياسة حقوق الطبع والنشر'),
      const MediumText('نحن نحترم حقوق الملكية الفكرية للآخرين. إن سياستنا هي الرد على أي مطالبة بأن المحتوى المنشور على الخدمة ينتهك حقوق الطبع والنشر أو غيرها من حقوق الملكية الفكرية ("انتهاك") لأي شخص أو كيان.'),
      MediumText('إذا كنت مالك حقوق الطبع والنشر ، أو مصرحًا به نيابة عن واحد ، وتعتقد أنه تم نسخ'
          ' العمل المحمي بحقوق الطبع والنشر بطريقة تشكل انتهاكًا لحقوق الطبع والنشر ، فيرجى إرسال'
          ' مطالبتك عبر البريد الإلكتروني إلى $email ، مع الموضوع السطر: "انتهاك حقوق الطبع '
          'والنشر" '
          'وتضمين في مطالبتك وصفًا مفصلاً للانتهاك المزعوم على النحو المفصل أدناه ، بموجب "إشعار وإجراءات DMCA لمطالبات انتهاك حقوق الطبع والنشر"'),
      const MediumText('قد تكون مسؤولاً عن الأضرار (بما في ذلك التكاليف ورسوم المحامين) لتشويهها أو مطالبات الأديان السيئة بشأن انتهاك أي محتوى موجود على و/أو من خلال الخدمة على حقوق الطبع والنشر الخاصة بك.'),
      const BigText('16. إشعار DMCA وإجراءات مطالبات انتهاك حقوق الطبع والنشر'),
      const MediumText('يمكنك تقديم إشعار بموجب قانون حقوق الطبع والنشر للألفية الرقمية (DMCA) من خلال تزويد وكيل حقوق الطبع والنشر لدينا بالمعلومات التالية كتابيًا (انظر 17 الولايات المتحدة 512 (ج) (3) لمزيد من التفاصيل):'),
      const MediumText('0.1. توقيع إلكتروني أو مادي للشخص المصرح له بالتصرف نيابة عن صاحب مصلحة حقوق الطبع والنشر ؛'),
      const MediumText('0.2. وصف للعمل المحمي بحقوق الطبع والنشر التي تدعي أنه تم انتهاكه ، بما في ذلك عنوان URL (أي عنوان صفحة الويب) للموقع الذي يوجد فيه العمل المحمي بحقوق الطبع والنشر أو نسخة من العمل المحمي بحقوق الطبع والنشر ؛'),
      const MediumText('0.3. تحديد عنوان URL أو موقع محدد آخر على الخدمة حيث توجد المواد التي تدعي أنها تنتهك ؛'),
      const MediumText('0.4. عنوانك ورقم هاتفك وعنوان البريد الإلكتروني ؛'),
      const MediumText('0.5. بيان من قبل أن يكون لديك اعتقاد بحسن نية بأن الاستخدام المتنازع عليه غير مصرح به من قبل مالك حقوق الطبع والنشر أو وكيله أو القانون ؛'),
      const MediumText('0.6. بيان من قبلك ، أدلى بموجب عقوبة الحنث باليمين ، أن المعلومات أعلاه في إشعارك دقيقة وأنك مالك حقوق الطبع والنشر أو مخول للتصرف نيابة عن مالك حقوق الطبع والنشر.'),
      MediumText('يمكنك الاتصال بوكيل حقوق الطبع والنشر عبر البريد الإلكتروني على $email.'),
      const BigText('17. خطأ في الإبلاغ والتعليقات'),
      MediumText('يمكنك تزويدنا إما مباشرة على $email أو عبر مواقع وأدوات الطرف الثالث مع '
          'المعلومات '
          'والتعليقات المتعلقة بالأخطاء والاقتراحات للتحسينات والأفكار والمشاكل والشكاوى وغيرها من الأمور المتعلقة بخدمتنا ("ردود الفعل") . أنت تقر وتوافق على ما يلي: (1) لا يجوز لك الاحتفاظ أو الحصول على أو تأكيد أي حق الملكية الفكرية أو الحق الآخر أو الملكية أو الاهتمام في التعليقات ؛ (2) قد يكون لدى الشركة أفكار تطوير مماثلة للتعليقات ؛ (3) لا تحتوي التعليقات على معلومات سرية أو معلومات ملكية منك أو أي طرف ثالث ؛ و (4) الشركة ليست تحت أي التزام بالسرية فيما يتعلق بالتعليقات. في حالة عدم إمكانية نقل الملكية إلى التعليقات بسبب القوانين الإلزامية المعمول بها ، فإنك تمنح الشركة وشركاتها التابعة لها حقها الحصري ، القابل للتحويل ، لا رجعة فيه ، حرة ، قابلية للترخيص ، غير محدود ، غير محدود ودائم في الاستخدام ( بما في ذلك نسخ ، تعديل ، إنشاء أعمال مشتقة ، نشر ، توزيع وتسويق) التعليقات بأي طريقة ولأي غرض.'),
      const BigText('18. روابط لمواقع الويب الأخرى'),
      MediumText('قد تحتوي خدمتنا على روابط لمواقع الويب أو الخدمات التي لا تملكها أو تسيطر عليها'
          ' $company.'),
      MediumText('ليس لدى $company أي سيطرة ، ولا تتحمل أي مسؤولية عن المحتوى أو سياسات الخصوصية أو '
          'ممارسات أي مواقع أو خدمات على شبكة الإنترنت من طرف ثالث. لا نضمن عروض أي من هذه الكيانات/الأفراد أو مواقع الويب الخاصة بهم.'),
      const MediumText('على سبيل المثال ، تم إنشاء شروط الاستخدام المحددة باستخدام PolicyMaker.io ، وهو تطبيق ويب مجاني لإنشاء مستندات قانونية عالية الجودة. يعد مولد شروط وأحكام شروط Policymaker أداة مجانية سهلة الاستخدام لإنشاء قالب شروط خدمة قياسي ممتاز لموقع ويب أو مدونة أو متجر للتجارة الإلكترونية أو التطبيق.'),
      const MediumText('أنت تقر وتوافق على أن الشركة لن تكون مسؤولة أو مسؤولة ، بشكل مباشر أو غير مباشر ، عن أي ضرر أو خسارة ناتجة أو يزعم أنها ناتجة عن أو فيما يتعلق باستخدام أو الاعتماد على أي محتوى أو سلع أو خدمات متوفرة أو من خلال أي مثل هذه المواقع أو الخدمات على الويب من الطرف الثالث.'),
      const MediumText('ننصحك بشدة بقراءة شروط الخدمة وسياسات الخصوصية لأي مواقع أو خدمات على شبكة الإنترنت من طرف ثالث تقوم بزيارتها.'),
      const BigText('19. إخلاء المسؤولية عن الضمان'),
      const MediumText('يتم تقديم هذه الخدمات من قبل الشركة على أساس "كما هو" و "كما هو متاح". لا تقدم الشركة أي تعهدات أو ضمانات من أي نوع ، صريحة أو ضمنية ، فيما يتعلق بتشغيل خدماتها ، أو المعلومات أو المحتوى أو المواد المتضمنة فيها. أنت توافق صراحة على أن استخدامك لهذه الخدمات ومحتواها وأي خدمات أو عناصر تم الحصول عليها منا على مسؤوليتك الوحيدة.'),
      const MediumText('لا تقدم أي شخص أو أي شخص مرتبط بالشركة أي ضمان أو تمثيل فيما يتعلق بالاكتمال أو الأمن أو الموثوقية أو الجودة أو الدقة أو توافر الخدمات. دون الحد من ما سبق ، لن تمثل أي شخص أو أي شخص مرتبط بالشركة أو أوامر أن الخدمات أو محتواها أو أي خدمات أو عناصر تم الحصول عليها من خلال الخدمات ستكون دقيقة أو موثوقة أو خالية من الأخطاء أو دون انقطاع ، حيث سيتم تصحيح العيوب ، أن الخدمات أو الخادم الذي يجعلها متوفرة خالية من الفيروسات أو المكونات الضارة الأخرى أو أن الخدمات أو أي الخدمات أو العناصر التي تم الحصول عليها من خلال الخدمات ستلبي احتياجاتك أو توقعاتك.'),
      const MediumText('تتخلى الشركة بموجب هذا عن جميع الضمانات من أي نوع ، سواء كانت صريحة أو ضمنية أو قانونية أو غير ذلك ، بما في ذلك على سبيل المثال لا الحصر أي ضمانات للتسويق ، وعدم التعبير ، واللياقة لغرض معين.'),
      const MediumText('لا يؤثر ما سبق على أي ضمانات لا يمكن استبعادها أو محدودة بموجب القانون المعمول به.'),
      const BigText('20. الحد من المسؤولية'),
      const MediumText('باستثناء ما هو محظور بموجب القانون ، ستحتفظ بنا وضباطنا ومديرينا وموظفينا ووكلاء غير ضارة لأي ضرر غير مباشر أو عقابي أو خاص أو عرضي أو تبعي ، ومع ذلك ينشأ (بما في ذلك أتعاب المحاماة وجميع التكاليف والنفقات ذات الصلة التقاضي والتحكيم ، أو في المحاكمة أو عند الاستئناف ، إن وجدت ، سواء كانت التقاضي أو التحكيم أم لا) ، سواء في إجراء عقد أو إهمال أو أي إجراء غير آخر أو ناشئ عن هذه الاتفاق بدون قيود ، أي مطالبة بإصابة شخصية أو أضرار في الممتلكات ، ناشئة عن هذه الاتفاقية وأي انتهاك من أي قوانين أو قوانين أو قوانين أو قواعد أو لوائح اتحادية أو محلية ، حتى لو كانت الشركة قد تم إخطارها سابقًا بإمكانية حدوث مثل هذا الضرر . باستثناء ما هو محظور بموجب القانون ، إذا كان هناك مسؤولية موجودة من جانب الشركة ، فسيقتصر ذلك على المبلغ المدفوع للمنتجات و/أو الخدمات ، وعند أي ظرف من الظروف ، لن تكون هناك أضرار تبعية أو عقابية. لا تسمح بعض الدول باستبعاد أو تقييد الأضرار العقابية أو العرضية أو التبعية ، وبالتالي قد لا ينطبق عليك القيود المسبقة أو الاستبعاد.'),
      const BigText('21. إنهاء'),
      const MediumText('يجوز لنا إنهاء أو تعليق حسابك والوصول إلى الخدمة على الفور ، دون إشعار أو مسؤولية مسبقة ، بموجب تقديرنا الخاص ، لأي سبب من الأسباب ودون قيود ، بما في ذلك على سبيل المثال لا الحصر خرق المصطلحات.'),
      const MediumText('إذا كنت ترغب في إنهاء حسابك ، فيمكنك ببساطة التوقف عن استخدام الخدمة.'),
      const MediumText('جميع أحكام المصطلحات التي يجب أن تنجو من إنهاء نهاية طبيعتها على قيد الحياة ، بما في ذلك ، على سبيل المثال لا الحصر ، أحكام الملكية ، إخلاء المسئولية الضمان ، تعويض وقيود المسؤولية.'),
      const BigText('22. القانون الحاكم'),
      const MediumText('تخضع هذه الشروط وتفسر وفقًا لقوانين مصر ، والتي تنطبق على القانون على الاتفاق دون النظر إلى أحكامها في أحكام القانون.'),
      const MediumText('إن فشلنا في إنفاذ أي حق أو توفير هذه الشروط لن يعتبر تنازلًا عن هذه الحقوق. إذا تم اعتبار أي حكم من هذه الشروط غير صالح أو غير قابل للتنفيذ من قبل المحكمة ، فستظل الأحكام المتبقية من هذه الشروط سارية. تشكل هذه الشروط الاتفاقية الكاملة بيننا فيما يتعلق بخدمتنا وتحل محل أي اتفاقيات سابقة واستبدالها بيننا فيما يتعلق بالخدمة.'),
      const BigText('23. التغييرات في الخدمة'),
      const MediumText('نحن نحتفظ بالحق في سحب أو تعديل خدمتنا ، وأي خدمة أو مواد نقدمها عبر الخدمة ، وفقًا لتقديرنا الخاص دون إشعار. لن نكون مسؤولين إذا لم يكن كل أو أي جزء من الخدمة متاحًا لأي سبب من الأسباب أو أي جزء من الخدمة في أي وقت أو لأي فترة. من وقت لآخر ، قد نقيد الوصول إلى بعض أجزاء الخدمة ، أو الخدمة بأكملها ، إلى المستخدمين ، بما في ذلك المستخدمين المسجلين.'),
      const BigText('24. التعديلات على الشروط'),
      const MediumText('قد نقوم بتعديل المصطلحات في أي وقت عن طريق نشر الشروط المعدلة على هذا الموقع. تقع على عاتقك مسؤولية مراجعة هذه الشروط بشكل دوري.'),
      const MediumText('إن استخدامك المستمر للمنصة التالية لنشر المصطلحات المنقحة يعني أنك تقبل التغييرات والموافقة عليها. من المتوقع أن تتحقق من هذه الصفحة بشكل متكرر حتى تكون على دراية بأي تغييرات ، لأنها ملزمة لك.'),
      const MediumText('من خلال الاستمرار في الوصول إلى خدمتنا أو استخدامها بعد أن تصبح أي مراجعات سارية ، فإنك توافق على الالتزام بالشروط المنقحة. إذا كنت لا توافق على الشروط الجديدة ، لم تعد مخولًا لاستخدام الخدمة.'),
      const BigText('25. التنازل وقابلية الفصل'),
      const MediumText('لا يجوز اعتبار أي تنازل عن شركة من أي فترة أو شرط منصوص عليه في المصطلحات تنازلًا آخر أو مستمرًا عن هذا المصطلح أو الشرط أو التنازل عن أي فترة أو شرط آخر ، وأي فشل في الشركة في تأكيد حق أو حكم بموجب الشروط لا تشكل تنازلاً عن هذا الحق أو الحكم.'),
      const MediumText('إذا تم الاحتفاظ بأي حكم من المصطلحات من قبل محكمة أو محكمة أخرى من الاختصاص المختصة لتكون غير صالحة أو غير قانوني أو غير قابلة للتنفيذ لأي سبب من الأسباب ، فإن هذا الحكم يتم إلغاؤه أو يقتصر على الحد الأدنى لدرجة أن الأحكام المتبقية من الشروط ستستمر بكامل قوتها والتأثير.'),
      const BigText('26. الإقرار'),
      const MediumText('باستخدام الخدمة أو الخدمات الأخرى التي تقدمها لنا ، فإنك تقر بأنك قد قرأت شروط الخدمة هذه وتوافق على الالتزام بها.'),
      const BigText('27. اتصل بنا'),
      MediumText('يرجى إرسال ملاحظاتك وتعليقاتك وطلبات الدعم الفني عن طريق البريد الإلكتروني: '
          '$email'
          '.'),
      MediumText('تم إنشاء شروط الخدمة هذه لـ $domain بواسطة PolicyMaker.io في 2022-08-01.'),
    ];

    return langCode == 'ar' ? _arabicTerms : _englishTerms;
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BasicLayout(
      backgroundColor: backgroundColor,
      body: MaxBounceNavigator(
        child: FloatingList(
          crossAxisAlignment: CrossAxisAlignment.start,
          columnChildren: <Widget>[

            ...generateTerms(
              context: context,
              langCode: 'en',
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
