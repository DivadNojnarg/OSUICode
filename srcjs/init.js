// Import helper functions
import { setConfig } from './helpers_config.js'
import { initTheme } from './helpers_theme.js'
import { setPWA } from './helpers_pwa.js'
import { setCustomDisconnect } from './helpers_disconnect.js'

$( document ).ready(function() {
  let config = setConfig();
  // create app instance
  app = new Framework7(config);
  // init main view
  mainView = app.views.create('.view-main');
  // Set theme: dark mode, touch, filled, color, taphold css
  let isDark = initTheme(config, app);
  config.dark = isDark;
  // Set custom disconnect screen
  setCustomDisconnect(app);
  // PWA setup
  setPWA(app);

  app.notification.create({
    text: 'Hello, how are you?',
    on: {
      opened: function () {
        console.log('Notification opened');
      }
    }
  }).open();

  // equivalent to setTimeout ...
  app.utils.nextTick(function() {
    app.notification.create({
      text: 'You look great!'
    }).open();
  }, 2000);

  // taphold test
  $('#mybutton').on('taphold', function () {
    app.dialog.alert('Tap hold fired!');
  });
});
