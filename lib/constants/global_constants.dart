// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:dh_flutter_v2/constants/app_constants.dart';
import 'package:dh_flutter_v2/model/chat_model.dart';
import 'package:dh_flutter_v2/model/message_model.dart';
import 'package:flutter/material.dart';

const String errorDialogIcon = "assets/images/error.png";
const String warningDialogIcon = "assets/images/warning.png";
const String successDialogIcon = "assets/images/success.png";
List<String> languagesList = [
  'English',
  'Amharic',
  'Afaan Oromo',
  'Tigrinya',
  'Somalia',
  'Sidama',
  'Gurage',
  'Wolayta',
  'Afar',
  'Hadiya',
  'Gamo',
  'Arabic',
  'Other',
];

List<String> gradeLevelList = [
  'KG',
  '1 - 4',
  '5 - 8',
  '9 - 10',
  '11 - 12',
];
List<String> allAvailableSubjects = [
  'English',
  'Civics',
  'Mathematics',
  'Physics',
  'Biology',
  'Chemistry',
  'Economics',
  'Geography',
  'History',
  'Social Studies',
  'Programming',
  'Spanish',
  'French',
  'Mandarin',
  'SAT',
  'IELTS',
  'TOEFL',
];

List<String> allAgeGroupsList = [
  'New Born',
  'Toddler',
  'School Age',
];
List<String> givenServicesEmployer = [
  'Tutor',
  'Private Nurse',
  'Maid',
  'Sales',
  'Nanny',
  'Information Technology',
  'Customer service',
  'Accounting and Finance',
  'Sales and Marketing',
  'Secretarial and Clerical',
  'Hotel and Tourism',
  'Human resource',
  'Logistics',
  'Education',
  'Health Care',
  'Engineering',
  'Economics',
  'Management',
  'Other',
];

final List<String> religions = [
  "Orthodox",
  "Muslim",
  "Protestant",
  "Catholic",
  "Other",
];

final List<String> allAgeRange = [
  "18 - 25",
  "25 - 30",
  "30 - 40",
  "40 - 50",
  "> 51",
];

final List<String> allSalaryRange = [
  " < 1000",
  "1000-2000",
  "2000 - 3000",
  "3000 - 4000",
  "4000 - 5000",
  "5000 - 6000",
  "> 6000"
];
final List<String> cities = [
  "Abomsa",
  "Adama",
  "Addis Ababa",
  "Addis Zemen",
  "Adet",
  "Adigrat",
  "Agaro",
  "Ä€reka",
  "Arba Minch",
  "Asaita",
  "Assbe Tefera",
  "Assosa",
  "Assosa",
  "Axum",
  "Bahir Dar",
  "Bako",
  "Bata",
  "Bedele",
  "Bedesa",
  "Bichena",
  "Bishoftu",
  "Boditi",
  "Bonga",
  "Bure",
  "Butajira",
  "Debark",
  "Debre Birhan",
  "Debre Markos",
  "Debre Tabor",
  "Dessie",
  "Dilla",
  "Dire Dawa",
  "Dodola",
  "Dubti",
  "Felege Neway",
  "Fiche",
  "Finote Selam",
  "Gambela",
  "Gebre Guracha",
  "Gelemso",
  "Genet",
  "Gimbi",
  "Ginir",
  "Goba",
  "Gondar",
  "Golwayn",
  "Hagere Hiywet",
  "Hagere Maryam",
  "Harar",
  "Hosaaina",
  "Inda Silase",
  "Jijiga",
  "Jimma",
  "Jinka",
  "Kahandhale",
  "Kemise",
  "Kibre Mengist",
  "Korem",
  "Lasoano",
  "Maychew",
  "Mek'ele",
  "Metahara",
  "Metu",
  "Mojo",
  "Nazret",
  "Neefkuceliye",
  "Nejo",
  "Qorof",
  "Raqo",
  "Robit",
  "Sodo",
  "Sebeta",
  "Shakiso",
  "Shambu",
  "Shashemene",
  "Waliso",
  "Wenji",
  "Werota",
  "Yabelo",
  "Yamarugley",
  "Yirga Alem",
  "Ziway",
  "Waal",
  "Fadhigaradle",
  "Gedo",
  "Digih Habar Es"
];
final List<String> specificLocations = [
  "Jemo",
  "Denbel",
  "Bole",
  "Addisu gebeya",
  "Mexico",
  "Megenagna"
];

final List<String> educationLevels = [
  "Degree",
  "Diploma",
  "High school",
  "Elementary",
  "Not educated",
  "Higher Education",
];
final List<String> allEducationLevels = [
  "Phd",
  "Masters",
  "Degree",
  "Diploma",
  "High school",
  "Elementary",
  "Not educated",
  "Higher Education",
];
final List<String> higherEducation = [
  "Phd",
  "Masters",
  "Degree",
  "Diploma",
  "Higher Education",
];

