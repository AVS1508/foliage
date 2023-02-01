const functions = require("firebase-functions");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const axios = require("axios");
require('dotenv').config();

initializeApp();
const db = getFirestore();

const cryptocurrencyIds = ["bitcoin", "ethereum", "tether", "solana", "shiba-inu", "dogecoin", "ripple", "cardano", "stellar", "matic-network", "chainlink", "tron", "avalanche-2", "cosmos"];

exports.updateCryptocurrencyPrices = functions.pubsub.schedule('* * * * *').onRun(async (context) => {
    const stringifiedIds = cryptocurrencyIds.join('%2C');
    const response = await axios({
        method: 'GET',
        url: `https://api.coingecko.com/api/v3/simple/price?ids=${stringifiedIds}&vs_currencies=usd&precision=18`,
        responseType: 'json'
    });
    const data = await response.data;
    let pricesObject = {};
    for (const id of cryptocurrencyIds) {
        pricesObject[id] = data[id]['usd'];
    }
    for (const [id, price] of Object.entries(pricesObject)) {
        await db.collection('prices').doc(id).set({ price: price });
    }
});
