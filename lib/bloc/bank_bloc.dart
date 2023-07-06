import 'package:curie_pay/model/bank.dart';
import 'package:curie_pay/repository/bank_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  BankRepo bankRepo = BankRepo();
  BankBloc() : super(BankUninitialized()) {
    on<LoadBank>((event, emit) async {
      emit(BankLoading());
      await Future.delayed(Duration(seconds: 5));
      try {
        List<Banks> banks = await _fetchBanks();
        emit(BankLoaded(bankList: banks));
      } catch (e) {
        BankEventFailed(errorMessage: "Failed to load");
      }
    });
  }

  Future<List<Banks>> _fetchBanks() async {
    try {
      final List<Banks> animeQuotes = await bankRepo.loadBanks();
      return animeQuotes;
    } catch (e) {
      throw Exception('error fetching quotes');
    }
  }
}
