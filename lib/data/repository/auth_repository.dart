import 'package:ifgf_apps/data/data_sources/remote/auth_api_service.dart';

class AuthRepository {
  final authApiService = AuthApiService();

  // Future<DataState<LoginResponse>> signIn({
  //   String? username,
  //   String? password,
  // }) async {
  //   try {
  //     final response = await authApiService.signIn(
  //       username: username,
  //       password: password,
  //     );

  //     switch (response.statusCode) {
  //       case HttpStatus.ok:
  //       case HttpStatus.created:
  //         final data = LoginResponse.fromMap(response.data["data"]);

  //         if (data.id != null) {
  //           SharedPref.loginResponse = data;
  //           final profileResponse = await ProfileRepository().getProfile();

  //           if (profileResponse is DataSuccess) return DataSuccess(data);
  //         }

  //         response.data["code"] = 400;
  //         response.data["message"] =
  //             "Periksa kembali username dan password anda";

  //         return DataFailed(
  //           DioException(
  //             error: response.statusMessage,
  //             response: response,
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.requestOptions,
  //           ),
  //         );
  //       default:
  //         return DataFailed(
  //           DioException(
  //             error: response.statusMessage,
  //             response: response,
  //             type: DioExceptionType.badResponse,
  //             requestOptions: response.requestOptions,
  //           ),
  //         );
  //     }
  //   } on DioException catch (e) {
  //     log(e.toString(), stackTrace: StackTrace.current);
  //     return DataFailed(e);
  //   } catch (e) {
  //     return DataFailed(
  //       DioException(
  //         error: e.toString(),
  //         response: null,
  //         type: DioExceptionType.unknown,
  //         requestOptions: RequestOptions(),
  //       ),
  //     );
  //   }
  // }
}
