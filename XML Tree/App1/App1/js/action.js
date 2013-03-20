var treeToChange;
var tempx;
var tempy;
var tempParent;
var tempIndex;

(function () {
    var selectedTree = null;
    var originalX;
    var originalY;
    var currentX;//may not be needed
    var currentY;//may not be needed
    var parent;
    var index;

    function setSelected(treeSelected, x, y, newParent, ind) {
        selectedTree = treeSelected;
        originalX = x;
        originalY = y;
        currentX = x;
        currentY = y;
        parent = newParent;
        index = ind;
    }

    function moveTo(x, y) {
        if (selectedTree === null) {
            return;
        }

        currentX = x;
        currentY = y;

        View.clearCanvas();
        View.drawTree(Model.getTree(0));
        // draw subtree at x,y
        var center = View.getCenter(selectedTree);
        View.drawTreeAt(selectedTree, y, x - center);
    }

    function reset() {
        if (selectedTree === null) {
            return;
        }

        parent.children.splice(index, 0, selectedTree);
        selectedTree = null;

        View.clearCanvas();
        View.drawTree(Model.getTree(0));
    }

    function drop(x, y) {
        if (selectedTree === null) {
            return;
        }

        var dropLocation = View.getDropLocation(Model.getTree(0), x, y);

        if (dropLocation.parent !== null) {
            dropLocation.parent.printValue = "";
            if (parent.children.length == 0 && !parent.isGoUp) parent.printValue = parent.displayValue;

            dropLocation.parent.children.splice(dropLocation.index, 0, selectedTree);
            selectedTree = null;

            View.clearCanvas();
            View.drawTree(Model.getTree(0));
        }

        reset();
        //determine where it should be dropped OR call reset
    }

    function changeNode(tree) {
        treeToChange = tree;
        tempx = originalX;
        tempy = originalY;
        tempParent = parent;
        tempIndex = index;
        sm('options', 500, 75);
    }

    function clear() {
        treeToChange = null;
        tempx = null;
        tempy = null;
        tempParent = null;
        tempIndex = null;
        selectedTree = null;
        parent = null;
        currentX = null;
        currentY = null;
        index = null;
    }

    WinJS.Namespace.define("Actions",
        {
            setSelected: setSelected,
            moveTo: moveTo,
            reset: reset,
            drop: drop,
            changeNode: changeNode,
            clear: clear,
        }
    );
})();

function addChild() {
    var text = window.prompt("Text to add to child", "A");
    var newTree = new Model.tree();

    newTree.displayValue = text;
    newTree.printValue = text;
    newTree.children = [];
    newTree.isGoUp = false;
    newTree.isRoot = false;

    treeToChange.addChild(newTree);
    treeToChange.printValue = "";

    Actions.setSelected(treeToChange, tempx, tempy, tempParent, tempIndex);
    Actions.reset();
};

function rename() {
    var text = window.prompt("Rename node to...", "A");

    treeToChange.displayValue = text;
    if (treeToChange.children.length == 0) treeToChange.printValue = text;

    Actions.setSelected(treeToChange, tempx, tempy, tempParent, tempIndex);
    Actions.reset();
};

function setRoot() {
    treeToChange.isRoot = true;

    Actions.setSelected(treeToChange, tempx, tempy, tempParent, tempIndex);
    Actions.reset();
};

function setIsGoBack() {
    treeToChange.isGoUp = true;

    treeToChange.printValue = "";

    Actions.setSelected(treeToChange, tempx, tempy, tempParent, tempIndex);
    Actions.reset();
};

function clearSettings() {
    treeToChange.isGoUp = false;
    treeToChange.isRoot = false;

    if (treeToChange.children.length == 0) treeToChange.printValue = treeToChange.displayValue;

    Actions.setSelected(treeToChange, tempx, tempy, tempParent, tempIndex);
    Actions.reset();
};

function cancel() {
    Actions.setSelected(treeToChange, tempx, tempy, tempParent, tempIndex);
    Actions.reset();
};