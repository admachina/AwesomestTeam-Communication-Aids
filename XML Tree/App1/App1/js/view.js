(function () {
    "use strict";

    var canvas = null;
    var context = null;

    var boxWidth = 20;
    var boxHeight = 10;
    var boxPadding = 2;
    var boxGapX = 5;
    var boxGapY = 5;

    function initView() {
        canvas = document.getElementById("drawingCanvas");
        context = canvas.getContext("2d");
    }

    function clearCanvas() {
        context.clearRect(0, 0, canvas.clientWidth, canvas.clientHeight);
    }

    function drawTree(tree) {
        _drawTree(tree, 10, 10);
    }

    function _drawTree(tree, rooty, leftBound) {
        // rooty is level to start at, leftbound is leftmost place where we can safely draw
        // returns rightmost place used and rootx for where to draw line to
        
        var running_leftbound = leftBound;
        var rootxNextLevel = [];
        var rightNextLevel = [];

        for (var i = 0; i < tree.children.length; i++) {
            var returnedData = _drawTree(tree.children[i], rooty + boxHeight + boxGapY, running_leftbound);
            running_leftbound = returnedData.right + boxGapX;
            rootxNextLevel.push(returnedData.rootx);
            rightNextLevel.push(returnedData.right);
        }

        var rootx;
        var right;

        if (rootxNextLevel.length === 0) {
            _drawBox(leftBound, rooty, tree.printValue);
            rootx = leftBound + boxWidth / 2;
            right = leftBound + boxWidth + boxGapX;
        } else {
            rootx = average(rootxNextLevel);
            right = max(rightNextLevel) + boxGapX;
            _drawBox(rootx - boxWidth / 2, rooty, tree.displayValue);
            _drawConnectors(rootx, rooty + boxHeight, rooty + boxHeight + boxGapY, rootxNextLevel);
        }

        var toReturn = {
            right: right,
            rootx: rootx,
        };

        return toReturn;
    }

    function _drawBox(left, top, contents) {
        context.strokeRect(left, top, boxWidth, boxHeight);
        context.strokeText(contents, left + boxPadding, top + boxHeight - boxPadding, boxWidth - 2 * boxPadding);
    }

    function _drawConnectors(originX, originY, destinationY, destinationXList){
        var midpointY = (originY + destinationY) / 2;
        context.beginPath();
        context.moveTo(originX, originY);
        context.lineTo(originX, midpointY);
        for (var i = 0; i < destinationXList.length; i++) {
            context.lineTo(destinationXList[i], midpointY);
            context.lineTo(destinationXList[i], destinationY);
            context.lineTo(destinationXList[i], midpointY);
        }
        context.stroke();
    }

    function average(array){
        var count = 0;
        for(var i = 0; i < array.length; i++){
            count += array[i];
        }
        return count / array.length;
    }

    function max(array) {
        var currentMax = array[0];
        for (var i = 1; i < array.length; i++) {
            if (array[i] > currentMax) {
                currentMax = array[i];
            }
        }
        return currentMax;
    }

    WinJS.Namespace.define("View", {
        initView: initView,
        clearCanvas: clearCanvas,
        drawTree: drawTree,
    });
})();