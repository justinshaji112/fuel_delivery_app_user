import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A centralized exception handler for the entire application
class AppExceptionHandler {
  /// Handles any exception type and returns a user-friendly error message
  static String handleException(dynamic exception) {
    if (exception is FirebaseAuthException) {
      return _handleAuthException(exception);
    } else if (exception is FirebaseException) {
      // This covers Firestore, Storage, and other Firebase services
      return _handleFirebaseException(exception);
    } else if (exception is SocketException) {
      return 'Network error. Please check your internet connection.';
    } else if (exception is FormatException) {
      return 'Invalid data format. Please check your input.';
    } else if (exception is TimeoutException) {
      return 'Operation timed out. Please try again later.';
    } else if (exception is HttpException) {
      return 'HTTP error occurred. Please try again later.';
    } else if (exception is IOException) {
      return 'Error accessing file or data.';
    } else if (exception is StateError) {
      return 'Application state error. Please restart the app.';
    } else if (exception is ArgumentError) {
      return 'Invalid argument provided to operation.';
    } else if (exception is NoSuchMethodError) {
      return 'An unexpected application error occurred.';
    } else if (exception is AssertionError) {
      return 'Application assertion failed. Please contact support.';
    } else if (exception is TypeError) {
      return 'Unexpected data type encountered. Please try again.';
    } else if (exception is Exception) {
      // Handle any other Exception types
      return 'An error occurred: ${exception.toString()}';
    } else {
      // For non-Exception errors (like Error)
      return 'An unexpected error occurred: ${exception.toString()}';
    }
  }

  /// Handle Firebase Auth specific exceptions
  static String _handleAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      // Sign in / Sign up errors
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'email-already-in-use':
        return 'An account already exists with this email address.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      
      // Account verification errors
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
        
      // Password reset errors
      case 'expired-action-code':
        return 'The action code has expired.';
      case 'invalid-action-code':
        return 'The action code is invalid.';
        
      // Account linking errors
      case 'credential-already-in-use':
        return 'This credential is already associated with another account.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      
      // Additional auth errors
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email but different sign-in credentials.';
      case 'invalid-credential':
        return 'The provided credential is invalid or has expired.';
      case 'invalid-continue-uri':
        return 'The continue URL provided is invalid.';
      case 'invalid-phone-number':
        return 'The phone number is invalid.';
      case 'missing-verification-code':
        return 'The verification code is missing.';
      case 'missing-verification-id':
        return 'The verification ID is missing.';
      case 'network-request-failed':
        return 'A network error occurred. Please check your connection and try again.';
      case 'provider-already-linked':
        return 'The provider is already linked to the user.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
        
