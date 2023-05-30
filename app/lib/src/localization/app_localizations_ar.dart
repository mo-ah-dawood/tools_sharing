import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get addedBy => 'أضيفت من قبل';

  @override
  String get all => 'الكل';

  @override
  String get alreadyHaveAnAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get appTitle => 'مشاركة الأدوات';

  @override
  String get back => 'عودة';

  @override
  String get backTo => 'العودة إلى ';

  @override
  String get balance => 'رصيدك';

  @override
  String get category => 'التصنيف';

  @override
  String get changeEmail => 'تغيير البريد الإلكتروني';

  @override
  String get charge => 'شحن';

  @override
  String get check => 'تحقق';

  @override
  String get completeOrders => 'إتمام الطلب';

  @override
  String get condition => 'حالة الأداة';

  @override
  String get confirmationCode => 'رمز تأكيد البريد الإلكتروني';

  @override
  String get confirmationLinkSendToYourEmail => 'تم إرسال رابط التأكيد إلى بريدك الإلكتروني، يرجى التحقق من حسابك';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get currencyDisplay => 'ج.م';

  @override
  String get dark => 'داكن';

  @override
  String get dataUpdated => 'تم تحديث البيانات بنجاح';

  @override
  String get day => 'يوم';

  @override
  String get dayPrice => 'سعر اليوم';

  @override
  String get dayPriceHint => 'السعر لكل 24 ساعة';

  @override
  String get days => 'أيام الإيجار';

  @override
  String get delete => 'حذف';

  @override
  String get description => 'الوصف';

  @override
  String get dontGetEmail => 'لم تحصل عليه؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String endsAt(Object date) {
    return 'ينتهي بتاريخ $date';
  }

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get gotIt => 'فهمت!';

  @override
  String get image => 'الصورة';

  @override
  String get language => 'اللغة';

  @override
  String get languageDisplay => 'العربية';

  @override
  String get light => 'فاتح';

  @override
  String get linkWithGoogle => 'ربط الحساب';

  @override
  String get loadingPleaseWait => 'جاري التحميل، يرجى الانتظار';

  @override
  String get location => 'الموقع';

  @override
  String get locationPermissionDenied => 'تم رفض أذونات الموقع.';

  @override
  String get locationPermissionPermanentlyDenied => 'تم رفض أذونات الموقع نهائيًا، ولا يمكننا طلب الأذونات.';

  @override
  String get locationServiceDisabled => 'تم تعطيل خدمات الموقع.';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginWithGoogle => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get manufacture => 'الصناعة';

  @override
  String get more => 'المزيد';

  @override
  String get mustBeValidPhoneNumber => 'يجب إدخال هاتف مصري';

  @override
  String get myTools => 'أدواتي';

  @override
  String get name => 'اسم';

  @override
  String get next => 'التالي';

  @override
  String get noOneOrderedFromYou => 'لم يطلب منك أحد حتى الآن';

  @override
  String get noToolsFound => 'لم يتم العثور على أدوات';

  @override
  String get or => '-- أو --';

  @override
  String get orders => 'الطلبات';

  @override
  String get ownerDetails => 'بيانات المالك';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordDontMatch => 'آسف! تأكيد كلمة المرور لا تتطابق مع كلمة المرور';

  @override
  String get phone => 'الهاتف';

  @override
  String get pleaseAddTools => 'الرجاء إضافة أدوات لإكمال الطلب';

  @override
  String get received => 'تم الاستلام';

  @override
  String get register => 'سجل';

  @override
  String get rentedByMe => 'استأجرتها';

  @override
  String get rentedFromMe => 'مستأجرة مني';

  @override
  String get resetLinkSentToYourEmail => 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني';

  @override
  String get search => 'ابحث هنا';

  @override
  String get send => 'أرسال';

  @override
  String get sendAgain => 'أرسل مرة أخرى';

  @override
  String get successFullyAddedTheOrder => 'تم تنفيذ طلبك بنجاح ، يمكنك الآن مراجعة تفاصيل المالك في شاشة الطلبات الخاصة بك';

  @override
  String get sure => 'بالتأكيد!';

  @override
  String get system => 'النظام';

  @override
  String get tenantDetails => 'بيانات المستأجر';

  @override
  String get termsAndConditionsApproval => 'قبول الشروط والأحكام';

  @override
  String get theme => 'الوضع';

  @override
  String get toolBecomeAvailble => 'الأداة متاحة الآن للإيجار';

  @override
  String get toolHint => 'سوف تتحمل تكاليف أي خسارة تحدث للمعدات خلال فترة تأجيرها';

  @override
  String get toolRentedFromOthers => 'Das Werkzeug wurde von jemand anderem gemietet. Sie können es derzeit nicht mieten';

  @override
  String get tools => 'أدوات';

  @override
  String get value => 'القيمة';

  @override
  String get walletCharge => 'شحن المحفظة';

  @override
  String welcome(Object user) {
    return 'أهلا بك $user';
  }

  @override
  String willBeAvalibleAt(Object day) {
    return 'هذه الأداة مستأجرة ستكون متاحة في $day';
  }

  @override
  String get youDontMakeAnyOrder => 'لم تقم بإجراء أي طلب حتى الآن';

  @override
  String yourWalletSuccessFullyChargedWith(Object value) {
    return 'تم شحن محفظتك بنجاح بـ $value جنيه';
  }

  @override
  String get youShouldChargeWallet => 'يجب عليك شحن محفظتك أولاً';

  @override
  String get youShouldCompleteYourProfile => 'يجب عليك إكمال ملف التعريف الخاص بك أولاً قبل أن تتمكن من المتابعة';
}
