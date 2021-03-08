$(function() {
  // Taken from Colin
  const getPokemon = () => {
    // FETCHING THE API DATA
    let randId = Math.floor(Math.random() * (+151 + 1 - +1)) + +1;
    fetch('https://pokeapi.co/api/v2/pokemon/' + randId)
    // DEFINE WHAT HAPPENS WHEN JAVASCRIPT RECEIVES THE DATA
    .then((data) =>{
      // TURN THE DATA TO JSON
      data.json().then((res) => {
        // SEND THE JSON TO R
        Shiny.setInputValue('pokeData', res, {priority: 'event'})
      })
    })
    // DEFINE WHAT HAPPENS WHEN THERE IS AN ERROR FETCHING THE API
    .catch((error) => {
      alert('Error catching result from API')
    })
  };

  // add event listener
  $('#button').on('click', function() {
    getPokemon();
  });

  // update background based on R data
  Shiny.addCustomMessageHandler('update_background', function(message) {
    $('body').css({
      'background-image':'url(' + message +')',
      'background-repeat':'no-repeat'
    });
  });
});
