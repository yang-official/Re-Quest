import { Meteor } from 'meteor/meteor';
import React from 'react';
import { render } from 'react-dom';
import HelloWorld from './app.jsx';
import MyGriddler from './griddle.jsx';

import injectTapEventPlugin from 'react-tap-event-plugin';

Meteor.startup(() => {
// Needed for onTouchTap
// http://stackoverflow.com/a/34015469/988941
  injectTapEventPlugin();


  //Only start if this is a cordova project
  if (Meteor.isCordova) {
    //Only run commands after cordova has finished device Ready
    Meteor.startup(function() {
      //Configure Plugin
      BackgroundLocation.configure({
        desiredAccuracy: 5, // Desired Accuracy of the location updates (lower = more accurate).
        distanceFilter: 1, // (Meters) Distance between points aquired.
        debug: true, // Show debugging info on device.
        interval: 9000, // (Milliseconds) Requested Interval in between location updates.
        useActivityDetection: true, // Shuts off GPS when your phone is still, increasing battery life enormously

        //[Android Only Below]
        notificationTitle: 'BG Plugin', // Customize the title of the notification.
        notificationText: 'Tracking', // Customize the text of the notification.
        fastestInterval: 5000, //(Milliseconds) - Fastest interval OS will give updates.
      });

      //Register a callback for location updates.
      //this is where location objects will be sent in the background
      BackgroundLocation.registerForLocationUpdates(function (location) {
        console.log("We got a Background Update" + JSON.stringify(location));
      }, function (err) {
        console.log("Error: Didnt get an update", err);
      });

      //Register a callback for activity updates 
      //If you set the option useActivityDetection to true you will recieve
      //periodic activity updates, see below for more information
      BackgroundLocation.registerForActivityUpdates(function (activities) {
        console.log("We got an activity Update" + JSON.stringify(activities));
      }, function (err) {
        console.log("Error:", err);
      });

      //Start the Background Tracker. 
      //When you enter the background tracking will start.
      BackgroundLocation.start();

      ///later, to stop
      // BackgroundLocation.stop();

    });
  }
  
});

