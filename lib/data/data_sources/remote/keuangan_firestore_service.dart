import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ifgf_apps/data/models/trx_response.dart';
import 'package:uuid/uuid.dart';

class KeuanganFirestoreService {
  final FirebaseFirestore _firebaseFirestore;

  KeuanganFirestoreService(
    FirebaseFirestore? firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore ??= FirebaseFirestore.instance;

  Future<void> createTrx({
    String? jenisTrx,
    String? category,
    String? createdAt,
    String? nominal,
    String? note,
  }) async {
    try {
      final String trxlId = const Uuid().v4();
      await _firebaseFirestore.collection('keuangan').doc(trxlId).set({
        'id': trxlId,
        'jenis_trx': jenisTrx,
        'kategori': category,
        'created_at': createdAt,
        'nominal': num.parse(nominal ?? ""),
        'catatan': note,
      });
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal menyimpan data transaksi: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menyimpan data transaksi: ${e.toString()}');
    }
  }

  Future<TrxListSummaryResponse> getListTrx({
    String? date,
    String? category,
  }) async {
    try {
      final now = DateTime.now();
      final filterDate =
          date != null ? DateTime.parse(date) : DateTime(now.year, now.month);

      final startOfMonth = DateTime(filterDate.year, filterDate.month, 1);
      final endOfMonth =
          DateTime(filterDate.year, filterDate.month + 1, 0, 23, 59, 59);


      Query<Map<String, dynamic>> query = _firebaseFirestore
          .collection('keuangan')
          .where('created_at',
              isGreaterThanOrEqualTo: startOfMonth.toIso8601String())
          .where('created_at',
              isLessThanOrEqualTo: endOfMonth.toIso8601String());

      if (category != null) {
        query = query.where('kategori', isEqualTo: category);
      }

      query = query.orderBy('created_at', descending: true);

      final querySnapshot = await query.get();

      final List<TrxResponse> trxList = querySnapshot.docs
          .map((doc) => TrxResponse.fromMap(doc.data()))
          .toList();

      num totalPemasukan = 0;
      num totalPengeluaran = 0;

      for (var trx in trxList) {
        final nominal = trx.nominal ?? 0;
        if (trx.jenisTrx?.toLowerCase() == "pemasukan") {
          totalPemasukan += nominal;
        } else if (trx.jenisTrx?.toLowerCase() == "pengeluaran") {
          totalPengeluaran += nominal;
        }
      }

      return TrxListSummaryResponse(
        data: trxList,
        totalPemasukan: totalPemasukan.toString(),
        totalPengeluaran: totalPengeluaran.toString(),
        totalSaldo: (totalPemasukan - totalPengeluaran).toString(),
      );
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengambil data keuangan: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data keuangan: ${e.toString()}');
    }
  }

  Future<TrxResponse?> getOneTrx({String? id}) async {
    try {
      final docSnapshot =
          await _firebaseFirestore.collection('keuangan').doc(id).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        if (data != null) {
          debugPrint(data.toString());
          return TrxResponse.fromMap(data);
        }
      }
      return null;
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengambil data transaksi: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengambil data transaksi: ${e.toString()}');
    }
  }

  Future<void> updateTrx({
    required String id,
    String? jenisTrx,
    String? category,
    String? createdAt,
    String? nominal,
    String? note,
  }) async {
    try {
      final docRef = _firebaseFirestore.collection('keuangan').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final updateData = <String, dynamic>{};

        if (jenisTrx != null) updateData['jenis_trx'] = jenisTrx;
        if (createdAt != null) updateData['created_at'] = createdAt;
        if (category != null) updateData['kategori'] = category;
        if (nominal != null) updateData['nominal'] = num.parse(nominal);
        if (note != null) updateData['catatan'] = note;

        await docRef.update(updateData);
      } else {
        throw Exception('Data transaksi dengan id $id tidak ditemukan.');
      }
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal mengupdate data transaksi: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal mengupdate data transaksi: ${e.toString()}');
    }
  }

  Future<void> deleteTrx({String? id}) async {
    try {
      final docRef = _firebaseFirestore.collection('keuangan').doc(id);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        await docRef.delete();
        debugPrint("✅ transaksi dengan ID $id berhasil dihapus.");
      } else {
        throw Exception("transaksi dengan ID $id tidak ditemukan.");
      }
    } on FirebaseException catch (e) {
      throw Exception(
          'Gagal menghapus data transaksi: ${e.code} - ${e.message}');
    } catch (e) {
      throw Exception('Gagal menghapus data transaksi: ${e.toString()}');
    }
  }
}
