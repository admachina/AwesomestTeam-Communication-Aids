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
            dropLocation.parent.children.splice(dropLocation.index, 0, selectedTree);
            selectedTree = null;

            View.clearCanvas();
            View.drawTree(Model.getTree(0));
        }

        reset();
        //determine where it should be dropped OR call reset
    }

    WinJS.Namespace.define("Actions",
        {
            setSelected: setSelected,
            moveTo: moveTo,
            reset: reset,
            drop: drop,
        }
    );
})();