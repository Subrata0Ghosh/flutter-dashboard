class Project {
  final String title;
  final String subtitle;
  final String imageUrl; // Using image URL instead of hex color
  final bool isHighlighted;

  const Project({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.isHighlighted = false,
  });
}

class Creator {
  final String username;
  final int artworks;
  final int rating;
  final double ratingPercent;
  final String avatarUrl;

  const Creator({
    required this.username,
    required this.artworks,
    required this.rating,
    required this.ratingPercent,
    required this.avatarUrl,
  });
}

class BirthdayPerson {
  final String name;
  final String avatarColor;
  final String assetPath;

  const BirthdayPerson({required this.name, required this.avatarColor, required this.assetPath});
}

final List<Project> sampleProjects = [
  const Project(
    title: 'Technology behind the Blockchain',
    subtitle: 'Project #1 • See project details',
    imageUrl: 'assets/images/project_blockchain.png', // Generated AI image of server
    isHighlighted: true,
  ),
  const Project(
    title: 'Technology behind the Blockchain',
    subtitle: 'Project #1 • See project details',
    imageUrl: 'assets/images/project_phone.jpg', // Phone image
  ),
  const Project(
    title: 'Technology behind the Blockchain',
    subtitle: 'Project #1 • See project details',
    imageUrl: 'assets/images/project_laptop.jpg', // Laptop image
  ),
];

final List<Creator> topCreators = [
  const Creator(
    username: '@maddison_c21',
    artworks: 9821,
    rating: 9821,
    ratingPercent: 0.92,
    avatarUrl: 'assets/images/memoji_girl.png',
  ),
  const Creator(
    username: '@karl.wil802',
    artworks: 7032,
    rating: 7032,
    ratingPercent: 0.70,
    avatarUrl: 'assets/images/memoji_boy.png',
  ),
  const Creator(
    username: '@maddison_c21',
    artworks: 9821,
    rating: 9821,
    ratingPercent: 0.82,
    avatarUrl: 'assets/images/memoji_girl.png',
  ),
  const Creator(
    username: '@maddison_c21',
    artworks: 9821,
    rating: 9821,
    ratingPercent: 0.75,
    avatarUrl: 'assets/images/memoji_girl.png',
  ),
];

final List<BirthdayPerson> birthdayPeople = [
  const BirthdayPerson(name: 'Alice', avatarColor: '#7C3AED', assetPath: 'assets/images/memoji_girl.png'),
  const BirthdayPerson(name: 'Bob', avatarColor: '#EC4899', assetPath: 'assets/images/memoji_boy.png'),
];

final List<BirthdayPerson> anniversaryPeople = [
  const BirthdayPerson(name: 'Jane', avatarColor: '#F97316', assetPath: 'assets/images/memoji_girl.png'),
  const BirthdayPerson(name: 'John', avatarColor: '#3B82F6', assetPath: 'assets/images/memoji_boy.png'),
  const BirthdayPerson(name: 'Mike', avatarColor: '#10B981', assetPath: 'assets/images/memoji_boy.png'),
];
