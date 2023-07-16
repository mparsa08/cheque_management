const String tableName = 'Cheque';

class Cheque {
  final int serial;
  final int mablagh;
  final String bankname;
  final String pardakhtkonande;
  final String? phonenumber;
  final String type;
  final String? tozihat;
  final String tarikh;
  final String? ispaid;

  const Cheque(
      {required this.serial,
      required this.mablagh,
      required this.bankname,
      required this.pardakhtkonande,
      this.phonenumber,
      required this.type,
      this.tozihat,
      required this.tarikh,
      this.ispaid});

  Cheque copy({
    int? serial,
    int? mablagh,
    String? bankname,
    String? pardakhtkonande,
    String? phonenumber,
    String? type,
    String? tozihat,
    String? tarikh,
    String? ispaid,
  }) =>
      Cheque(
        serial: serial ?? this.serial,
        mablagh: mablagh ?? this.mablagh,
        bankname: bankname ?? this.bankname,
        pardakhtkonande: pardakhtkonande ?? this.pardakhtkonande,
        phonenumber: phonenumber ?? this.phonenumber,
        type: type ?? this.type,
        tozihat: tozihat ?? this.tozihat,
        tarikh: tarikh ?? this.tarikh,
        ispaid: ispaid ?? this.ispaid,
      );

  static Cheque fromJson(Map<String, Object?> json) => Cheque(
        serial: json['serial'] as int,
        mablagh: int.parse(json['mablagh'] as String),
        bankname: json['bankname'] as String,
        pardakhtkonande: json['pardakhtkonande'] as String,
        phonenumber: json['phonenumber'] as String?,
        type: json['type'] as String,
        tozihat: json['tozihat'] as String?,
        tarikh: json['tarikh'] as String,
        ispaid: json['ispaid'] as String?,
      );

  Map<String, Object?> toJson() => {
        'serial': serial,
        'mablagh': mablagh,
        'bankname': bankname,
        'pardakhtkonande': pardakhtkonande,
        'phonenumber': phonenumber,
        'type': type,
        'tozihat': tozihat,
        'tarikh': tarikh,
        'ispaid': ispaid,
      };
}

class ChequeFields {
  static final List<String> values = [
    serial,
    mablagh,
    bankname,
    pardakhtkonande,
    phonenumber,
    type,
    tozihat,
    tarikh,
    ispaid,
  ];

  static const String serial = 'serial';
  static const String mablagh = 'mablagh';
  static const String bankname = 'bankname';
  static const String pardakhtkonande = 'pardakhtkonande';
  static const String phonenumber = 'phonenumber';
  static const String type = 'type';
  static const String tozihat = 'tozihat';
  static const String tarikh = 'tarikh';
  static const String ispaid = 'ispaid';
}
