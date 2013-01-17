(function () {
    "use strict"

    function openFile() {
        var openPicker = new Windows.Storage.Pickers.FileOpenPicker();
        openPicker.viewMode = Windows.Storage.Pickers.PickerViewMode.list;
        openPicker.suggestedStartLocation = Windows.Storage.Pickers.PickerLocationId.documentsLibrary;
        openPicker.fileTypeFilter.replaceAll([".xml"]);

        return openPicker.pickSingleFileAsync().then(function (file) {
            if (file) {
                // Success
                return Windows.Storage.FileIO.readTextAsync(file);
            } else {
                // Failed
                return null;
            }
        });
    }

    function saveFile(fileContent, suggestedName) {
        var savePicker = new Windows.Storage.Pickers.FileSavePicker();
        savePicker.fileTypeChoices.insert("XML Document", [".xml"]);
        savePicker.suggestedFileName = suggestedName;

        savePicker.pickSaveFileAsync().then(function (file) {
            if (file) {
                // Success
                Windows.Storage.CachedFileManager.deferUpdates(file);
                Windows.Storage.FileIO.writeTextAsync(file, fileContent).done(function () {
                    Windows.Storage.CachedFileManager.completeUpdatesAsync(file);
                });
            } else {
                // Failed
            }
        });
    }

    WinJS.Namespace.define("File", {
        openFile: openFile,
        saveFile: saveFile,
    });
})();