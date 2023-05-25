// ignore_for_file: public_member_api_docs, sort_constructors_first
class IranBank {
  String? bankname;
  String imagePath;
  IranBank({
    this.bankname,
    this.imagePath = 'خالی.png',
  }) {
    var i = 0;
    if (bankname!.isNotEmpty) {
      String result = bankname!.trim();
      for (i; i < iranianBanknames.length; i++) {
        if (result == iranianBanknames[i]) {
          bankname = result;
          imagePath = '$bankname.png';
        }
      }
    }
  }

  String getimagepath() {
    return 'assets/image/$imagePath';
  }
}

final List<String> iranianBanknames = [
  'آرمان',
  'اقتصاد نوین',
  'انصار',
  'ایران‌زمین',
  'آینده',
  'مرکزی',
  'پارسیان',
  'پاسارگاد',
  'تجارت',
  'توسعه',
  'توسعه ی تعاون',
  'توسعه صادرات',
  'ثامن',
  'حکمت',
  'خاورمیانه',
  'دی',
  'رسالت',
  'رفاه کارگران',
  'سامان',
  'سپه',
  'سرمایه',
  'سینا',
  'شاپرک',
  'شهر',
  'صادرات',
  'صالحین',
  'صنعت معدن',
  'کارآفرین',
  'کشاورزی',
  'گردشگری',
  'مسکن',
  'ملت',
  'ملل',
  'ملی',
  'مهر اقتصاد',
  'مهر',
  'موسسه اعتباری کوثر',
  'موسسه اعتباری نور',
];
