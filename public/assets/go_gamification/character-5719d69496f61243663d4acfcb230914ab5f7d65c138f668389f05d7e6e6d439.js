

var canvas;
var context;
var images = {};
var totalResources = 9;
var numResourcesLoaded = 0;
var fps = 30;
var charX = 245;
var charY = 185;
var breathInc = 0.1;
var breathDir = 1;
var breathAmt = 0;
var breathMax = 2;
var breathInterval = setInterval(updateBreath, 1000 / fps);
var maxEyeHeight = 14;
var curEyeHeight = maxEyeHeight;
var eyeOpenTime = 0;
var timeBtwBlinks = 4000;
var blinkUpdateTime = 200;
var blinkTimer = setInterval(updateBlink, blinkUpdateTime);
var fpsInterval = setInterval(updateFPS, 1000);
var numFramesDrawn = 0;
var curFPS = 0;
var jumping = false;

function updateFPS() {

    curFPS = numFramesDrawn;
    numFramesDrawn = 0;
}
function prepareCanvas(canvasDiv, canvasWidth, canvasHeight)
{
    // Create the canvas (Neccessary for IE because it doesn't know what a canvas element is)
    canvas = document.createElement('canvas');
    canvas.setAttribute('width', canvasWidth);
    canvas.setAttribute('height', canvasHeight);
    canvas.setAttribute('id', 'canvas');
    canvasDiv.appendChild(canvas);

    if(typeof G_vmlCanvasManager != 'undefined') {
        canvas = G_vmlCanvasManager.initElement(canvas);
    }
    context = canvas.getContext("2d"); // Grab the 2d canvas context
    // Note: The above code is a workaround for IE 8and lower. Otherwise we could have used:
    //     context = document.getElementById('canvas').getContext("2d");

    canvas.width = canvas.width; // clears the canvas
    context.fillText("loading...", 40, 140);

    loadImage(("/assets/go_gamification/leftArm-c9fed40cf0afde87710695474ba1ae5a8e995d7c219fbb45827b95d508a56bef.png"));
    loadImage(("/assets/go_gamification/legs-598e7faf5e40418320498505394c290a7b261146ab10e816560f1b4e1873e247.png"));
    loadImage(("/assets/go_gamification/torso-d64ab1a81ebc6650b4c0b5f65f839e9350edc99c36be9ba27ab7bd58487d0278.png"));
    loadImage(("/assets/go_gamification/rightArm-12025f55d54d8679dc1cf38e8d4c0f37c6394542e4699498d59b8d12687061ad.png"));
    loadImage(("/assets/go_gamification/head-57fd08b136c0941c476bf5221186abaa27875700ba8c10a0fd2910dc0ae8c65e.png"));
    loadImage(("/assets/go_gamification/hair-dd2e712cc3e6e97c39cccb41eb9e4d21ec547cc622ff601009cb8dd404ae22b9.png"));
    loadImage(("/assets/go_gamification/leftArm-jump-5504b1fb8426471925bbd62afce5388061aa19ae909991ccebf0115301127ea6.png"));
    loadImage(("/assets/go_gamification/legs-jump-53793c4640fcc30009df0bc7725e3bf8f5300fe803e326aea8c24ff84f238c65.png"));
    loadImage(("/assets/go_gamification/rightArm-jump-006dc01bf9a236c366962e87f47d61582b527b5d06b986c90d04dc52249f86e4.png"));
}

function loadImage(name) {

    images[name] = new Image();
    images[name].onload = function() {
        resourceLoaded();
    }
    images[name].src =  name;
}

function resourceLoaded() {

    numResourcesLoaded += 1;
    if(numResourcesLoaded === totalResources) {

        setInterval(redraw, 1000 / fps);
    }
}

