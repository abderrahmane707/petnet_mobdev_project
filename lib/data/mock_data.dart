// lib/data/mock_data.dart

class MockUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String wilaya;
  final String role;
  final String avatar;

  const MockUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.wilaya,
    required this.role,
    required this.avatar,
  });
}

class MockShelter {
  final String id;
  final String name;
  final String location;
  final String phone;
  final String description;
  final int animalsCount;

  const MockShelter({
    required this.id,
    required this.name,
    required this.location,
    required this.phone,
    required this.description,
    required this.animalsCount,
  });
}

class MockRequest {
  final String id;
  final String animalName;
  final String requesterName;
  final String type;
  final String status;
  final String date;

  const MockRequest({
    required this.id,
    required this.animalName,
    required this.requesterName,
    required this.type,
    required this.status,
    required this.date,
  });
}

class MockConversation {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool unread;

  const MockConversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unread = false,
  });
}

// USERS

const kMockUsers = [
  MockUser(
    id: 'u1',
    name: 'Rami',
    email: 'rami@example.com',
    phone: '0550000001',
    wilaya: 'Algiers',
    role: 'Adopter',
    avatar: 'assets/images/rami.png',
  ),
  MockUser(
    id: 'u2',
    name: 'Sara',
    email: 'sara@example.com',
    phone: '0550000002',
    wilaya: 'Oran',
    role: 'Owner',
    avatar: 'assets/images/profile.png',
  ),
];

// SHELTERS

const kMockShelters = [
  MockShelter(
    id: 's1',
    name: 'Refuge El Rifq',
    location: 'Algiers',
    phone: '0551000001',
    description: 'A shelter dedicated to helping animals find loving homes.',
    animalsCount: 12,
  ),
  MockShelter(
    id: 's2',
    name: 'Hope Animals',
    location: 'Oran',
    phone: '0551000002',
    description: 'Rescue and adoption community.',
    animalsCount: 8,
  ),
  MockShelter(
    id: 's3',
    name: 'Pet Care Association',
    location: 'Blida',
    phone: '0551000003',
    description: 'Helping abandoned animals.',
    animalsCount: 6,
  ),
];

// REQUESTS

const kMockRequests = [
  MockRequest(
    id: 'r1',
    animalName: 'Rami',
    requesterName: 'Amine',
    type: 'Adoption',
    status: 'Pending',
    date: 'Today',
  ),
  MockRequest(
    id: 'r2',
    animalName: 'Mina',
    requesterName: 'Lina',
    type: 'Foster',
    status: 'Accepted',
    date: 'Yesterday',
  ),
  MockRequest(
    id: 'r3',
    animalName: 'Nougat',
    requesterName: 'Yasmine',
    type: 'Adoption',
    status: 'Pending',
    date: '2 days ago',
  ),
];

// CONVERSATIONS

const kMockConversations = [
  MockConversation(
    id: 'c1',
    name: 'Refuge El Rifq',
    lastMessage: 'Thank you for your interest!',
    time: '10:30',
    unread: true,
  ),
  MockConversation(
    id: 'c2',
    name: 'Amine',
    lastMessage: 'Is the puppy still available?',
    time: 'Yesterday',
  ),
  MockConversation(
    id: 'c3',
    name: 'Sara',
    lastMessage: 'I will send you more photos.',
    time: 'Monday',
  ),
];

/// 'adopter' | 'owner' | 'shelter'  (MVP: in-memory, no backend)
String selectedUserRole = 'adopter';