import RTM from "satori-rtm-sdk";

const ENDPOINT = "wss://kpbbao2l.api.satori.com";
const APPKEY = "E8eA0fEc0B3a8af1ca39b0aBADc0F18d";

// create an RTM client instance
var rtm = new RTM(ENDPOINT, APPKEY);

export default rtm;
