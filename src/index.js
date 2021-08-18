/**
 * 初期化
 */
const init = async () => {
    while (true) {
        const jsonFile = await readJson();
        await registerAction(jsonFile);
    }
};

/** 5秒後にスタート */
setTimeout(init, 5000);