function redraw() {

    var x = charX;
    var y = charY;
    var jumpHeight = 45;

    canvas.width = canvas.width; // clears the canvas

    // Draw shadow
    if (jumping) {
        drawEllipse(x + 40, y + 29, 100 - breathAmt, 4);
    } else {
        drawEllipse(x + 40, y + 29, 160 - breathAmt, 6);
    }

    if (jumping) {
        y -= jumpHeight;
    }

    if (jumping) {
        context.drawImage(images["/assets/go_gamification/leftArm-jump-5504b1fb8426471925bbd62afce5388061aa19ae909991ccebf0115301127ea6.png"], x + 40, y - 42 - breathAmt);
    } else {
        context.drawImage(images["/assets/go_gamification/leftArm-c9fed40cf0afde87710695474ba1ae5a8e995d7c219fbb45827b95d508a56bef.png"], x + 40, y - 42 - breathAmt);
    }

    if (jumping) {
        context.drawImage(images["/assets/go_gamification/legs-jump-53793c4640fcc30009df0bc7725e3bf8f5300fe803e326aea8c24ff84f238c65.png"], x, y- 6);
    } else {
        context.drawImage(images["/assets/go_gamification/legs-598e7faf5e40418320498505394c290a7b261146ab10e816560f1b4e1873e247.png"], x, y);
    }

    context.drawImage(images["/assets/go_gamification/torso-d64ab1a81ebc6650b4c0b5f65f839e9350edc99c36be9ba27ab7bd58487d0278.png"], x, y - 50);
    context.drawImage(images["/assets/go_gamification/head-57fd08b136c0941c476bf5221186abaa27875700ba8c10a0fd2910dc0ae8c65e.png"], x - 10, y - 125 - breathAmt);
    context.drawImage(images["/assets/go_gamification/hair-dd2e712cc3e6e97c39cccb41eb9e4d21ec547cc622ff601009cb8dd404ae22b9.png"], x - 37, y - 138 - breathAmt);

    if (jumping) {
        context.drawImage(images["/assets/go_gamification/rightArm-jump-006dc01bf9a236c366962e87f47d61582b527b5d06b986c90d04dc52249f86e4.png"], x - 35, y - 42 - breathAmt);
    } else {
        context.drawImage(images["/assets/go_gamification/rightArm-12025f55d54d8679dc1cf38e8d4c0f37c6394542e4699498d59b8d12687061ad.png"], x - 15, y - 42 - breathAmt);
    }

    drawEllipse(x + 47, y - 68 - breathAmt, 8, curEyeHeight); // Left Eye
    drawEllipse(x + 58, y - 68 - breathAmt, 8, curEyeHeight); // Right Eye
}

function drawEllipse(centerX, centerY, width, height) {

    context.beginPath();

    context.moveTo(centerX, centerY - height/2);

    context.bezierCurveTo(
        centerX + width/2, centerY - height/2,
        centerX + width/2, centerY + height/2,
        centerX, centerY + height/2);

    context.bezierCurveTo(
        centerX - width/2, centerY + height/2,
        centerX - width/2, centerY - height/2,
        centerX, centerY - height/2);

    context.fillStyle = "black";
    context.fill();
    context.closePath();
}

function updateBreath() {

    if (breathDir === 1) {  // breath in
        breathAmt -= breathInc;
        if (breathAmt < -breathMax) {
            breathDir = -1;
        }
    } else {  // breath out
        breathAmt += breathInc;
        if(breathAmt > breathMax) {
            breathDir = 1;
        }
    }
}

function updateBlink() {

    eyeOpenTime += blinkUpdateTime;

    if(eyeOpenTime >= timeBtwBlinks){
        blink();
    }
}

function blink() {

    curEyeHeight -= 1;
    if (curEyeHeight <= 0) {
        eyeOpenTime = 0;
        curEyeHeight = maxEyeHeight;
    } else {
        setTimeout(blink, 10);
    }
}

function jump() {

    if (!jumping) {
        jumping = true;
        setTimeout(land, 500);
    }

}
function land() {

    jumping = false;

}
;
