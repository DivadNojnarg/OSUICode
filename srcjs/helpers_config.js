export const setConfig = () => {
  // collect all data elements stored in body
 let config = $(document).find("script[data-for='app']");
 config = JSON.parse(config.html());

 // always erase existing root value just in case the user changes the root.
 // This may be harmful
 config.root = "#app";

  // store app methods
  config.methods =  {
    toggleDarkTheme: function() {
      let self = this;
      let $html = self.$("html");
      $html.toggleClass("theme-dark");
    }
  };

  // check if the app is intended to be a PWA
  let isPWA = $('body').attr('data-pwa') === "true";

  if (isPWA) {
    config.serviceWorker = {
      path: window.location.pathname + "service-worker.js",
      scope: window.location.pathname
    };
  }

  // Widgets cache
  config.data = function() {
    return {
      // any other widget type to cache ...
      gauge: []
    };
  };

  return config;
}
