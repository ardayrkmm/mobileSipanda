// Mocks generated by Mockito 5.4.4 from annotations
// in mobilecapstone/test/Auth.mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:io' as _i6;
import 'dart:ui' as _i7;

import 'package:mobilecapstone/models/UserModel.dart' as _i5;
import 'package:mobilecapstone/providers/authP.dart' as _i3;
import 'package:mobilecapstone/services/SessionService.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSessionService_0 extends _i1.SmartFake
    implements _i2.SessionService {
  _FakeSessionService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [authP].
///
/// See the documentation for Mockito's code generation for more information.
class MockauthP extends _i1.Mock implements _i3.authP {
  MockauthP() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SessionService get session => (super.noSuchMethod(
        Invocation.getter(#session),
        returnValue: _FakeSessionService_0(
          this,
          Invocation.getter(#session),
        ),
      ) as _i2.SessionService);

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<Map<String, dynamic>> buatAkun(_i5.UserModel? user) =>
      (super.noSuchMethod(
        Invocation.method(
          #buatAkun,
          [user],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> login(
    String? Email,
    String? pass,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            Email,
            pass,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> mintaToken(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #mintaToken,
          [email],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> resetPassword(
    String? email,
    String? token,
    String? password,
    String? ConfirmPassword,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [
            email,
            token,
            password,
            ConfirmPassword,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<Map<String, dynamic>> updateProfil(
    int? id,
    String? nama,
    String? email,
    String? noTelepon,
    _i6.File? imgProfil,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateProfil,
          [
            id,
            nama,
            email,
            noTelepon,
            imgProfil,
          ],
        ),
        returnValue:
            _i4.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i4.Future<Map<String, dynamic>>);

  @override
  _i4.Future<void> logout() => (super.noSuchMethod(
        Invocation.method(
          #logout,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
