importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDP6eaZUIlOlWWo9s3gYLP4oc-38D2LRbE",
  authDomain: "on-demand-750df.firebaseapp.com",
  projectId: "on-demand-project",
  storageBucket: "on-demand-750df.appspot.com",
  messagingSenderId: "361171276071",
  appId: "1:892059356546:web:ab5d88d2663a70b4f5139b",
  databaseURL: "...",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});