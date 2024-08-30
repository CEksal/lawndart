import 'package:lawndart/lawndart.dart';
import 'package:web/web.dart';

void main() async {
  Store store = await Store.open('temptestdb', 'store1');
  print('opened 1');
  await Store.open('temptestdb', 'store2');
  print('opened 2');
  await store.all().toList();
  print('all done');
  document.querySelector('#text')?.text = 'all done';
}
