function bHive(a) {
    this.setStageDimensions(a.width, a.height);
    this.setStageObject(a.domobject);
    this.init();
    for (var c in a) {
        this[c] = a[c]
    }
    if (a.hasOwnProperty("backgroundColor")) {
        this.setStageColor(a.backgroundColor)
    }
    if (a.hasOwnProperty("globalCompositeOperation")) {
        this.setGlobalComposite(a.globalCompositeOperation)
    }
}bHive.fn = bHive.prototype = {
    stageTarget: null,
    stageObject: null,
    stage2d: null,
    undef: "undefined",
    defGA: 1,
    clearFrame: true,
    debug: false,
    _objects: [],
    _events: [],
    _radians: Math.PI / 180,
    _mouseX: 0,
    _mouseY: 0,
    _stageHeight: 320,
    _stageWidth: 256,
    _frameRate: 33,
    _fpsInterval: new Date().getTime(),
    _fps: 0,
    _fpscounter: 0,
    _currentFrame: 0,
    _initialisedAt: null,
    _loopIdent: null,
    _loopFunction: null,
    _gfxLibrary: [],
    _gfxErrorCount: 0,
    _gfxLoaded: 0,
    _ready: false,
    _globalCompositeOperation: "source-over",
    KEYUP: 38,
    KEYDOWN: 40,
    KEYLEFT: 37,
    KEYRIGHT: 39,
    SPACE: 32,
    KEYA: 65,
    KEYS: 83,
    KEYW: 87,
    KEYD: 68,
    KEYENTER: 13,
    KEYESCAPE: 27,
    init: function () {
        this.stageObject = document.createElement("canvas");
        this.stage2d = this.stageObject.getContext("2d");
        this.stageObject.height = this.sh = this._stageHeight;
        this.stageObject.width = this.sw = this._stageWidth;
        this.stage2d.globalAlpha = this.defGA;
        var a = this;
        this.bind(this.stageObject, "mousemove", function (c) {
            return function (d) {
                c.mouseMover(d, c)
            }
        }(a), true);
        this.bind(this.stageObject, "click", function (c) {
            return function (d) {
                c.mouseClick(d, c)
            }
        }(a), true);
        this.bind(this.stageObject, "mousedown", function (c) {
            return function (d) {
                c.mouseDown(d, c)
            }
        }(a), true);
        this.bind(this.stageObject, "mouseup", function (c) {
            return function (d) {
                c.mouseUp(d, c)
            }
        }(a), true);
        this.bind(window, "keydown", function (c) {
            return function (d) {
                c.keyDown(d, c)
            }
        }(a), true);
        this.bind(window, "keyup", function (c) {
            return function (d) {
                c.keyUp(d, c)
            }
        }(a), true);
        this.attachStage();
        this._initialisedAt = new Date()
    },
    bind: function (d, c, e, a) {
        if (document.addEventListener) {
            d.addEventListener(c, e, a)
        } else {
            if (document.attachEvent) {
                d.attachEvent("on" + c, e, a)
            }
        }
    },
    addEventListener: function (c, a) {
        this._events[c] = a
    },
    sizeof: function (d) {
        var c = 0;
        var e = /function (.{1,})\(/;
        for (var a in d) {
            result = e.exec(d[a].constructor.toString());
            if (result != null && result[1] == "Array") {
                c += this.sizeof(d[a])
            } else {
                c++
            }
        }
        return c
    },
    MouseEvent: function (a) {
        this.e = (a) ? a : window.event;
        this.x = (a.PageX) ? a.PageX : a.clientX;
        this.y = (a.PageY) ? a.PageY : a.clientY;
        this.target = (a.target) ? a.target : a.srcElement;
        this.button = (a.button) ? a.button : a.button
    },
    MouseWheelEvent: function (a) {
        this.e = (a) ? a : window.event;
        this.delta = (a.detail) ? a.detail * -1 : a.wheelDelta / 40
    },
    KeyEvent: function (a) {
        this.keyCode = (a.keyCode) ? a.keyCode : a.which;
        this.altKey = (a.altKey) ? true : false;
        this.altLeft = (a.altLeft) ? true : false;
        this.ctrlKey = (a.ctrlKey) ? true : false;
        this.ctrlLeft = (a.ctrlLeft) ? true : false;
        this.shiftKey = (a.shiftKey) ? true : false;
        this.shiftLeft = (a.shiftLeft) ? true : false
    },
    mainController: function () {
        var d = this;
        var a = this.stage2d;
        var c = (new Date().getTime() - d._fpsInterval) / 1000;
        d._currentFrame++;
        d._fpscounter++;
        if (c > 1) {
            d._fps = Math.floor((d._fpscounter / c) * 10) / 10;
            d._fpsInterval = new Date().getTime();
            d._fpscounter = 0
        }
        if (d.clearFrame) {
            a.clearRect(0, 0, d._stageWidth, d._stageHeight)
        }
        if (typeof this._loopFunction == "function") {
            d._loopFunction.call(d)
        }
    },
    getFPS: function () {
        return this._fps
    },
    getFrameRate: function () {
        return this._frameRate
    },
    getSystemTime: function () {
        return this._initialisedAt.getTime()
    },
    getFrame: function () {
        return this._currentFrame
    },
    getPosition: function (c) {
        var a = curTop = 0;
        if (c.offsetParent) {
            do {
                a += c.offsetLeft;
                curTop += c.offsetTop
            } while (c = c.offsetParent)
        } else {
            a = c.offsetLeft;
            curTop = c.offsetTop
        }
        return [a, curTop]
    },
    mouseMover: function (f, c) {
        this.engine = c;
        f = new this.engine.MouseEvent(f);
        var h = this.engine.getPosition(this.stageObject);
        this._mouseX = f.x - h[0];
        this._mouseY = f.y - h[1];
        if (typeof this._events.onmousemove != this.undef) {
            this._events.onmousemove.apply(this, [{x: this._mouseX, y: this._mouseY}])
        }
        for (var a in this._objects) {
            xIn = yIn = false;
            var d = this._objects[a];
            if (d instanceof bHive.Clip) {
                parentX = (typeof d.parent != this.undef) ? d.parent.x : 0;
                parentY = (typeof d.parent != this.undef) ? d.parent.y : 0;
                if (this._mouseX > parentX + d.x && this._mouseX < parentX + d.x + d.width()) {
                    xIn = true
                }
                if (this._mouseY > parentY + d.y && this._mouseY < parentY + d.y + d.height()) {
                    yIn = true
                }
                if ((xIn && yIn) && !d._mouseover) {
                    if (typeof d.events.onmouseover == "function") {
                        d.events.onmouseover.apply(d, [{x: this._mouseX, y: this._mouseY}])
                    }
                    d._mouseover = true
                }
                if ((!xIn || !yIn) && d._mouseover) {
                    if (typeof d.events.onmouseout == "function") {
                        d.events.onmouseout.apply(d, [{x: this._mouseX, y: this._mouseY}])
                    }
                    d._mouseover = false
                }
            }
        }
    },
    mouseClick: function (f, c) {
        this.engine = c;
        f = new this.engine.MouseEvent(f);
        xIn = yIn = false;
        if (typeof this._events.onclick != this.undef) {
            this._events.onclick.apply(this, [{x: this._mouseX, y: this._mouseY}])
        }
        for (var a in this._objects) {
            xIn = yIn = false;
            var d = this._objects[a];
            if (d instanceof bHive.Clip) {
                parentX = (typeof d.parent != this.undef) ? d.parent.x : 0;
                parentY = (typeof d.parent != this.undef) ? d.parent.y : 0;
                if (this._mouseX > parentX + d.x && this._mouseX < parentX + d.x + d.width()) {
                    xIn = true
                }
                if (this._mouseY > parentY + d.y && this._mouseY < parentY + d.y + d.height()) {
                    yIn = true
                }
                if ((xIn && yIn) && typeof d.events.onclick == "function") {
                    d.events.onclick.apply(d, [{x: this._mouseX, y: this._mouseY}])
                }
            }
        }
    },
    mouseDown: function (f, c) {
        this.engine = c;
        f = new this.engine.MouseEvent(f);
        xIn = yIn = false;
        if (typeof this._events.mousedown != this.undef) {
            this._events.mousedown.apply(this, [{x: this._mouseX, y: this._mouseY}])
        }
        for (var a in this._objects) {
            var d = this._objects[a];
            if (d instanceof bHive.Clip) {
                if (this._mouseX > d.x && this._mouseX < d.x + d.width()) {
                    xIn = true
                }
                if (this._mouseY > d.y && this._mouseY < d.y + d.height()) {
                    yIn = true
                }
                if (xIn && yIn && typeof d.events.mousedown == "function") {
                    d.events.mousedown({x: this._mouseX, y: this._mouseY, src: d})
                }
            }
        }
    },
    mouseUp: function (f, c) {
        this.engine = c;
        f = new this.engine.MouseEvent(f);
        xIn = yIn = false;
        if (typeof this._events.mouseup != this.undef) {
            this._events.mouseup.apply(this, [{x: this._mouseX, y: this._mouseY}])
        }
        for (var a in this._objects) {
            var d = this._objects[a];
            if (d instanceof bHive.Clip) {
                if (this._mouseX > d.x && this._mouseX < d.x + d.width()) {
                    xIn = true
                }
                if (this._mouseY > d.y && this._mouseY < d.y + d.height()) {
                    yIn = true
                }
                if (xIn && yIn && typeof d.events.mouseup == "function") {
                    d.events.mouseup({x: this._mouseX, y: this._mouseY, src: d})
                }
            }
        }
    },
    keyDown: function (f, c) {
        this.engine = c;
        f = new this.engine.KeyEvent(f);
        if (typeof this._events.onkeydown != this.undef) {
            this._events.onkeydown.apply(this, [f])
        }
        for (var a in this._objects) {
            var d = this._objects[a];
            if (d instanceof bHive.Clip) {
                if (typeof d.events.onkeydown == "function") {
                    d.events.onkeydown(f)
                }
            }
        }
    },
    keyUp: function (f, c) {
        this.engine = c;
        f = new this.engine.KeyEvent(f);
        if (typeof this._events.onkeyup != this.undef) {
            this._events.onkeyup.apply(this, [f])
        }
        for (var a in this._objects) {
            var d = this._objects[a];
            if (d instanceof bHive.Clip) {
                if (typeof d.events.onkeyup == "function") {
                    d.events.onkeyup(f)
                }
            }
        }
    },
    setStageDimensions: function (a, c) {
        this._stageHeight = c;
        this._stageWidth = a
    },
    setStageColor: function (a) {
        this._stageColor = a;
        this.stageObject.style.backgroundColor = a
    },
    setGlobalComposite: function (a) {
        this._globalCompositeOperation = a;
        this.stage2d.globalCompositeOperation = a
    },
    setStageObject: function (a) {
        if (typeof a == "string") {
            var c = document.getElementById(a);
            if (c !== this.undef) {
                this.stageTarget = c
            } else {
            }
        } else {
            this.stageTarget = a
        }
    },
    attachStage: function () {
        this.stageTarget.appendChild(this.stageObject)
    },
    storeObject: function (c) {
        var a = this._objects.length;
        this._objects.push(c);
        return this._objects[a]
    },
    createClip: function (a) {
        var c = this;
        return this.storeObject(new bHive.Clip(a, c))
    },
    createVideo: function (a) {
        var c = this;
        return this.storeObject(new bHive.Video(a, c))
    },
    createAudio: function (a) {
        var c = this;
        return this.storeObject(new bHive.Audio(a, c))
    },
    createSprite: function (a) {
        var c = this;
        return this.storeObject(new bHive.Sprite(a, c))
    },
    createBitmap: function (a) {
        var c = this;
        return this.storeObject(new bHive.Bitmap(a, c))
    },
    createLine: function (a) {
        var c = this;
        return this.storeObject(new bHive.Line(a, c))
    },
    createText: function (a) {
        var c = this;
        return this.storeObject(new bHive.Text(a, c))
    },
    createShape: function (a) {
        var c = this;
        return this.storeObject(new bHive.Shape(a, c))
    },
    createGradient: function (a) {
        var c = this;
        return this.storeObject(new bHive.Gradient(a, c))
    },
    theLoop: function (c) {
        var a = this;
        this._loopFunction = c;
        this._loopIdent = setInterval(function (d) {
            return function () {
                d.mainController()
            }
        }(a), this._frameRate)
    },
    getRotatedSize: function (a) {
        radians = (2 * Math.PI * a.rotation) / 360;
        cosine = Math.cos(radians);
        sine = Math.sin(radians);
        objNH = a.image.naturalHeight;
        objNW = a.image.naturalWidth;
        point1_x = -objNH * sine;
        point1_y = objNH * cosine;
        point2_x = objNW * cosine - objNH * sine;
        point2_y = objNH * cosine + objNW * sine;
        point3_x = objNW * cosine;
        point3_y = objNW * sine;
        minx = Math.min(0, Math.min(point1_x, Math.min(point2_x, point3_x)));
        miny = Math.min(0, Math.min(point1_y, Math.min(point2_y, point3_y)));
        maxx = Math.max(point1_x, Math.max(point2_x, point3_x));
        maxy = Math.max(point1_y, Math.max(point2_y, point3_y));
        rotwidth = Math.round(maxx - minx);
        rotheight = Math.round(maxy - miny);
        return {width: rotwidth, height: rotheight}
    },
    hex2RGBa: function (d, f) {
        var e = g = b = 0;
        var c = 1;
        if (f > 100) {
            f = 100
        } else {
            if (f < 0) {
                f = 0
            }
        }
        c = f / 100;
        d = (d.charAt(0) == "#") ? d.substring(1, d.length) : d;
        if (d.length == 3) {
            e = parseInt(d.substring(0, 1) + d.substring(0, 1), 16);
            g = parseInt(d.substring(1, 2) + d.substring(1, 2), 16);
            b = parseInt(d.substring(2, 3) + d.substring(2, 3), 16)
        } else {
            e = parseInt(d.substring(0, 2), 16);
            g = parseInt(d.substring(2, 4), 16);
            b = parseInt(d.substring(4, 6), 16)
        }
        return "rgba(" + e + ", " + g + ", " + b + ", " + c + ")"
    },
    clone: function (d) {
        var c = this;

        function a() {
        }

        a.prototype = d;
        return this.storeObject(new a())
    },
    Tween: function (h, j, c, a, f, i) {
        if (!arguments.length) {
            return false
        }
        var d = this;
        var e = new bHive.Tween();
        e.engine = d;
        e.obj = h;
        e.prop = j;
        e.begin = c;
        e.position = c;
        e.end = a;
        e.duration = f;
        e.isTime = i;
        e.start();
        return e
    }
};bHive.Tween = function () {
    this._date = new Date();
    this.events = []
};bHive.Tween.prototype = {
    engine: null,
    obj: null,
    prop: null,
    begin: 0,
    position: 0,
    end: 0,
    change: 0,
    duration: 0,
    isTime: true,
    isPlaying: false,
    looping: false,
    events: null,
    time: 0,
    func: function (e, a, h, f) {
        return h * e / f + a
    },
    _startTime: 0,
    _time: 0,
    _oldTime: 0,
    _loopIdent: 0,
    _oldPos: 0,
    _date: null,
    start: function () {
        this.reset();
        this.startLoop()
    },
    stop: function () {
        this.stopLoop()
    },
    startLoop: function () {
        var c = this;
        var a;
        if (!this.isTime) {
            a = this.engine._frameRate
        } else {
            a = Math.round((this.duration * 1000) / this.engine._frameRate)
        }
        this._loopIdent = setInterval(function (d) {
            return function () {
                d.updateTime()
            }
        }(c), a);
        this.isPlaying = true
    },
    stopLoop: function () {
        this.isPlaying = false;
        clearInterval(this._loopIdent);
        if (typeof this.events.complete == "function") {
            this.events.complete()
        }
    },
    reset: function () {
        t = (isNaN(arguments[0])) ? 0 : parseInt(arguments[0]);
        this._time = t;
        this.change = this.end - this.begin;
        this.fixTime();
        this.updateFrame()
    },
    fixTime: function () {
        if (this.isTime) {
            var a = new Date().getTime();
            this._startTime = a - this._time * 1000
        }
    },
    updateTime: function () {
        this._oldTime = this._time;
        if (this.isTime) {
            var a = new Date().getTime();
            this.updateFrame((a - this._startTime) / 1000)
        } else {
            this.updateFrame(this._time + 1)
        }
    },
    updateFrame: function (a) {
        if (a > this.duration) {
            if (this.looping) {
            } else {
                if (this.isTime) {
                    this._time = this.duration;
                    this.setPosition(this.getPosition(this._time))
                }
                this.stopLoop()
            }
        } else {
            this.setPosition(this.getPosition(a));
            if (!this.isTime) {
                this._time++
            }
        }
    },
    setPosition: function (a) {
        if (typeof this.obj[this.prop] != this.engine.undef) {
            this.obj[this.prop] = this.position = a
        }
    },
    getPosition: function (a) {
        a = (typeof a == this.engine.undef) ? 0 : a;
        fr = this.func(a, this.begin, this.change, this.duration);
        return fr
    },
    tweenTo: function () {
    },
    addEventListener: function (c, a) {
        this.events[c] = a
    }
};bHive.Bitmap = function (a, e) {
    var d = this;
    this.engine = e;
    this.events = [];
    for (var c in a) {
        this[c] = a[c]
    }
    this.image = new Image();
    this.image.src = this.src;
    this.image.onload = (function (f) {
        return function () {
            f.width = f.image.naturalWidth;
            f.height = f.image.naturalHeight;
            if (typeof f.events.onload != f.engine.undef) {
                f.events.onload()
            }
        }
    })(d);
    this.image.onerror = (function (f) {
        return function () {
            console.log("cannot load: " + f.image.src);
            if (typeof f.events.onerror != f.engine.undef) {
                f.events.onerror()
            }
        }
    })(d)
};bHive.Bitmap.prototype = {
    engine: null,
    src: "",
    image: null,
    events: null,
    x: 0,
    y: 0,
    registration_x: 0,
    registration_y: 0,
    rotation: 0,
    visible: true,
    alpha: 100,
    x_scale: 100,
    y_scale: 100,
    addEventListener: function (c, a) {
        this.events[c] = a
    },
    draw: function (d, c) {
        d = (typeof d == this.engine.undef) ? 0 : d;
        c = (typeof c == this.engine.undef) ? 0 : c;
        if (this.visible) {
            if (typeof this.parent != this.engine.undef) {
                pA = this.parent.alpha;
                A = this.alpha;
                if (pA < 100) {
                    newGA = pA;
                    if (A < 100) {
                        percentage = pA * (A / 100);
                        newGA = pA - percentage
                    }
                    this.engine.stage2d.globalAlpha = Math.abs(newGA) / 100
                } else {
                    if (A < 100) {
                        this.engine.stage2d.globalAlpha = A / 100
                    }
                }
            } else {
                if (this.alpha < 100) {
                    this.engine.stage2d.globalAlpha = this.alpha / 100
                }
            }
            iW = this.image.naturalWidth;
            iH = this.image.naturalHeight;
            if (typeof this.parent != this.engine.undef) {
                if (this.x_scale != 100) {
                    iW = iW * (this.x_scale / 100)
                }
                if (this.parent.x_scale != 100) {
                    iW = iW * (this.parent.x_scale / 100)
                }
            } else {
                if (this.x_scale != 100) {
                    iW = iW * (this.x_scale / 100)
                }
            }
            if (typeof this.parent != this.engine.undef) {
                if (this.y_scale != 100) {
                    iH = iH * (this.y_scale / 100)
                }
                if (this.parent.y_scale != 100) {
                    iH = iH * (this.parent.y_scale / 100)
                }
            } else {
                if (this.y_scale != 100) {
                    iH = iH * (this.y_scale / 100)
                }
            }
            if (this.rotation != 0) {
                this.engine.stage2d.save();
                var a = d + this.x;
                var e = c + this.y;
                if (this.rotation > 360) {
                    this.rotation = 0
                }
                this.engine.stage2d.translate(a, e);
                this.engine.stage2d.rotate(this.rotation * this.engine._radians);
                this.engine.stage2d.drawImage(this.image, this.registration_x * -1, this.registration_y * -1, iW, iH);
                this.engine.stage2d.restore()
            } else {
                this.engine.stage2d.drawImage(this.image, d + this.x, c + this.y, iW, iH)
            }
            if (this.alpha < 100) {
                this.engine.stage2d.globalAlpha = this.engine.defGA
            }
        }
    }
};bHive.Clip = function (a, d) {
    this.engine = d;
    this._childObjects = [];
    this.events = [];
    for (var c in a) {
        this[c] = a[c]
    }
};bHive.Clip.prototype = {
    id: null,
    events: null,
    visible: true,
    _childObjects: null,
    _mouseover: false,
    alpha: 100,
    x: 0,
    y: 0,
    x_scale: 100,
    y_scale: 100,
    addEventListener: function (c, a) {
        this.events[c] = a
    },
    add: function (a) {
        this._childObjects.push(a);
        var c = this;
        a.parent = c
    },
    draw: function (d, c) {
        d = (typeof d == this.engine.undef) ? 0 : d;
        c = (typeof c == this.engine.undef) ? 0 : c;
        if (this.visible) {
            for (var a in this._childObjects) {
                this._childObjects[a].draw(d + this.x, c + this.y)
            }
        }
    },
    point: function (a, f, c) {
        var c = 2 * Math.PI * c / 360;
        var e = a * Math.cos(c) + f * Math.sin(c);
        var d = f * Math.cos(c) - a * Math.sin(c);
        return [e, d]
    },
    width: function () {
        var a = [];
        if (this._childObjects.length > 0) {
            for (var d in this._childObjects) {
                var c = this._childObjects[d];
                if (c instanceof bHive.Bitmap) {
                    if (c.rotation > 0) {
                        rotatedDimensions = engine.getRotatedSize(c);
                        a.push(rotatedDimensions.width + c.x)
                    } else {
                        a.push(c.image.naturalWidth + c.x)
                    }
                } else {
                    if (c instanceof bHive.Clip && c.visible) {
                        a.push(c.width() + c.x)
                    } else {
                        if (c instanceof bHive.Shape && c.visible) {
                            if (c.shape == "square") {
                                a.push(c.width + c.x)
                            } else {
                                if (c.shape == "circle") {
                                    a.push(c.x + (c.radius * 2))
                                }
                            }
                        }
                    }
                }
            }
            return Math.max.apply(0, a)
        } else {
            return 0
        }
    },
    height: function () {
        var a = [];
        if (this._childObjects.length > 0) {
            for (var d in this._childObjects) {
                var c = this._childObjects[d];
                if (c instanceof bHive.Bitmap) {
                    if (c.rotation > 0) {
                        rotatedDimensions = engine.getRotatedSize(c);
                        a.push(rotatedDimensions.height + c.y)
                    } else {
                        a.push(c.image.naturalHeight + c.y)
                    }
                } else {
                    if (c instanceof bHive.Clip) {
                        a.push(c.height() + c.y)
                    } else {
                        if (c instanceof bHive.Shape) {
                            if (c.shape == "square") {
                                a.push(c.height + c.y)
                            } else {
                                if (c.shape == "circle") {
                                    a.push(c.y + (c.radius * 2))
                                }
                            }
                        }
                    }
                }
            }
            return Math.max.apply(0, a)
        } else {
            return 0
        }
    }
};bHive.Video = function (a, d) {
    this.engine = d;
    this.source = [];
    this.events = [];
    for (var c in a) {
        this[c] = a[c]
    }
    this.createDOMObject()
};bHive.Video.prototype = {
    path: "",
    src: "",
    alpha: 100,
    x: 0,
    y: 0,
    x_scale: 100,
    y_scale: 100,
    rotation: 0,
    width: 0,
    height: 0,
    registration_x: 0,
    registration_y: 0,
    events: null,
    formats: ["mp4", "ogg", "webm"],
    duration: 0,
    currentTime: 0,
    ended: false,
    muted: false,
    paused: false,
    format: "",
    looping: true,
    createDOMObject: function () {
        this.domvid = document.createElement("video");
        this.domvid.controls = "true";
        this.domvid.autoplay = "true";
        this.domvid.loop = "true";
        this.domvid.style.display = "none";
        var a = this.domvid;
        this.format = this.supportedFormat();
        console.log(this.format);
        if (this.format != "") {
            this.domvid.setAttribute("src", this.path + "/" + this.src + "." + this.format);
            if (this.looping) {
                this.domvid.setAttribute("loop", "loop");
                this.engine.bind(this.domvid, "ended", function (c) {
                    return function (d) {
                        c.play()
                    }
                }(a), true)
            }
            document.getElementsByTagName("body")[0].appendChild(this.domvid)
        } else {
            return false
        }
    },
    supportedFormat: function () {
        var d = "";
        for (var c = 0, a = this.formats.length; c < a; c++) {
            if (this.domvid.canPlayType("video/" + this.formats[c]) == "probably" || this.domvid.canPlayType("video/" + this.formats[c]) == "maybe") {
                d = this.formats[c];
                break
            }
        }
        return d
    },
    pause: function () {
        if (!this.domvid.paused) {
            this.paused = true;
            this.domvid.pause()
        }
    },
    play: function () {
        if (this.domvid.paused) {
            this.paused = false;
            this.domvid.play()
        }
    },
    draw: function (d, c) {
        d = (typeof d == this.engine.undef) ? 0 : d;
        c = (typeof c == this.engine.undef) ? 0 : c;
        if (typeof this.parent != this.engine.undef) {
            pA = this.parent.alpha;
            A = this.alpha;
            if (pA < 100) {
                newGA = pA;
                if (A < 100) {
                    percentage = pA * (A / 100);
                    newGA = pA - percentage
                }
                this.engine.stage2d.globalAlpha = Math.abs(newGA) / 100
            } else {
                if (A < 100) {
                    this.engine.stage2d.globalAlpha = A / 100
                }
            }
        } else {
            if (this.alpha < 100) {
                this.engine.stage2d.globalAlpha = this.alpha / 100
            }
        }
        iW = this.width;
        iH = this.height;
        if (typeof this.parent != this.engine.undef) {
            if (this.x_scale != 100) {
                iW = iW * (this.x_scale / 100)
            }
            if (this.parent.x_scale != 100) {
                iW = iW * (this.parent.x_scale / 100)
            }
        } else {
            if (this.x_scale != 100) {
                iW = iW * (this.x_scale / 100)
            }
        }
        if (typeof this.parent != this.engine.undef) {
            if (this.y_scale != 100) {
                iH = iH * (this.y_scale / 100)
            }
            if (this.parent.y_scale != 100) {
                iH = iH * (this.parent.y_scale / 100)
            }
        } else {
            if (this.y_scale != 100) {
                iH = iH * (this.y_scale / 100)
            }
        }
        if (this.rotation != 0) {
            this.engine.stage2d.save();
            var a = d + this.x;
            var e = c + this.y;
            if (this.rotation > 360) {
                this.rotation = 0
            }
            this.engine.stage2d.translate(a, e);
            this.engine.stage2d.rotate(this.rotation * this.engine._radians);
            this.engine.stage2d.drawImage(this.domvid, this.registration_x * -1, this.registration_y * -1, iW, iH);
            this.engine.stage2d.restore()
        } else {
            this.engine.stage2d.drawImage(this.domvid, d + this.x, c + this.y, iW, iH)
        }
        if (this.alpha < 100) {
            this.engine.stage2d.globalAlpha = this.engine.defGA
        }
    }
};bHive.Line = function (a, d) {
    this.engine = d;
    for (var c in a) {
        this[c] = a[c]
    }
};bHive.Line.prototype = {
    weight: 1,
    cap: "butt",
    corner: "miter",
    start: null,
    end: null,
    visible: true,
    controlpoints: null,
    color: "rgba(0,0,0,1)",
    draw: function () {
        if (this.start instanceof Array) {
            x1 = this.start[0];
            y1 = this.start[1]
        } else {
            if (typeof this.start == "string") {
                switch (this.start) {
                    case"mouse":
                        x1 = this.engine._mouseX;
                        y1 = this.engine._mouseY;
                        break
                }
            } else {
                if (this.start instanceof Object) {
                    x1 = this.start.x;
                    y1 = this.start.y
                }
            }
        }
        if (this.end instanceof Array) {
            x2 = this.end[0];
            y2 = this.end[1]
        } else {
            if (typeof this.end == "string") {
                switch (this.end) {
                    case"mouse":
                        x2 = this.engine._mouseX;
                        y2 = this.engine._mouseY;
                        break
                }
            } else {
                if (this.start instanceof Object) {
                    x2 = this.end.x;
                    y2 = this.end.y
                }
            }
        }
        if (this.color instanceof bHive.Gradient) {
            if (typeof this.color.dimensions == this.engine.undef) {
                if (this.color.type == "linear") {
                    color = this.engine.stage2d.createLinearGradient(this.x, this.y, this.x + this.width, this.y + this.height)
                } else {
                    color = this.engine.stage2d.createRadialGradient(this.x + (this.width / 2), this.y + (this.height / 2), 0, this.x + (this.width / 2), this.y + (this.height / 2), this.width / 2)
                }
            } else {
                if (this.color.type == "linear") {
                    color = this.engine.stage2d.createLinearGradient(this.color.dimensions[0], this.color.dimensions[1], this.color.dimensions[2], this.color.dimensions[3])
                } else {
                    color = this.engine.stage2d.createRadialGradient(this.color.dimensions[0], this.color.dimensions[1], this.color.dimensions[2], this.color.dimensions[3], this.color.dimensions[4], this.color.dimensions[5])
                }
            }
            for (var c = 0, a = this.color.colors.length; c < a; c++) {
                color.addColorStop(this.color.stops[c], this.color.colors[c])
            }
        } else {
            color = this.color
        }
        this.engine.stage2d.save();
        this.engine.stage2d.beginPath();
        this.engine.stage2d.lineWidth = this.weight;
        this.engine.stage2d.lineCap = this.cap;
        this.engine.stage2d.lineJoin = this.corner;
        this.engine.stage2d.strokeStyle = color;
        if (this.controlpoints == null) {
            this.engine.stage2d.moveTo(x1, y1);
            this.engine.stage2d.lineTo(x2, y2)
        } else {
            if (this.controlpoints.length == 1) {
                this.engine.stage2d.moveTo(x1, y1);
                this.engine.stage2d.quadraticCurveTo(this.controlpoints[0].x, this.controlpoints[0].y, x2, y2)
            } else {
                if (this.controlpoints.length == 2) {
                    this.engine.stage2d.moveTo(x1, y1);
                    this.engine.stage2d.quadraticCurveTo(this.controlpoints[0].x, this.controlpoints[0].y, this.controlpoints[1].x, this.controlpoints[1].y, x2, y2)
                }
            }
        }
        this.engine.stage2d.stroke();
        this.engine.stage2d.restore()
    }
};bHive.Text = function (a, d) {
    this.engine = d;
    for (var c in a) {
        this[c] = a[c]
    }
};bHive.Text.prototype = {
    text: null, x: 0, y: 0, align: "top", color: "rgb(0, 0, 0, 0)", visible: true, draw: function (c, a) {
        c = (typeof c == this.engine.undef) ? 0 : c;
        a = (typeof a == this.engine.undef) ? 0 : a;
        this.engine.stage2d.textBaseline = this.align;
        this.engine.stage2d.fillStyle = this.color;
        this.engine.stage2d.fillText(this.text, c + this.x, a + this.y)
    },
};bHive.Shape = function (a, d) {
    this.engine = d;
    for (var c in a) {
        this[c] = a[c]
    }
};bHive.Shape.prototype = {
    shape: "square",
    style: "filled",
    x: 0,
    y: 0,
    width: 0,
    height: 0,
    radius: 0,
    backgroundColor: "rgba(0, 0, 0, 1)",
    strokeColor: "rgba(0, 0, 0, 1)",
    strokeWeight: 1,
    alpha: 100,
    visible: true,
    close: true,
    draw: function (k, j) {
        k = (typeof k == this.engine.undef) ? 0 : k;
        j = (typeof j == this.engine.undef) ? 0 : j;
        var l = this.engine.stage2d;
        var e = Math.PI * 2;
        if (this.backgroundColor instanceof bHive.Gradient) {
            if (typeof this.backgroundColor.dimensions == this.engine.undef) {
                if (this.backgroundColor.type == "linear") {
                    bgColor = this.engine.stage2d.createLinearGradient(this.x, this.y, this.x + this.width, this.y + this.height)
                } else {
                    bgColor = this.engine.stage2d.createRadialGradient(this.x + (this.width / 2), this.y + (this.height / 2), 0, this.x + (this.width / 2), this.y + (this.height / 2), this.width / 2)
                }
            } else {
                if (this.backgroundColor.type == "linear") {
                    bgColor = this.engine.stage2d.createLinearGradient(this.backgroundColor.dimensions[0], this.backgroundColor.dimensions[1], this.backgroundColor.dimensions[2], this.backgroundColor.dimensions[3])
                } else {
                    bgColor = this.engine.stage2d.createRadialGradient(this.backgroundColor.dimensions[0], this.backgroundColor.dimensions[1], this.backgroundColor.dimensions[2], this.backgroundColor.dimensions[3], this.backgroundColor.dimensions[4], this.backgroundColor.dimensions[5])
                }
            }
            for (var c = 0, a = this.backgroundColor.colors.length; c < a; c++) {
                bgColor.addColorStop(this.backgroundColor.stops[c], this.backgroundColor.colors[c])
            }
        } else {
            if (this.backgroundColor.indexOf("#") != -1) {
                bgColor = this.engine.hex2RGBa(this.backgroundColor, this.alpha)
            } else {
                bgColor = this.backgroundColor
            }
        }
        l.save();
        switch (this.shape) {
            case"square":
                if (this.style == "filled") {
                    l.fillStyle = bgColor;
                    l.fillRect(k + this.x, j + this.y, this.width, this.height)
                } else {
                    l.lineWidth = 1;
                    l.strokeStyle = bgColor;
                    l.strokeRect(k + this.x, j + this.y, this.width, this.height)
                }
                break;
            case"circle":
                if (this.style == "filled") {
                    l.beginPath();
                    l.fillStyle = bgColor;
                    l.arc(k + this.x, j + this.y, this.radius, 0, e, true);
                    l.fill()
                } else {
                    l.beginPath();
                    l.strokeStyle = bgColor;
                    l.arc(k + this.x, j + this.y, this.radius, 0, e, true);
                    l.stroke()
                }
                break;
            case"poly":
                l.beginPath();
                var m = this.points;
                var d = m.length;
                var h = 0;
                var f = 0;
                if (d > 1) {
                    l.moveTo(k + this.x + m[0].x, j + this.y + m[0].y);
                    for (c = 1; c < d; c++) {
                        h = Math.max(h, m[c].x);
                        f = Math.max(f, m[c].y);
                        l.lineTo(k + this.x + m[c].x, j + this.y + m[c].y)
                    }
                    this.width = h;
                    this.height = f
                }
                if (this.style == "filled") {
                    l.fillStyle = bgColor;
                    l.fill()
                } else {
                    if (this.close) {
                        l.closePath()
                    }
                    l.strokeStyle = bgColor;
                    l.stroke()
                }
                break;
            case"elipse":
                l.beginPath();
                l.moveTo((k + this.x) + (this.width / 2), j + this.y);
                l.bezierCurveTo(((k + this.x) + (this.width / 2)) + this.width / 2, ((j + this.y) + (this.height / 2)) - this.height / 2, ((k + this.x) + (this.width / 2)) + this.width / 2, ((j + this.y) + (this.height / 2)) + this.height / 2, ((k + this.x) + (this.width / 2)), ((j + this.y) + (this.height / 2)) + this.height / 2);
                l.bezierCurveTo(((k + this.x) + (this.width / 2)) - this.width / 2, ((j + this.y) + (this.height / 2)) + this.height / 2, ((k + this.x) + (this.width / 2)) - this.width / 2, ((j + this.y) + (this.height / 2)) - this.height / 2, ((k + this.x) + (this.width / 2)), ((j + this.y) + (this.height / 2)) - this.height / 2);
                if (this.style == "filled") {
                    l.fillStyle = bgColor;
                    l.fill()
                } else {
                    l.strokeStyle = bgColor;
                    l.stroke()
                }
                break
        }
        l.restore()
    }
};bHive.Sprite = function (a, e) {
    var d = this;
    this.engine = e;
    this.events = [];
    for (var c in a) {
        this[c] = a[c]
    }
    this.image = new Image();
    this.image.src = this.src;
    this.image.onload = (function (f) {
        return function () {
            if (typeof f.events.onload != f.engine.undef) {
                f.events.onload()
            }
            d.framecount = d.framedata.length
        }
    })(d)
};bHive.Sprite.prototype = {
    src: "",
    width: 0,
    height: 0,
    buffer: null,
    framedata: null,
    events: null,
    image: null,
    alpha: 100,
    rotation: 0,
    visible: true,
    frame: 0,
    framecount: 0,
    framespeed: 0,
    frametimer: 0,
    registration_x: 0,
    registration_y: 0,
    x_scale: 100,
    y_scale: 100,
    createBuffer: function () {
        this.buffer = document.createElement("canvas");
        this.buffer.width = this.width;
        this.buffer.height = this.height;
        document.getElementsByTagName("body")[0].appendChild(this.buffer)
    },
    addEventListener: function (c, a) {
        this.events[c] = a
    },
    draw: function (l, k) {
        l = (typeof l == this.engine.undef) ? 0 : l;
        k = (typeof k == this.engine.undef) ? 0 : k;
        if (typeof this.parent != this.engine.undef) {
            pA = this.parent.alpha;
            A = this.alpha;
            if (pA < 100) {
                newGA = pA;
                if (A < 100) {
                    percentage = pA * (A / 100);
                    newGA = pA - percentage
                }
                this.engine.stage2d.globalAlpha = Math.abs(newGA) / 100
            } else {
                if (A < 100) {
                    this.engine.stage2d.globalAlpha = A / 100
                }
            }
        } else {
            if (this.alpha < 100) {
                this.engine.stage2d.globalAlpha = this.alpha / 100
            }
        }
        iW = this.framedata[this.frame].frame.w;
        iH = this.framedata[this.frame].frame.h;
        if (typeof this.parent != this.engine.undef) {
            if (this.x_scale != 100) {
                iW = iW * (this.x_scale / 100)
            }
            if (this.parent.x_scale != 100) {
                iW = iW * (this.parent.x_scale / 100)
            }
        } else {
            if (this.x_scale != 100) {
                iW = iW * (this.x_scale / 100)
            }
        }
        if (typeof this.parent != this.engine.undef) {
            if (this.y_scale != 100) {
                iH = iH * (this.y_scale / 100)
            }
            if (this.parent.y_scale != 100) {
                iH = iH * (this.parent.y_scale / 100)
            }
        } else {
            if (this.y_scale != 100) {
                iH = iH * (this.y_scale / 100)
            }
        }
        var i = this.framedata[this.frame].frame.x;
        var f = this.framedata[this.frame].frame.y;
        var a = this.framedata[this.frame].frame.w;
        var d = this.framedata[this.frame].frame.h;
        var n = this.x;
        var m = this.y;
        var e = iW;
        var c = iH;
        if (this.rotation != 0) {
            this.engine.stage2d.save();
            var j = l + this.x;
            var h = k + this.y;
            if (this.rotation > 360) {
                this.rotation = 0
            }
            this.engine.stage2d.translate(j, h);
            this.engine.stage2d.rotate(this.rotation * this.engine._radians);
            this.engine.stage2d.drawImage(this.image, i, f, a, d, this.registration_x * -1, this.registration_y * -1, e, c);
            this.engine.stage2d.restore()
        } else {
            this.engine.stage2d.drawImage(this.image, i, f, a, d, n, m, e, c)
        }
        if (this.frametimer == 0) {
            this.frame++;
            if (this.frame > this.framecount - 1) {
                this.frame = 0
            }
            this.frametimer = this.framespeed
        } else {
            if (this.frametimer > 0) {
                this.frametimer--
            }
        }
        if (this.alpha < 100) {
            this.engine.stage2d.globalAlpha = this.engine.defGA
        }
    }
};bHive.Gradient = function (a, d) {
    this.engine = d;
    this.colors = [];
    this.stops = [];
    for (var c in a) {
        this[c] = a[c]
    }
};bHive.Gradient.prototype = {};bHive.Audio = function (a, d) {
    this.engine = d;
    for (var c in a) {
        this[c] = a[c]
    }
};bHive.Audio.prototype = {};
