
// import RTM from "satori-rtm-sdk";
import rtm from '../imports/satori/setup.js';

// Meteor.setTimeout(()=>{
//   // create a new subscription with "your-channel" name
//     var channel = rtm.subscribe("your-channel", RTM.SubscriptionMode.SIMPLE);
//
//   // add channel data handlers
//
//   // channel receives any published message
//     channel.on("rtm/subscription/data", function(pdu) {
//       pdu.body.messages.forEach(console.log);
//     });
//
//   // client enters 'connected' state
//     rtm.on("enter-connected", function() {
//       rtm.publish("your-channel", {key: "value"});
//     });
//
//   // client receives any PDU and PDU is passed as a parameter
//     rtm.on("data", function(pdu) {
//       if (pdu.action.endsWith("/error")) {
//         rtm.restart();
//       }
//     });
//
//   // start the client
//     rtm.start();
// }, 500);


// import SatoriMessages from '../imports/common/collections.js';
//
// const handle = Meteor.subscribe('satori-publication');
// Tracker.autorun(() => {
//   const isReady = handle.ready();
//   console.log(`Handle is ${isReady ? 'ready' : 'not ready'}`);
//
//   console.log('satori-messages', SatoriMessages.find().fetch());
// });