library index;

import 'package:lawndart/lawndart.dart';
import 'package:web/web.dart';

void runThrough(Store store, String id) async {
  var elem = document.getElementById('$id')!;

  try {
    await store.nuke();
    await store.save(id, "hello");
    await store.save("is fun", "dart");
    await for (var value in store.all()) {
      elem.innerHTML += '$value, ';
    }
    elem.innerHTML += ('all done');
  } catch (e) {
    elem.text = e.toString();
  }
}

void main() async {
  if (IndexedDbStore.supported) {
    var store = await IndexedDbStore.open('test', 'test');
    runThrough(store, 'indexeddb');
  } else {
    document.getElementById('indexeddb')?.text =
        'IndexedDB is not supported in your browser';
  }
}
