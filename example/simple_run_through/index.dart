library index;

import 'dart:js_interop';

import 'package:lawndart/lawndart.dart';
import 'package:web/web.dart';

extension on Element {
  String get innerHtml => (innerHTML as JSString).toDart;
  set innerHtml(String html) {
    innerHTML = html.toJS;
  }
}

void runThrough(Store store, String id) async {
  var elem = document.getElementById('$id')!;

  try {
    await store.nuke();
    await store.save(id, "hello");
    await store.save("is fun", "dart");
    await for (var value in store.all()) {
      elem.innerHtml += '$value, ';
    }
    elem.innerHtml += 'all done';
  } catch (e) {
    elem.innerHtml = e.toString();
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
