const sendNotif = (message, type, duration) => {
  Shiny.notification.show({
    html: `<strong>${message}</strong>`,
    type: type
    duration: duration
  });
};
