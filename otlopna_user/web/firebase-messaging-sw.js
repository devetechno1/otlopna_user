importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyCot2HfkqBSi3mvZb1VXC9A-g9UHO0xKh0",
  authDomain: "otlopna.firebaseapp.com",
  projectId: "otlopna",
  storageBucket: "otlopna.firebasestorage.app",
  messagingSenderId: "1039942312396",
  appId: "1:1039942312396:web:fb58b5bba1a8ef4155bd69",
  measurementId: "G-HVH45DN3JM"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});