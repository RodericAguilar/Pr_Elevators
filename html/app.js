const sound = new Audio('https://r2.fivemanage.com/R92pivz8ZlXwjJjTvi3Oq/elevator-ding-at-arenco-tower-dubai-38520.mp3');
const elevatorSound = new Audio('https://r2.fivemanage.com/rDF92kFR7F8pjYfg0Fq5U/20131106_elevator-door-closing_zoomh6xy-87444.mp3');

window.addEventListener('message', function (event) { 
    var v = event.data;
    switch (v.action) {
        case 'show':
            $('.botones').append(`<button class="botonjs" id="${v.numbers.number}-click">${v.numbers.number}</button>`);
            $('.plantName').text(`${v.planta}`)
            $('.container').fadeIn();
            $(`#${v.planta}-click`).prop("disabled",true)
            $(`#${v.planta}-click`).css('background-color', 'rgba(131, 131, 124, 0.233)')
            $(`#${v.numbers.number}-click`).click(function() {
                firstSound()
                $.post(`https://${GetParentResourceName()}/tp`, JSON.stringify({ floorInfo: v.currentInfo, floorIndex: v.numbers.number }));
                CloseAll();
                setTimeout(() => {
                    secondSound()
                }, 1000)
            });
        break;
    }
});

function firstSound() {
    sound.pause();
    sound.currentTime = 0;
    sound.play();
}

function secondSound() {
    elevatorSound.pause();
    elevatorSound.currentTime = 0;
    elevatorSound.play();
}


$(document).keyup((e) => {
    if (e.key === 'Escape') {
        CloseAll();
    }
});

function CloseAll() {
    $('.botones').empty(); 
    $('.container').fadeOut();
    $.post(`https://${GetParentResourceName()}/exit`);
}
