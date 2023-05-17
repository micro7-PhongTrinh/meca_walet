import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class CancelMembershipDialog extends StatelessWidget {
  const CancelMembershipDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Xóa thẻ thành viên',
          style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor)),
      content: const Text(
          'Thẻ thành viên sẽ bị vô hiệu hóa. Bạn sẽ không còn là khách hàng thân thiết tại cửa hàng. Bạn có muốn tiếp tục?',
          style: TextStyle(color: kTextColorAccent, height: 1.4)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
