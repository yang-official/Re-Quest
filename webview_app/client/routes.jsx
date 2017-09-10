import { Meteor } from 'meteor/meteor';
import React from 'react';
import HelloWorld from './app.jsx';
import App from './app2.jsx';
import Profile from './profile.jsx';
// import Example from './example.jsx';
import MyGriddler from './griddle.jsx';

import {mount} from 'react-mounter';

FlowRouter.route('/', {
  action: function(params, queryParams) {
    console.log("Yeah! We are on the post:", params.postId);

    mount(App);
  }
});


FlowRouter.route('/profile', {
  action: function(params, queryParams) {
    mount(Profile);
  }
});
