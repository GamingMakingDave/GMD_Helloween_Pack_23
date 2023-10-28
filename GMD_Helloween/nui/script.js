var ScreamAudio = new Audio("../nui/data/scream.mp3");


window.addEventListener("message", function (event) {
    var item = event.data;
    if (item.type === "screem") {
        console.log("joa")
        $(".scream_container").show();
        ScreamAudio.play();
        

    }
});
