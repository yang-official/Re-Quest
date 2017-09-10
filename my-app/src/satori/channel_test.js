

var RTM = require("satori-rtm-sdk");

var endpoint = "wss://kpbbao2l.api.satori.com";
var appKey = "E8eA0fEc0B3a8af1ca39b0aBADc0F18d";
var channel = "test-feed";

var client = new RTM(endpoint, appKey);

var subscription = client.subscribe(channel, RTM.SubscriptionMode.SIMPLE);

export { client, subscription, channel };
