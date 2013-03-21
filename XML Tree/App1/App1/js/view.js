(function () {
    "use strict";

    var canvas = null;
    var context = null;

    var boxWidth = 30;
    var boxWidth1c = 7;
    var boxHeight = 20;
    var boxPadding = 4;
    var boxGapX = 8;
    var boxGapY = 6;

    function initView() {
        canvas = document.getElementById("drawingCanvas");
        canvas.width = canvas.clientWidth;
        canvas.height = canvas.clientHeight;
        context = canvas.getContext("2d");
        context.strokeStyle = "#000000";
        context.fillStyle = "#000000";
        context.translate(0.5, 0.5);
        context.font = "10px sans-serif";
    }

    function clearCanvas() {
        context.clearRect(0, 0, canvas.clientWidth, canvas.clientHeight);
    }

    function drawTree(tree) {
        _drawTree(tree, 10, 10);
    }

    function drawTreeAt(tree, x, y) {
        _drawTree(tree, x, y);
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
            _drawBox(leftBound, rooty, tree.displayValue);
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

    function getCenter(tree) {
        return _getCenter(tree, 0, 0).rootx;
    }

    function _getCenter(tree, rooty, leftBound) {
        // rooty is level to start at, leftbound is leftmost place where we can safely draw
        // returns rightmost place used and rootx for where to draw line to

        var running_leftbound = leftBound;
        var rootxNextLevel = [];
        var rightNextLevel = [];

        for (var i = 0; i < tree.children.length; i++) {
            var returnedData = _getCenter(tree.children[i], rooty + boxHeight + boxGapY, running_leftbound);
            running_leftbound = returnedData.right + boxGapX;
            rootxNextLevel.push(returnedData.rootx);
            rightNextLevel.push(returnedData.right);
        }

        var rootx;
        var right;

        if (rootxNextLevel.length === 0) {
            rootx = leftBound + boxWidth / 2;
            right = leftBound + boxWidth + boxGapX;
        } else {
            rootx = average(rootxNextLevel);
            right = max(rightNextLevel) + boxGapX;
        }

        var toReturn = {
            right: right,
            rootx: rootx,
        };

        return toReturn;
    }

    // TODO: must return {tree,parent,parentIndex} type
    function getSubtree(x, y) {
        var parent = {children: [Model.getTree(0)]};
        return _getSubtree(x, y, parent.children[0], 10, 10);
    }

    // TODO: must return {tree,parent,parentIndex} type
    function _getSubtree(x, y, tree, rooty, leftBound, parent, ind) {
        //This logic must mirror logic in _drawtree

        var running_leftbound = leftBound;
        var rootxNextLevel = [];
        var rightNextLevel = [];
        for (var i = 0; i < tree.children.length; i++) {
            var returnedData = _getSubtree(x, y, tree.children[i], rooty + boxHeight + boxGapY, running_leftbound, tree, i);
            if(returnedData.tree instanceof Model.tree) return returnedData;
            running_leftbound = returnedData.right + boxGapX;
            rootxNextLevel.push(returnedData.rootx);
            rightNextLevel.push(returnedData.right);
        }

        var rootx;
        var right;

        if (rootxNextLevel.length === 0) {
            if (_testBox(x, y, leftBound, rooty)) {
                parent.children.splice(ind, 1);
                return {tree: tree, parent: parent, parentIndex: ind};
            }
            rootx = leftBound + boxWidth / 2;
            right = leftBound + boxWidth + boxGapX;
        } else {
            rootx = average(rootxNextLevel);
            right = max(rightNextLevel) + boxGapX;
            if (_testBox(x, y, rootx - boxWidth / 2, rooty)) {
                parent.children.splice(ind, 1);
                return { tree: tree, parent: parent, parentIndex: ind };
            }
        }

        var toReturn = {
            right: right,
            rootx: rootx,
        };

        return toReturn;
    }

    function getDropLocation(mainTree, x, y) {
        return _getDropLocation(x, y, mainTree, 10, 10);
    }

    function _getDropLocation(x, y, tree, rooty, leftBound) {
        var running_leftbound = leftBound;
        var rootxNextLevel = [];
        var rightNextLevel = [];

        for (var i = 0; i < tree.children.length; i++) {
            var returnedData = _getDropLocation(x, y, tree.children[i], rooty + boxHeight + boxGapY, running_leftbound);
            running_leftbound = returnedData.right + boxGapX;
            rootxNextLevel.push(returnedData.rootx);
            rightNextLevel.push(returnedData.right);

            if (returnedData.parent !== null) {
                return returnedData;
            }
        }

        var rootx;
        var right;

        var parent = null;
        var index = null;

        // if in the next row down, drop relative to here
        if (y > rooty + boxHeight + boxGapY && y <= rooty + boxHeight * 2 + boxGapY * 2) {
            // y of the next row
            for (var i = 1; i < rootxNextLevel.length; i++) {
                if (x > rootxNextLevel[i - 1] && x <= rootxNextLevel[i]) {
                    parent = tree;
                    index = i;
                }
            }
            if (parent === null && x > rootxNextLevel[0] - 2 * boxWidth && x <= rootxNextLevel[0]) {
                parent = tree;
                index = 0;
            }
            if (parent === null && x < rootxNextLevel[rootxNextLevel.length - 1] + 2 * boxWidth && x > rootxNextLevel[rootxNextLevel.length - 1]) {
                parent = tree;
                index = rootxNextLevel.length;
            }
        }

        if (rootxNextLevel.length === 0) {
            rootx = leftBound + boxWidth / 2;
            right = leftBound + boxWidth + boxGapX;
        } else {
            rootx = average(rootxNextLevel);
            right = max(rightNextLevel) + boxGapX;
        }

        if (parent === null && rootxNextLevel.length === 0 && x > rootx - boxWidth/2 && x < rootx + boxWidth / 2 && y > rooty + boxHeight * 2 + boxGapY * 2 && y <= rooty + boxHeight * 3 + boxGapY * 3) {
            parent = tree;
            index = 0;
        }

        var toReturn = {
            right: right,
            rootx: rootx,
            parent: parent,
            index: index,
        };

        return toReturn;
    }

    function _testBox(x, y, left, top) {
        if (x >= left && x <= left + boxWidth && y >= top && y <= top + boxHeight) {
            return true;
        }
        return false;
    }

    function _drawBox(left, top, contents) {
        context.strokeRect(left, top, boxWidth, boxHeight);
        context.fillText(contents, left + boxPadding, top + boxHeight - boxPadding, boxWidth - 2 * boxPadding);
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
        drawTreeAt: drawTreeAt,
        getSubtree: getSubtree,
        getCenter: getCenter,
        getDropLocation: getDropLocation,
    });
})();