import RTM from "satori-rtm-sdk";
import rtm from '../imports/satori/setup.js';


  // create a new subscription with "your-channel" name
  var channel = rtm.subscribe("your-channel", RTM.SubscriptionMode.SIMPLE);

  // add channel data handlers

  // channel receives any published message
  channel.on("rtm/subscription/data", function(pdu) {
    pdu.body.messages.forEach(console.log);
  });

  // client enters 'connected' state
  rtm.on("enter-connected", function() {
    rtm.publish("your-channel", {key: "value"});
  });

  // client receives any PDU and PDU is passed as a parameter
  rtm.on("data", function(pdu) {
    if (pdu.action.endsWith("/error")) {
      rtm.restart();
    }
  });
  rtm.start();

// start the client
Meteor.publish('satori-publication', function() {


  // We can add documents one at a time
  this.added('satori-messages', 'id', {field: 'values'});
  // We can call ready to indicate to the client that the initial document sent has been sent
  this.ready();
  // We may respond to some 3rd party event and want to send notifications
  // Meteor.setTimeout(() => {
  //   // If we want to modify a document that we've already added
  //   this.changed('satori-messages', 'id', {field: 'new-value'});
  //   // Or if we don't want the client to see it any more
  //   this.removed('satori-messages', 'id');
  // });
  // It's very important to clean up things in the subscription's onStop handler
  this.onStop(() => {

    rtm.stop();
    console.log('rtm stopped');
    // Perhaps kill the connection with the 3rd party server
  });
});