      default:
        return 'Authentication error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle other Firebase exceptions (Firestore, Storage, etc.)
  static String _handleFirebaseException(FirebaseException exception) {
    // Check the service the exception is from
    if (exception.plugin == 'cloud_firestore') {
      return _handleFirestoreException(exception);
    } else if (exception.plugin == 'firebase_storage') {
      return _handleStorageException(exception);
    } else if (exception.plugin == 'firebase_database') {
      return _handleRealtimeDatabaseException(exception);
    } else if (exception.plugin == 'firebase_functions') {
      return _handleCloudFunctionsException(exception);
    } else if (exception.plugin == 'firebase_messaging') {
      return _handleMessagingException(exception);
    } else {
      return 'Firebase error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Firestore specific exceptions
  static String _handleFirestoreException(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'You don\'t have permission to access this resource.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'failed-precondition':
        return 'Operation failed due to the current state of the system.';
      case 'aborted':
        return 'The operation was aborted.';
      case 'out-of-range':
        return 'Operation was attempted past the valid range.';
      case 'unavailable':
        return 'The service is currently unavailable. Please try again later.';
      case 'data-loss':
        return 'Unrecoverable data loss or corruption.';
      case 'unauthenticated':
        return 'User is not authenticated. Please sign in and try again.';
      case 'resource-exhausted':
        return 'Resource quota exceeded or rate limit reached.';
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'Unknown error occurred.';
      case 'deadline-exceeded':
        return 'Operation timed out. Please try again.';
      case 'invalid-argument':
        return 'Invalid argument provided to Firestore operation.';
      default:
        return 'Firestore error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Firebase Storage specific exceptions
  static String _handleStorageException(FirebaseException exception) {
    switch (exception.code) {
      case 'storage/object-not-found':
        return 'File does not exist.';
      case 'storage/unauthorized':
        return 'You don\'t have permission to access this file.';
      case 'storage/canceled':
        return 'The operation was cancelled.';
      case 'storage/unknown':
        return 'Unknown error occurred during storage operation.';
      case 'storage/retry-limit-exceeded':
        return 'Maximum time limit exceeded. Try again later.';
      case 'storage/invalid-checksum':
        return 'File upload failed due to checksum mismatch.';
      case 'storage/quota-exceeded':
        return 'Storage quota exceeded.';
      case 'storage/unauthenticated':
        return 'User is not authenticated. Please sign in and try again.';
      case 'storage/invalid-url':
        return 'Invalid URL provided to storage operation.';
      case 'storage/invalid-argument':
        return 'Invalid argument provided to storage operation.';
      case 'storage/no-default-bucket':
        return 'No default bucket has been set.';
      case 'storage/cannot-slice-blob':
        return 'Cannot slice the file for upload.';
      case 'storage/server-file-wrong-size':
        return 'File on the server does not match the expected size.';
      default:
        return 'Firebase Storage error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Realtime Database specific exceptions
  static String _handleRealtimeDatabaseException(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'You don\'t have permission to access this database path.';
      case 'disconnected':
        return 'Client is disconnected from the Realtime Database.';
      case 'database/network-error':
        return 'A network error occurred. Please check your connection.';
      case 'database/unauthorized-domain':
        return 'The domain is not authorized for database operations.';
      case 'database/quota-exceeded':
        return 'Database quota exceeded.';
      case 'database/max-retries-exceeded':
        return 'Maximum retry attempts exceeded.';
      case 'database/invalid-argument':
        return 'Invalid argument provided to database operation.';
      case 'database/write-cancelled':
        return 'The database write operation was cancelled.';
      default:
        return 'Realtime Database error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Cloud Functions specific exceptions
  static String _handleCloudFunctionsException(FirebaseException exception) {
    switch (exception.code) {
      case 'functions/cancelled':
        return 'The cloud function operation was cancelled.';
      case 'functions/unknown':
        return 'An unknown error occurred in the cloud function.';
      case 'functions/invalid-argument':
        return 'Invalid argument provided to cloud function.';
      case 'functions/deadline-exceeded':
        return 'Cloud function deadline exceeded. Please try again.';
      case 'functions/not-found':
        return 'The requested cloud function was not found.';
      case 'functions/already-exists':
        return 'The cloud function resource already exists.';
      case 'functions/permission-denied':
        return 'Permission denied for cloud function.';
      case 'functions/unauthenticated':
        return 'Not authenticated for cloud function access.';
      case 'functions/resource-exhausted':
        return 'Cloud function resources exhausted.';
      case 'functions/failed-precondition':
        return 'Cloud function precondition failed.';
      case 'functions/aborted':
        return 'The cloud function operation was aborted.';
      case 'functions/out-of-range':
        return 'Cloud function operation out of range.';
      case 'functions/unimplemented':
        return 'Cloud function not implemented.';
      case 'functions/internal':
        return 'Internal error in cloud function.';
      case 'functions/unavailable':
        return 'Cloud functions service unavailable.';
      case 'functions/data-loss':
        return 'Data loss in cloud function operation.';
      default:
        return 'Cloud Functions error: ${exception.message ?? exception.code}';
    }
  }

  /// Handle Firebase Messaging specific exceptions
  static String _handleMessagingException(FirebaseException exception) {
    switch (exception.code) {
      case 'messaging/permission-blocked':
        return 'Notifications are blocked. Please enable them in your device settings.';
      case 'messaging/registration-token-not-registered':
        return 'The device registration token is invalid.';
      case 'messaging/failed-service-not-available':
        return 'Messaging service is currently unavailable.';
      case 'messaging/invalid-registration-token':
        return 'Invalid registration token provided.';
      case 'messaging/invalid-sender':
        return 'Invalid message sender.';
      case 'messaging/message-rate-exceeded':
        return 'Message rate exceeded. Please try again later.';
      case 'messaging/quota-exceeded':
        return 'Messaging quota exceeded.';
      case 'messaging/mismatched-credential':
        return 'The credentials provided do not match authorized credentials.';
      case 'messaging/invalid-argument':
        return 'Invalid argument provided to messaging operation.';
      default:
        return 'Firebase Messaging error: ${exception.message ?? exception.code}';
    }
  }
}