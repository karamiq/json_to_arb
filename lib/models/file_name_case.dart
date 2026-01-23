// /// File naming case options: preserve original or convert to camelCase.
// enum FileNameCase {
//   /// Keep original file name format.
//   /// Example: home_screen.json → home_screen prefix, user_profile.json → user_profile prefix
//   preserve,

//   /// Convert to camelCase format.
//   /// Example: home_screen.json → homeScreen prefix, user_profile.json → userProfile prefix
//   camel;

//   /// Convert to string representation.
//   String get value {
//     switch (this) {
//       case FileNameCase.preserve:
//         return 'preserve';
//       case FileNameCase.camel:
//         return 'camel';
//     }
//   }

//   /// Create FileNameCase from string.
//   static FileNameCase fromYaml(String? value) {
//     switch (value?.toLowerCase()) {
//       case null:
//         return FileNameCase.camel; // Default to camel when not specified
//       case 'preserve':
//         return FileNameCase.preserve;
//       case 'camel':
//         return FileNameCase.camel;
//       default:
//         throw ArgumentError(
//           'Unknown file name case: $value. Supported values are: preserve, camel',
//         );
//     }
//   }
// }