final List<String> experienceLevelEnglish = [
  "0 year",
  "0-1 year",
  "1-2 years",
  "2-3 years",
  "3-4 years",
  "> 4 years"
];
Map<String, String> experienceLevel = {
  "No experience": "No experience",
  "0-1 year": "0-1 year",
  "1-2 years": "1-2 years",
  "2-3 years": "2-3 years",
  "3-4 years": "3-4 years",
  "4-5 years": "4-5 years",
  "More than 5 years": "More than 5 years"
};
Map<String, String> jobTypes = {
  'Full time': 'Full time',
  'Part time': 'Part time',
};
Map<String, String> types = {
  'Employer': 'Employer',
  'Employee': 'Employee',
};

final List<String> salaryExpectations = [
  "1000+ ",
  "2000+ ",
  "3000+ ",
  "4000+ ",
  "5000+ "
];

Map<String, String> days = {
  "Monday": "Monday",
  "Tuesday": "Tuesday",
  "Wednesday": "Wednesday",
  "Thursday": "Thursday",
  "Friday": "Friday",
  "Saturday": "Saturday",
  "Sunday": "Sunday"
};
final List<String> categories = [
  "Information Technology",
  "Customer service",
  "Accounting and Finance",
  "Sales and Marketing",
  "Secretarial and Clerical",
  "Hotel and Tourism",
  "Human resource",
  "Logistics",
  "Education",
  "Health Care",
  "Engineering",
  "Economics",
  "Management",
  "Other"
];
final List<String> allCategories = [
  'Tutor',
  'Private Nurse',
  'Sales',
  'Maid',
  'Nanny',
  "Information Technology",
  "Customer service",
  "Accounting and Finance",
  "Sales and Marketing",
  "Secretarial and Clerical",
  "Hotel and Tourism",
  "Human resource",
  "Logistics",
  "Education",
  "Health Care",
  "Engineering",
  "Economics",
  "Management",
  "Other"
];

Map<String, String> servicesAvailable = {
  'Tutor': 'Tutor',
  'Private Nurse': 'Private Nurse',
  'Sales': 'Sales',
  'Maid': 'Maid',
  'Nanny': 'Nanny',
  'Other': 'Other'
};

List<String> leaveJobReasons = [
  "Lack of career growth opportunities",
  "Uncompetitive compensation and benefits",
  "Inadequate management and leadership",
  "Limited recognition and appreciation",
  "Unsatisfactory company culture",
  "Job dissatisfaction",
  "Relocation or personal circumstances",
  "Health problems",
  "Better opportunities or offers",
  "Finished the contract",
  "Discipline",
];
Map userData = {};
Map jobFormData = {};
Map updateData = {};
Map filterData = {};
String userId = "";
String userRole = "";
String userName = "";
String accessToken = "";
String refereshToken = "";
String userPhone = "";
String employeeService = "";
String myFcmId = "";
bool requested = false;
bool takeExam = false;
bool hasTaken = false;
bool hasPassed = false;
bool isExamMandatory = false;
List examsTaken = [];
var ctx;

int time_out = 60;
// bool isSignin = false;
bool isBeingMaintained = false;
String recentVersion = "";
bool chapaStatus = true;
String today = "";
DateTime dateToday = DateTime(2023);
bool getData = false;
bool allActionTaken = true;
bool newApplication = false;
List<ChatModel> listOfChatUsers = [];
List<ChatModel> allChatUsers = [];
List<MessageModel> messages = [];
var validatorRegEx = RegExp(r'[^a-zA-Z0-9\s.,!?]');
String employeeRegistrationFee = "50";
String employerRegistrationFeeOne = "150";
String employerRegistrationFeeThree = "200";
String employerRegistrationFeeSix = "250";
String employerRegistrationFeeTwelve = "300";
String selectedLanguage = "";
String contactPhone = "+251978443971";
String facebookUrl = "https://www.facebook.com/emebetdotnet";
String instagramUrl = "https://www.instagram.com/emebetdotnet";
String linkedinUrl = "https://www.linkedin.com/company/emebet/";
String telegramUrl = "https://www.t.me/emebetdotnet";
String termsUrl = "https://emebet.net/public/user/termsandconditions";
String privacyUrl = "https://emebet.net/public/user/privacyPolicy";
String emailUrl = "support@emebet.net";
int selectedBottomNavBarIndex = 0;
final Map<String, Color> letterColors = {
  'A': Colors.red,
  'B': const Color.fromRGBO(255, 152, 0, 1),
  'C': Colors.yellow,
  'D': Colors.green,
  'E': Colors.blue,
  'F': Colors.indigo,
  'G': Colors.purple,
  'H': Colors.pink,
  'I': Colors.brown,
  'J': Colors.grey,
  'K': Colors.cyan,
  'L': AppConstants.iconColor,
  'M': AppConstants.primaryColor,
  'N': Colors.amber,
  'O': Colors.deepOrange,
  'P': Colors.deepPurple,
  'Q': Colors.lightBlue,
  'R': Colors.lightGreen,
  'S': Colors.red,
  'T': Colors.teal,
  'U': Colors.orangeAccent,
  'V': Colors.redAccent,
  'W': Colors.green,
  'X': Colors.blueAccent,
  'Y': AppConstants.primaryColor,
  'Z': Colors.pinkAccent,
};
