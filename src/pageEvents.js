/**
 * 通貨ペア繊維
 * @returns resolve
 *
 */
 const setTuka = (category) => {
    return new Promise(async (resolve) => {
        if (!category || category === json.category) {
            resolve();
        } else {
            const spanDocument = document.getElementsByClassName("asset-filter--opener"); // テキストエリア取得
            const assetItem = document.getElementsByClassName("asset_item"); // 全通貨取得
            const aseetList = Array.from(assetItem); // 配列へ変換
            const inputText = Array.from(spanDocument); // 配列へ変換
            const setTukaParam = () => {
                return new Promise(async (resolve) => {
                    aseetList.forEach((item) => {
                        if (item.textContent.trim() === category) {
                            item.click();
                            json.category = category;
                            resolve();
                        }
                    });
                    resolve();
                })
            };
            await inputText[0].click();
            await setTukaParam();
            resolve();
        }
    });
};

/**
 * 今すぐ購入ボタン押下
 */
const setEntry = (entry) => {
    return new Promise((resolve) => {
        if (!entry || entry === json.entry) {
            resolve();
        } else {
            const btnBuyNow = document.getElementById("invest_now_button");
            btnBuyNow.click();
            json.entry = entry;
            resolve();
        }
    });
};


/**
 * ハイ・ローエントリーボタンを押下
 */
const setHighOrLow = (trade) => {
    return new Promise((resolve) => {
        if (!trade || trade === json.trade) {
            resolve();
        } else {
            const tradeEvent = (id) => {
                const btnHigh = document.getElementById(id);
                btnHigh.click();
                json.trade = trade;
                resolve();
            }
            if (!trade) {
                resolve();
            } else {
                trade === "BUY" ? tradeEvent("up_button") : tradeEvent("down_button");
            }
        }
    });

};

/**
 * エントリー金額を送信
 * @returns resolve
 *
 */
const setMoney = (money) => {
    return new Promise((resolve) => {
        const input = document.getElementById("amount")
        input.value = money;
        input.click();
        setTimeout(() => {
            resolve();
        }, 15000);
    });
};