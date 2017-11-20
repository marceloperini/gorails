var charX = 50;
var charY = 108;

var breathInc = 0.1;
var breathDir = 1;
var breathAmt = 0;
var breathMax = 2;
var maxEyeHeight = 14;
var curEyeHeight = maxEyeHeight;
var eyeOpenTime = 0;
var timeBtwBlinks = 200;
var blinkUpdateTime = 1;
var blinkCounter = 0;
var numFramesDrawn = 0;
var curFPS = 0;

var isJumping = false;
var jumpHeight = 45;
var cloudSpeed = 0.5;


var bodyParts = [];

var num_of_imgs = parts.length + 2;
var loaded_imgs = 0;

function myLoop() {
    bg.draw();

    //update the cloud
    cx = cloud.x - cloudSpeed;

    if(cx+cloud.width < 0) {
        cx = engine._stageWidth + 20;
        cy = Math.floor(Math.random()*50);
        cloud.y = cy;
    }

    cloud.x = cx;
    cloud.draw();

    x = charX;
    y = charY;

    if(isJumping) {
        y -= jumpHeight;
    }

    character.y = y;
    // Update parts for breathing
    bodyParts.head.y = charY - 125 - breathAmt;
    bodyParts.hair.y = charY - 138 - breathAmt;

    if(isJumping) {
        bodyParts.leftArmjump.visible = true;
        bodyParts.rightArmjump.visible = true;
        bodyParts.legsjump.visible = true;

        bodyParts.leftArm.visible = false;
        bodyParts.rightArm.visible = false;
        bodyParts.legs.visible = false;
    } else {
        bodyParts.leftArmjump.visible = false;
        bodyParts.rightArmjump.visible = false;
        bodyParts.legsjump.visible = false;

        bodyParts.leftArm.visible = true;
        bodyParts.rightArm.visible = true;
        bodyParts.legs.visible = true;

        bodyParts.leftArm.y = charY - 42 - breathAmt;
        bodyParts.rightArm.y = charY - 42 - breathAmt;
    }

    bodyParts.leftEye.y = charY - 68 - breathAmt;
    bodyParts.rightEye.y = charY - 68 - breathAmt;

    eyeOpenTime += blinkUpdateTime;

    if(eyeOpenTime >= timeBtwBlinks) {
        blink();
    }

    bodyParts.leftEye.height = curEyeHeight;
    bodyParts.rightEye.height = curEyeHeight;

    character.draw();
    fps_text.text = "Current FPS: " + engine.getFPS();
    fps_text.draw();
    updateBreath();
}

$(document).ready(function() {
    engine = new bHive({
        width: 301,
        height: 301,
        domobject: 'stageholder',
        backgroundColor: '#000'
    });

    engine.addEventListener('onclick',function(e) {
        // Jumping
        if(!isJumping) {
            isJumping = true;
            setTimeout(land, 500);
        }
    });

    character = engine.createClip({
        x: charX,
        y: charY
    });

    for(part in parts) {
        o = parts[part];
        bodyParts[o.name] = engine.createBitmap({
            src: o.ident ,
            x: o.x,
            y: o.y,
            visible: o.visible
        });

        bodyParts[o.name].addEventListener('onload',increaseLoaded);
        character.add(bodyParts[o.name]);
    }

    bodyParts['leftEye'] = engine.createShape({
        shape: 'elipse',
        style: 'filled',
        x: charX + 47,
        y: charY - 68 - breathAmt,
        width: 8,
        height: curEyeHeight,
    });

    bodyParts['rightEye'] = engine.createShape({
        shape: 'elipse',
        style: 'filled',
        x: charX + 58,
        y: charY - 68 - breathAmt,
        width: 8,
        height: curEyeHeight
    });

    character.add(bodyParts['leftEye']);
    character.add(bodyParts['rightEye']);

    bg = engine.createBitmap({
        src: "/assets/go_gamification/background-e92495e6434d9052ebfab26f8f2a2973a2e2bd6909a680f1d81e252a4e995c8b.png",
        x: 0,
        y: 0
    });

    bg.addEventListener('onload',increaseLoaded);

    cloud = engine.createBitmap({
        src: "/assets/go_gamification/cloud-1652db495cd64f26febc8d41cfd8afa7d1972a2085f19a7f264bad62917a484a.png",
        x: engine._stageWidth + 20,
        y: 80
    });

    cloud.addEventListener('onload',increaseLoaded);

    fps_text = engine.createText({
        text: "FPS",
        color: 'rgba(255,255,255,1)',
        x: 20,
        y: 20
    });

    setTimeout("checkforload()",1000);
});

function increaseLoaded() {
    loaded_imgs++;
}

function checkforload() {
    if(loaded_imgs == num_of_imgs) {
        console.log("loaded");
        engine.theLoop(myLoop);
    } else {
        setTimeout("checkforload()",1000);
    }
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

function blink() {
    curEyeHeight -= 2;
    if (curEyeHeight <= 0) {
        eyeOpenTime = 0;
        curEyeHeight = maxEyeHeight;
    }
}

function land() {
    isJumping = false;
}

;
