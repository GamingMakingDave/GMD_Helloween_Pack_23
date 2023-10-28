var ScreamAudio = new Audio("../nui/data/jumpscare.mp3");

ScreamAudio.volume = 1.0; 

window.addEventListener("message", function (event) {
    var item = event.data;
    if (item.type === "screem") {
        $(".scream_container").show();
        ScreamAudio.play();
        $(".scream_container").css({
            'filter': 'brightness(90%) grayscale(50%) blur(3px)'
        });
        ScreamAudio.addEventListener("ended", function() {
            $(".scream_container").fadeOut();
        });
    }
});

