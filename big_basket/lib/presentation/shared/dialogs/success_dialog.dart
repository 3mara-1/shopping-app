import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
final String message;
  final VoidCallback onClose;

  const SuccessDialog({
    super.key,
    this.message = 'Account created successfully', 
    required this.onClose,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Align(
            //   alignment: Alignment.topRight,
            //   child: IconButton(
            //     icon: Icon(Icons.close, color: Colors.grey),
            //     onPressed: onClose,
            //   ),),
               Icon(
              Icons.check_circle_outline, 
              color: Colors.teal,
              size: 70.0,
            ),
            SizedBox(height: 12),
            Text(
              tr('success'),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal, 
              ),
            ),
            SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
             height: MediaQuery.of(context).size.width * 0.14,
              child: ElevatedButton(
                onPressed: onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, 
                  // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  tr('close'),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

          ]
        )
      )
    );
  }
}