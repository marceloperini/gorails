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

var parts = [
    {name: 'leftArm',ident: "/assets/go_gamification/leftArm-c9fed40cf0afde87710695474ba1ae5a8e995d7c219fbb45827b95d508a56bef.png", visible: true, x: charX + 40, y: charY - 42 - breathAmt},
    {name:'leftArmjump',ident: "/assets/go_gamification/leftArm-jump-5504b1fb8426471925bbd62afce5388061aa19ae909991ccebf0115301127ea6.png", visible: false, x: charX + 40, y: charY - 42 - breathAmt},
    {name: 'legs',ident: "/assets/go_gamification/legs-598e7faf5e40418320498505394c290a7b261146ab10e816560f1b4e1873e247.png", visible: true, x: charX, y: charY},
    {name: 'legsjump',ident: "/assets/go_gamification/legs-jump-53793c4640fcc30009df0bc7725e3bf8f5300fe803e326aea8c24ff84f238c65.png", visible: false, x: charX, y: charY-6},
    {name: 'torso',ident: "/assets/go_gamification/torso-d64ab1a81ebc6650b4c0b5f65f839e9350edc99c36be9ba27ab7bd58487d0278.png", visible: true, x: charX, y: charY - 50},
    {name: 'head',ident: "/assets/go_gamification/head-57fd08b136c0941c476bf5221186abaa27875700ba8c10a0fd2910dc0ae8c65e.png", visible: true, x: charX - 10, y: charY - 125 - breathAmt},
    {name: 'hair',ident: "/assets/go_gamification/hair-43787a30ec03a098b2e31520ad466cf961b525492f92fcac866401f6d417b960.png", visible: true, x: charX - 37, y: charY - 138 - breathAmt},
    {name: 'rightArm',ident: "/assets/go_gamification/rightArm-12025f55d54d8679dc1cf38e8d4c0f37c6394542e4699498d59b8d12687061ad.png", visible: true, x: charX - 15, y: charY - 42 - breathAmt},
    {name: 'rightArmjump',ident: "/assets/go_gamification/rightArm-jump-006dc01bf9a236c366962e87f47d61582b527b5d06b986c90d04dc52249f86e4.png", visible: false, x: charX - 35, y: charY - 42 - breathAmt},

];

var bodyParts = [];

var num_of_imgs = parts.length + 2;
var loaded_imgs = 0;

function myLoop() {
    bg.draw();

    //update the cloud
    cx = cloud.x - cloudSpeed;

    if(cx+cloud.width < 0) {
        cx = engine._stageWidth + 20;
        cy = Math.floor(Math.random()*230);
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
        src: "/assets/go_gamification/background-c448686d1b265eae131e77704c0c3dd93cc0583a39487e0e3e1f43c7cfd79b65.png",
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
