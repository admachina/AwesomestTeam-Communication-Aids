(function () {
    "use strict";

    var roots = [];

    function generateXmlString() {
        var string = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"

        for (var i = 0; i < roots.length; i++) {
            string += generateTree(roots[i]);
        }

        return string;
    }

    function generateTreeFromXmlString(xml) {
        var xmlParsed = new DOMParser().parseFromString(xml, "text/xml");
        for (var i = 0; i < xmlParsed.childNodes.length; i++) {
            if (xmlParsed.childNodes[i].nodeName === "Tree") {
                var thisTree = _generateTreeFromDomObject(xmlParsed.childNodes[i]);
                setTree(0, thisTree);
                return thisTree;
            }
        }
    }

    function _generateTreeFromDomObject(obj) {
        var tree = new Model.tree();
        for (var i = 0; i < obj.childNodes.length; i++) {
            switch (obj.childNodes[i].nodeName) {
                case "DisplayValue":
                    tree.displayValue = obj.childNodes[i].textContent;
                    break;
                case "PrintValue":
                    tree.printValue = obj.childNodes[i].textContent;
                    break;
                case "IsRoot":
                    tree.isRoot = obj.childNodes[i].textContent;
                    break;
                case "IsGoUp":
                    tree.isGoUp = obj.childNodes[i].textContent;
                    break;
                case "Children":
                    for (var j = 0; j < obj.childNodes[i].childNodes.length; j++) {
                        if (obj.childNodes[i].childNodes[j].nodeName === "Tree") {
                            tree.addChild(_generateTreeFromDomObject(obj.childNodes[i].childNodes[j]));
                        }
                    }
                    break;
            }
        }
        return tree;
    }

    function setTree(index, tree) {
        roots[index] = tree;
    }

    function getTree(index) {
        return roots[index];
    }

    function generateTree(root) {
        var individualChildren = [];
        for(var i = 0; i < root.children.length; i++){
            individualChildren[i] = generateTree(root.children[i]);
        }

        var displayValue = generateNode("DisplayValue", root.displayValue);
        var printValue = generateNode("PrintValue", root.printValue);
        var isRoot = generateNode("IsRoot", root.isRoot);
        var isGoUp = generateNode("IsGoUp", root.isGoUp);
        var children = generateNode("Children", simpleFlatten(individualChildren));
        var returnString = generateNode("Tree", displayValue + printValue + isRoot + isGoUp + children);

        return returnString;
    }

    function generateNode(tagName, contentString) {
        return "<" + tagName + ">" + contentString + "</" + tagName + ">";
    }

    function simpleFlatten(array){
        var returnString = "";
        for(var i = 0; i < array.length; i++){
            returnString += array[i];
        }
        return returnString;
    }

    var tree = WinJS.Class.define(function tree_ctor() {
        this._displayValue = "";
        this._printValue = "";
        this._isRoot = "FALSE";
        this._isGoUp = "FALSE";
        this._children = [];
    }, {
        displayValue: {
            get: function () {
                return this._displayValue;
            },

            set: function (value) {
                this._displayValue = value;
            }
        },

        printValue: {
            get: function () {
                return this._printValue;
            },

            set: function (value) {
                this._printValue = value;
            }
        },

        isRoot: {
            get: function () {
                return this._isRoot;
            },

            set: function isRootSet(value) {
                if(value === true){
                    this.isRootSet = "TRUE";
                }

                if(value === false){
                    this.isRootSet = "FALSE";
                }

                this._isRoot = value;
            }
        },

        isGoUp: {
            get: function () {
                return this._isGoUp;
            },

            set: function isGoUpSet(value) {
                if(value === true){
                    this.isGoUp = "TRUE";
                }

                if(value === false){
                    this.isGoUp = "FALSE";
                }

                this._isGoUp = value;
            }
        },

        children: {
            get: function () {
                return this._children;
            },

            set: function (value) {
                this._children = value;
            }
        },

        addChild: function (newChild) {
            this._children.push(newChild);
        },

        insertChild: function (newChild, index) {
            this._children.splice(index, 0, newChild);
        },
    });

    WinJS.Namespace.define("Model", {
        generateXmlString: generateXmlString,
        generateTreeFromXmlString: generateTreeFromXmlString,
        tree: tree,
        setTree: setTree,
        getTree: getTree,
    });
})();