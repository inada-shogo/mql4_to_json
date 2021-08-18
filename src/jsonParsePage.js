const readJson = async () => {

    const jsonFile = new Promise(
        (resolve) => {
            const file = "SignalDataForHighLow.json";
            const xhr = new XMLHttpRequest();
            xhr.responseType = "json";

            xhr.addEventListener("load", (event) => {
                // window.console.log(`success`);
                resolve(xhr.response);
            });
            xhr.addEventListener("error", (event) => {
                window.console.error(`SignalDataForHighLow.jsonを読み込めませんでした。`);
                resolve({});
            });

            xhr.open("GET", chrome.extension.getURL(file), true);
            xhr.send();
        }
    );
    
    return await jsonFile;

}