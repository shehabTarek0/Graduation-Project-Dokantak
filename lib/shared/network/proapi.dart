import 'dart:convert';
import 'package:g_project/models/data.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future<List<Dataa>> getProducts(String query) async {
    final url = Uri.parse('https://care.ssd-co.com/api/admin/product');
    final response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5M2U4NTVlMi0zMDYxLTQ2NGItYTljNC0zMzYwMDJhNDcxMGUiLCJqdGkiOiJmNDY0MTQ3NGVjZGQyYTE1YzY5MDRlMmUzNWY3YjRhOTYyMmYzNWFmMGNmNDBkMTgyYzkxZWIwYTkwZDU0MWRmZjYyZTdiOTEzN2Y3YWI5YSIsImlhdCI6MTY1NDY4ODE1My41Njc5MDcsIm5iZiI6MTY1NDY4ODE1My41Njc5MTQsImV4cCI6MTY4NjIyNDE1My41NTUxNSwic3ViIjoiMSIsInNjb3BlcyI6W119.K0lt2QSf6TxK3gug9SZESeP8IKDkKfXJCtVinhQUOYt8Y2Rhy1B5g32SIehFggjWbNUXQERBSgb-rot_4Z_seJcaY3-TUyaBtgIjw0x6slXSzGnSCDsBE_Sf9IPDcYngwYbIDzLUogbdrw5sayuwkf9DSjCAYHLqUHvi3WYxSJb4QXGIhBjJcXYQfl3gMOfTTIHV_OQDUgutjWTP0IKpIfKviMnNtvuq_JLaT2FTmhwmQrxv1R0p2UPrIFGAVCTuE-fM10TpbuV3l3DasltvfjbMRYauDm66p1UN_1ynd_SuXbJimpf2TjuMIfVzy6kZim1pHAzhB2g1CLnU5FcyIyTVbttFHgsuaailwO2lC42vsp5L2mp94mRI8aK7PWU0wV5z65BeaGtk_A9cK0g-DUw-Qh1aSs2biLDY7Dn5fcp77A8Qiawmp_YDZ_mG-oYKwC-g7RyLRgewrdAOdGnPK93BF8WVsJQklLknqdY4EoLhHav28TfV_CEz9pp1VvzOQKoPMyDufR3x3iPWeX8ByxJaqEsvUIGkrsPpxPymq-gSH0CpzQxCGtsxQ-6QLdvNUHS_Odfc2WT9se0QaDan0YU9rtCKlhVTDtRJd8H8RcNDASPpC2jt_B7ihIn1A0lw4Hai7fQ--IE2vr56CmvGT2t0uQvNFDnJq8C0d6bdKxs',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> products = map["data"];
      return products.map((json) => Dataa.fromJson(json)).where((data) {
        final productName = data.productName!.toLowerCase();
        final searchLower = query.toLowerCase();
        return productName.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
