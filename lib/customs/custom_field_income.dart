import 'package:flutter/material.dart';

class CustomTransactionField extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obsecure;
  final String label;
  final String hint;
  final Function onTap;
  final IconData icon;
  final String? Function(String?)? validator;

  const CustomTransactionField(
      {super.key,
      required this.textEditingController,
      required this.obsecure,
      required this.label,
      required this.icon,
      required this.hint,
      required this.onTap,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: TextFormField(
          controller: textEditingController,
          obscureText: false,
          autofocus: false,
          onTap: () {
            onTap();
          },
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            prefixIconColor: Color(0xFF57636C),
            hintText: hint,
            labelText: label,
            labelStyle: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              color: Color(0xFF57636C),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFF1F4F8),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFF4B39EF),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE0E3E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFE0E3E7),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: const Color(0xFFF1F4F8),
          ),
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            color: Color(0xFF101213),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          validator: validator),
    );
  }
}
