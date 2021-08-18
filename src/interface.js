/**
 * グローバルオブジェクト
 * ローカルでjson情報を手軽に制御する
 */
 var json = {
    trade: "",
    time: "",
    category: "",
    money: "",
    entry: ""
};

/**
 * イベントを順に実装する
 */
const registerAction = (jsonFile) => {
    return new Promise(async (resolve) => {
        await setTuka(jsonFile.category);
        await setMoney(jsonFile.money);
        await setHighOrLow(jsonFile.trade);
        await setEntry(jsonFile.entry);
        resolve();
    });
}