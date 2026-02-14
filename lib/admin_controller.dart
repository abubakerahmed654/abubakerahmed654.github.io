import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable state
  final applications = <Map<String, dynamic>>[].obs;
  final selectedFilter = 'All'.obs;
  final selectedTypeFilter = 'All'.obs;
  final searchQuery = ''.obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _listenToApplications();
  }

  // ─── REAL-TIME LISTENER ────────────────────────────────────
  void _listenToApplications() {
    _firestore
        .collection('applications')
        .orderBy('submittedAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        applications.value = snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        isLoading.value = false;
      },
      onError: (e) {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          'Failed to load applications',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
  }

  // ─── COMPUTED STATS ────────────────────────────────────────
  int get totalCount => applications.length;
  int get creatorsCount =>
      applications.where((d) => d['Type'] == 'Creator').length;
  int get brandsCount =>
      applications.where((d) => d['Type'] == 'Brand').length;
  int get pendingCount =>
      applications.where((d) => d['status'] == 'pending').length;
  int get approvedCount =>
      applications.where((d) => d['status'] == 'approved').length;
  int get rejectedCount =>
      applications.where((d) => d['status'] == 'rejected').length;

  // ─── FILTERED LIST ─────────────────────────────────────────
  List<Map<String, dynamic>> get filteredApplications {
    return applications.where((d) {
      // Status filter
      if (selectedFilter.value != 'All' &&
          d['status'] != selectedFilter.value.toLowerCase()) {
        return false;
      }
      // Type filter
      if (selectedTypeFilter.value != 'All' &&
          d['Type'] != selectedTypeFilter.value) {
        return false;
      }
      // Search
      if (searchQuery.value.isNotEmpty) {
        final name = (d['fullName'] ?? '').toString().toLowerCase();
        final email = (d['email'] ?? '').toString().toLowerCase();
        final query = searchQuery.value.toLowerCase();
        return name.contains(query) || email.contains(query);
      }
      return true;
    }).toList();
  }

  // ─── ACTIONS ───────────────────────────────────────────────
  Future<void> updateStatus(String docId, String newStatus) async {
    try {
      await _firestore.collection('applications').doc(docId).update({
        'status': newStatus,
        'reviewedAt': FieldValue.serverTimestamp(),
      });
      Get.snackbar(
        'Success',
        'Application $newStatus',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update status',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> deleteApplication(String docId) async {
    try {
      await _firestore.collection('applications').doc(docId).delete();
      Get.snackbar(
        'Deleted',
        'Application removed',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete application',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }

  void setSearchQuery(String value) => searchQuery.value = value;
  void setStatusFilter(String value) => selectedFilter.value = value;
  void setTypeFilter(String value) => selectedTypeFilter.value = value;
}