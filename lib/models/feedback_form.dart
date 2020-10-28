class FeedbackForm {
  String sn;
  String houseNum;
  String familyHeadName;
  String familyMemberName;
  String hfName;
  String gender;
  String religion;
  String dob;
  String profession;
  String srNr;
  String dod;
  String other;
  String erase;

  FeedbackForm({
    this.sn="",
    this.houseNum="",
    this.familyHeadName="",
    this.familyMemberName="",
    this.hfName="",
    this.gender="",
    this.religion="",
    this.dob="",
    this.profession="",
    this.srNr="",
    this.dod="",
    this.other="",
    this.erase="f",
  });

  String toParams() =>
      "?sn=$sn&houseNum=$houseNum&familyHeadName=$familyHeadName&familyMemberName=$familyMemberName&hfName=$hfName&gender=$gender&religion=$religion&dob=$dob&profession=$profession&srNr=$srNr&dod=$dod&other=$other&erase=$erase";
}
