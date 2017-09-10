

var RTM = require("satori-rtm-sdk");

var endpoint = "wss://open-data.api.satori.com";
var appKey = "B4C5b11aA7BAca204ED5e6B3BE6f2252";
var channel = "wiki-rc-feed";

var client = new RTM(endpoint, appKey);

var subscription = client.subscribe(channel, RTM.SubscriptionMode.SIMPLE);

export { client, subscription, channel };
