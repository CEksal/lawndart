//Copyright 2012 Google
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

part of lawndart;

abstract class _MapStore extends Store {
  Map<String, Object> storage = {};

  _MapStore._() : super._();

  @override
  Future<bool> _open() async {
    storage = _generateMap();
    return true;
  }

  Map<String, String> _generateMap();

  @override
  Stream<String> keys() async* {
    for (var k in storage.keys) {
      yield k;
    }
  }

  @override
  Future<String> save(dynamic obj, String key) async {
    storage[key] = obj;
    return key;
  }

  @override
  Future batch(Map<String, Object> objs) async {
    for (var key in objs.keys) {
      storage[key] = objs[key]!;
    }
    return true;
  }

  @override
  Future<Object?> getByKey(String key) async {
    return storage[key];
  }

  @override
  Stream<Object> getByKeys(Iterable<String> keys) async* {
    var values = keys.map((key) => storage[key]).where((v) => v != null);
    for (var v in values) {
      yield v!;
    }
  }

  @override
  Future<bool> exists(String key) async {
    return storage.containsKey(key);
  }

  @override
  Stream<Object> all() async* {
    for (var v in storage.values) {
      yield v;
    }
  }

  @override
  Future removeByKey(String key) async {
    storage.remove(key);
    return true;
  }

  @override
  Future removeByKeys(Iterable<String> keys) async {
    keys.forEach((key) => storage.remove(key));
    return true;
  }

  Future nuke() async {
    storage.clear();
    return true;
  }
}
