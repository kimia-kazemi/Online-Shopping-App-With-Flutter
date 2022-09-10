class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;


  final bool isDarkMode;
   int likedNumber;

  User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
    required  this.likedNumber

  });

  User copy({
    String? imagePath,
    String? name,
    String? email,
    String? about,
    bool? isDarkMode,
    int? likedNumber,

  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        email: email ?? this.email,
        about: about ?? this.about,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        likedNumber: likedNumber ?? this.likedNumber,
      );


  static User fromJson(Map<String, dynamic> json) => User(
    imagePath: json['imagePath'],
    name: json['name'],
    email: json['email'],
    about: json['about'],
    isDarkMode: json['isDarkMode'],

    likedNumber: json['likedNumber']  ,

  );

  Map<String, dynamic> toJson() => {
    'imagePath': imagePath,
    'name': name,
    'email': email,
    'about': about,
    'isDarkMode': isDarkMode,
    'likedNumber': likedNumber,

  };
}
