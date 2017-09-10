import React from 'react';
import ReactDOM from 'react-dom';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

import RaisedButton from 'material-ui/RaisedButton';

import AppBar from 'material-ui/AppBar';






const MyAwesomeReactComponent = () => (
  <RaisedButton label="Default" />
);


/**
 * A simple example of `AppBar` with an icon on the right.
 * By default, the left icon is a navigation-menu.
 */
const AppBarExampleIcon = () => (
  <AppBar
    title="Re-quest"
    iconClassNameRight="muidocs-icon-navigation-expand-more"
  />
);

const App = () => (
  <MuiThemeProvider>
    <AppBarExampleIcon/>
  </MuiThemeProvider>
);

export default App;