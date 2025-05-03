class Validators {
  // Validasi untuk email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null; // Tidak ada error
  }

  // Validasi untuk password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null; // Tidak ada error
  }

  // Validasi untuk nama
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    return null; // Tidak ada error
  }

  // Validasi untuk nomor HP
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor HP tidak boleh kosong';
    }
    final phoneRegex = RegExp(r'^\+62\d{9,12}$'); // Format: +62xxx
    if (!phoneRegex.hasMatch(value)) {
      return 'Nomor HP tidak valid';
    }
    return null; // Tidak ada error
  }

  // Validasi untuk input wajib (misal, nama atau alamat)
  static String? validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field ini tidak boleh kosong';
    }
    return null;
  }
}
