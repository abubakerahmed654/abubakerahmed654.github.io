'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "307b33886e7e1f49831d6280cb3b31a6",
".git/config": "2bfdd53946f6f50489f5f1a6e70952e5",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "4cf2d64e44205fe628ddd534e1151b58",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "d9229009616d240d162daaa8708281bb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "a1170753cf2aec021dfdef57e94fedb7",
".git/logs/refs/heads/master": "a1170753cf2aec021dfdef57e94fedb7",
".git/logs/refs/remotes/origin/master": "30076aeffc338d3420ec58a259915f45",
".git/objects/01/f55ed643b75db9588961a3a32211011c781ce1": "4e688c5b9444e206e73d2559692f193d",
".git/objects/04/450f126e4a381f0b676c89aa12e1493f5f207d": "31b2873e9a24d82bc4079710e4b76c98",
".git/objects/05/d6fadddd85e72c95339338592c1e0e740908c8": "ecf215007bd9cbd87f709072eee3d80d",
".git/objects/06/059ae247b33fcf2428d481df98302587f9738b": "5db4006926b81d7a374feee9858f1dc9",
".git/objects/08/27c17254fd3959af211aaf91a82d3b9a804c2f": "360dc8df65dabbf4e7f858711c46cc09",
".git/objects/0f/a528f41fa890ea66fccc9f56f478004455af26": "328d26b04514f869299e4056529bd941",
".git/objects/0f/f230477450689387b4db825aa9769773449e1c": "7c9cc17462728785162b293d019da679",
".git/objects/15/adeabaa3485c0f2ec54adfea44c49c18fad031": "04699cd48163b3c143ab6a50065c83e5",
".git/objects/19/a0d5a6929d88bb0e9f8d334b0e32f74c467f92": "327b8e67253dab16de787444ebf5189c",
".git/objects/1b/c2c5f8b4fe896b018897ba020eb67381dab5ba": "caa44731c595e7d662f7540a6d767fc0",
".git/objects/1d/13c92170c8183c19437a660c6e60c3a1c4c18e": "acdd087b4c185fdf15a0e099325f25a6",
".git/objects/2a/64aee0b2061293d516491285f5b58f8620c79e": "48fbb1e481b0a5aa58638e95ad826b7d",
".git/objects/34/3d9c060061bbef8cb18c510dfd8f4d932419a9": "503e9374d8ace028f8152e8cc6176172",
".git/objects/37/6880b11b11b87fbd4e30b8e9283344423627fb": "f6aafe1ac21a313ccf08f1cc7df32b3a",
".git/objects/3a/8cda5335b4b2a108123194b84df133bac91b23": "1636ee51263ed072c69e4e3b8d14f339",
".git/objects/3f/cc0e26500232c58b525f10dd96a7e1366a89e9": "3bc4917a1859fa9966d3cb3c32f0f542",
".git/objects/41/ed39eedaa95213d8e8e57c1a591d72206e37f7": "07537a42b2ba8e6eaf4b8999e9c590a5",
".git/objects/43/deb2e44d8d55e2d0cb962ef35e3526a2a2f3be": "5b34e69af96c167d8abb1f22e3093b97",
".git/objects/4b/9e2d20cd9fe687080130bd9b5e60d32185d45c": "f07e4c621ce6c08f14bddc1ded04f319",
".git/objects/4e/3b05101a567736f7ca60a00169ad0fcc4d5f15": "16c5b99657c590ab2d8a853c5b2202c4",
".git/objects/4f/40dabe4430b4d7288c6ae92d8fc3e17cf8e410": "7c1843130f2c3787540ded5445c7793a",
".git/objects/51/03e757c71f2abfd2269054a790f775ec61ffa4": "d437b77e41df8fcc0c0e99f143adc093",
".git/objects/53/3bbf7e67edf8817e6b77bfdb7ced8c840aa86d": "37c67b5b92715d3cebcca20cef2b1166",
".git/objects/55/04e8f379dcc03321168704a4b09ec19eda1546": "0660b5dcbbf92273abe1f294227c2ba0",
".git/objects/59/2e02b44b30fb2089c10ce5e2ac358538902c90": "1d61f66a6b037bd0587d3cdec33e9bc6",
".git/objects/59/d619460680edd71ced9f0069dadd1a6ce3d15d": "6ee520d83f5a1295b58fcf2ee057fe5f",
".git/objects/59/f418a1941ef68e4d2bde2d55402e2793e8c9c5": "077be3f4a98da2f314efdc73ee332915",
".git/objects/5a/0c3dbeba8a54cef40b88245090298575115d00": "e0cb2aa8a08def96548deef00b6fdebe",
".git/objects/5a/16498cae29f265e06fdb24c8d3bc99888e4c1d": "0d67f9d48e7f5a03d27fd901aef5c8ce",
".git/objects/5e/444e354a99eef1104fea5005ed1e890d5cf898": "63536f6cf7346daec45e2767f5cb81bb",
".git/objects/60/0f8687b6fb5968f709fe73f039376328db11a8": "42d372ffcf8a0224a5536c473a1e8414",
".git/objects/63/5e2f0c6bdf64c1f5d069d171d3cfed0c063b25": "b87602b955fc12b3897d971db3d02176",
".git/objects/64/0dded4d775d3e31ebef856fa024ee46df6d8bb": "b41663a98d925a4796b4372aa6a55de3",
".git/objects/67/b22b21ddda9b6a47ee86875bf73318dd19118b": "36f9b8b392a70dd1fc32d3fe07e6013b",
".git/objects/67/e0a1b20c5cacdf9e7bd4ca71b7478f38692409": "8afe5dec34e32be71ecb53de9f026cb0",
".git/objects/68/43fddc6aef172d5576ecce56160b1c73bc0f85": "2a91c358adf65703ab820ee54e7aff37",
".git/objects/68/6f2db7f8d185e7d1d1b0e6975d4db67b8903a3": "86102139b85be826f07e3dcb5e9eceee",
".git/objects/6e/470412c8a966798814525a75b1fb1cf7a10348": "a393ca87861150ec327ab47aa5db8548",
".git/objects/6f/7661bc79baa113f478e9a717e0c4959a3f3d27": "985be3a6935e9d31febd5205a9e04c4e",
".git/objects/7c/3463b788d022128d17b29072564326f1fd8819": "37fee507a59e935fc85169a822943ba2",
".git/objects/7d/2510b2a3cc41da613c08a3050475ffc70f7e8d": "b0cff083415e2281bdcf423a13b114ed",
".git/objects/7d/27dba4b4c1173c4d4aa8c76fa24bd4cccfd43a": "873868c456ca0db7e9911c4a88e440c9",
".git/objects/82/039646eae58381941a128edf3dd254c98a2961": "ba71a4099c57c699fe2ac9b609735b8e",
".git/objects/84/6fd898806298359eb40baae1f7948020bd2ad0": "7f1a4e70a8daebe36b505f63d291ae52",
".git/objects/84/8f4d2b8c6900f4f2343813b78948bf3f231909": "404259b9413be7c378b373c99fc0e145",
".git/objects/85/63aed2175379d2e75ec05ec0373a302730b6ad": "997f96db42b2dde7c208b10d023a5a8e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8c/e4ed6d5b58469d26a43b220ac1c196e1f2a828": "53b747bbe4d87729571d7ae3d8503884",
".git/objects/8e/21753cdb204192a414b235db41da6a8446c8b4": "1e467e19cabb5d3d38b8fe200c37479e",
".git/objects/8e/2e889a19b499bde9930ef84712176fa277a5cd": "f8bc0a45715d899af489c65b44de5c9a",
".git/objects/90/bf03be3f6d7eea626763565b2fc0b5c5251553": "51977623906415bb2e0d3af05f9df607",
".git/objects/91/7fc2b9f29ef5a0883e73abab0c29d6a4dbd688": "844c3a63b2176d87319d52615e84ce7e",
".git/objects/93/b363f37b4951e6c5b9e1932ed169c9928b1e90": "c8d74fb3083c0dc39be8cff78a1d4dd5",
".git/objects/9e/89e556378bf49d0aa3f34027b33526987ae8ab": "5a0fb687ef9a64218c28de774217abd4",
".git/objects/a0/cde7cdfce8cd9748a6dbc9880b44af0e1d3871": "e6720f86dfb6040141d63df88602dd04",
".git/objects/a2/90f16be410f24a692baef46908ae3b5070829c": "ece2c8792476321358e82e3eb0b4c278",
".git/objects/a2/f287dd88d4ab2712bbd51ee32723693a35a608": "d2702e187d0732193989c5178275507b",
".git/objects/a7/3f4b23dde68ce5a05ce4c658ccd690c7f707ec": "ee275830276a88bac752feff80ed6470",
".git/objects/a8/bb2f2548f87dc10e7c14d6cd4865d5abd2f167": "7b93195a162ad75e76f2ccc5d682bead",
".git/objects/a9/af6d0b970aab8ed236ca1ae71b38923a5d953f": "e6371e4074cbdd68c73d67b72bb01816",
".git/objects/ad/ced61befd6b9d30829511317b07b72e66918a1": "37e7fcca73f0b6930673b256fac467ae",
".git/objects/b5/c07f941d71417625031761e89f867fb61702f1": "994a8ac99ee18184a36d7dfb489ee759",
".git/objects/b6/2818cfa1873c1742239bfe4471403d8e7818a3": "aa44a93a8810eed1298ccd628186b116",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/3e39bd49dfaf9e225bb598cd9644f833badd9a": "666b0d595ebbcc37f0c7b61220c18864",
".git/objects/c8/3af99da428c63c1f82efdcd11c8d5297bddb04": "144ef6d9a8ff9a753d6e3b9573d5242f",
".git/objects/ca/7703dfa0b0007b3cf80e6e6e283235eb3aa265": "ca6e86dabcb8677c6b9fa911292f7b53",
".git/objects/cd/498a5d4493ad480564c759e30b20db13448b11": "b026376dacbdf1c7d08b870bec7fede4",
".git/objects/d1/40fe72ba90894ea2d56b26c2022ae1c1fe0e22": "d31606fee8108c3f174fdd257dd70210",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d4/56bea19a0879e2577b12be756a23de22e36efb": "a5061fd27f7cba466026d435f6a0860a",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d9/5b1d3499b3b3d3989fa2a461151ba2abd92a07": "a072a09ac2efe43c8d49b7356317e52e",
".git/objects/de/8babdfbee97005226774032002da49e4fea54b": "c70915e5c9dd17321d47896362912564",
".git/objects/e0/a3dc2e0777640c00a43b3fbe75feb80ddd7f0a": "db4c3d752376cec58b8100ef7ec51f23",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/40c98c326d3194a4695b63df0787f3f375bd50": "d5f86204d05461af0e56008095c26f7f",
".git/objects/ee/1798963fce7b655168ec872a841e4e3d9802fb": "350b2a7b2c002da671efcc00643449b0",
".git/objects/f3/3e0726c3581f96c51f862cf61120af36599a32": "afcaefd94c5f13d3da610e0defa27e50",
".git/objects/f3/c28fe1f6bbfd09eedb440c11812f76a4a3b00f": "5f611233ae04b50731d15adbd8c309f9",
".git/objects/f6/b4957fe34dfc150c649d460ba7f63b4e18bc48": "1aaeacc2256d3da7d69bb51e9590ab5d",
".git/objects/f6/e6c75d6f1151eeb165a90f04b4d99effa41e83": "95ea83d65d44e4c524c6d51286406ac8",
".git/objects/f7/1258d3ac07dcf1842dae811263b2568639f819": "7b212d436ce1fb9cc7a8075d6fd56e49",
".git/objects/fc/fbe77c1a2520715c89817789474c4ca90385f2": "be8ebeb555ff5a6c3f0fbf13a4396968",
".git/objects/fd/05cfbc927a4fedcbe4d6d4b62e2c1ed8918f26": "5675c69555d005a1a244cc8ba90a402c",
".git/objects/ff/66f6da9b508ffb1519c2ec0331a8e502696639": "013a042fca713571619b80217662adb7",
".git/refs/heads/master": "37fcb661d451ca220e5c4ba27df592ca",
".git/refs/remotes/origin/master": "37fcb661d451ca220e5c4ba27df592ca",
"assets/AssetManifest.bin": "ca581238548488b69d20b2d9f2af4af9",
"assets/AssetManifest.bin.json": "0332f1e4c90bb2f248b7c5cbc0f82918",
"assets/assets/1.webp": "fb79594510fea4ff802b074595a46171",
"assets/assets/2.png": "3602ac4f5b29151d93e207d2c28cef61",
"assets/assets/5.jpg": "14945d06987d6fadb0c317f8fd15bb75",
"assets/FontManifest.json": "2a3f09429db12146b660976774660777",
"assets/fonts/MaterialIcons-Regular.otf": "013a07a639ddc5c4eab40bcee6b37dfa",
"assets/NOTICES": "99900f58dfe2186a72a4b139392bd4a1",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Brands-Regular-400.otf": "a0eaf072b0c2832c10ea1683bc821d55",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Regular-400.otf": "b2703f18eee8303425a5342dba6958db",
"assets/packages/font_awesome_flutter/lib/fonts/Font-Awesome-7-Free-Solid-900.otf": "5b8d20acec3e57711717f61417c1be44",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"flutter_bootstrap.js": "a60b435a701424727e15fae2292fa987",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "325641e8a40f4fea6975cd3355e186c5",
"/": "325641e8a40f4fea6975cd3355e186c5",
"main.dart.js": "ee9c521ff93c3fcb6be3b8ecd02baa10",
"manifest.json": "e77c5166ea3d3be53a770f0346b8f072",
"version.json": "b8d368c3bc058547de453441e2379bb9"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
