import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_products_demo/src/features/authentication/data/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'authentication_repository_impl_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth, 
  FirebaseFirestore,
  UserCredential, 
  User, 
  DocumentSnapshot,
  CollectionReference, 
  DocumentReference,
  ])
void main() {
  setupFirebaseCoreMocks();
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  });
  

  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockUser mockUser;
  late MockDocumentSnapshot<Map<String, dynamic>> mockDocumentSnapshot;
  late MockCollectionReference<Map<String, dynamic>> mockCollectionReference;
  late MockDocumentReference<Map<String, dynamic>> mockDocumentReference;
  final repository = AuthenticationRepositoryImpl();

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockUser = MockUser();
    mockDocumentSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();
    mockCollectionReference = MockCollectionReference<Map<String, dynamic>>();
    mockDocumentReference = MockDocumentReference<Map<String, dynamic>>();
  });

  group("getUser method", () {
    test('Should return UserModel when fetch user datas', () async {
   /*   when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('mockUid');

      when(mockDocumentSnapshot.data()).thenReturn({
        'name': 'name',
        'email': 'johndoe@example.com',
        'photoUrl': 'https://example.com/photo.jpg',
      }); */

      when(mockFirebaseFirestore.collection(any)).thenReturn(mockCollectionReference);
      when(mockCollectionReference.doc(any)).thenReturn(mockDocumentReference);
      when(mockDocumentReference.get()).thenAnswer((_) async => mockDocumentSnapshot);
      
      final userModel = await repository.getUser();

      expect(userModel, isNotNull);
      expect(userModel!.name, 'John Doe');
      expect(userModel.email, 'johndoe@example.com');
      expect(userModel.photoUrl, 'https://example.com/photo.jpg');
    });
  });

  group("Login method", () {
    test('Should Login successfully', () async {
      final userCredential = MockUserCredential();

      when(mockFirebaseAuth.signInWithEmailAndPassword(email: 'email', password: 'password')).thenAnswer((_) async => userCredential);

      await mockFirebaseAuth.signInWithEmailAndPassword(
        email: 'email',
        password: 'password',
      );

      verify(mockFirebaseAuth.signInWithEmailAndPassword(email: 'email', password: 'password')).called(1);
    });
  });

  group("Logout method", () {
    test('Should Logout successfully', () async {
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => Future.value);

      await mockFirebaseAuth.signOut();

      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });
}
