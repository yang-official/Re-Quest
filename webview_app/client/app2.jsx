import React, {Component} from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';

import RaisedButton from 'material-ui/RaisedButton';

import AppBar from 'material-ui/AppBar';

import BottomNav from './components/bottomnav.jsx';

import Dialog from 'material-ui/Dialog';
import {Tabs, Tab} from 'material-ui/Tabs';
import {deepOrange500} from 'material-ui/styles/colors';
import FlatButton from 'material-ui/FlatButton';
import getMuiTheme from 'material-ui/styles/getMuiTheme';


const muiTheme = getMuiTheme({
  palette: {
    accent1Color: deepOrange500,
  },
});

const styles = {
  container: {
    textAlign: 'center',
    height: "100%",
    overflowY: "auto",
  },
  root: {
    flex: '1 1 100%',
    minHeight: 0,
    display: 'flex',
    flexDirection: 'column'
  },
  bottomNav: {
    position: "absolute",
    bottom: 0,
    right: 0,
    width: '100%',
  },
  container2: {
    flex: '1 1 100%;',
    display: 'flex',
    flexDirection: 'column',
    overflowY: 'auto'
  },
};

class TabTemplate extends React.Component {
  render() {
    if (!this.props.selected) {
      return null;
    }

    return this.props.children;
  }
}

class Main extends Component {
  constructor(props, context) {
    super(props, context);

    this.handleRequestClose = this.handleRequestClose.bind(this);
    this.handleTouchTap = this.handleTouchTap.bind(this);

    this.state = {
      open: false,
    };
  }

  handleRequestClose() {
    this.setState({
      open: false,
    });
  }

  handleTouchTap() {
    this.setState({
      open: true,
    });
  }

  render() {
    const standardActions = (
      <FlatButton
        label="Ok"
        primary={true}
        onTouchTap={this.handleRequestClose}
      />
    );

    return (
      <MuiThemeProvider muiTheme={muiTheme}>
        <div style={styles.container}>

          <AppBar/>

          <Dialog
            open={this.state.open}
            title="Super Secret Password"
            actions={standardActions}
            onRequestClose={this.handleRequestClose}
          >
            1-2-3-4-5
          </Dialog>

          <h1>Material-UI</h1>
          <h2>example project</h2>
          <RaisedButton
            label="Super Secret Password"
            secondary={true}
            onTouchTap={this.handleTouchTap}
          />

          <Tabs
            style={styles.bottomNav}
            contentContainerStyle={styles.container}
            tabTemplate={TabTemplate}
          >
            <Tab label="tab1"></Tab>
            <Tab label="tab2"></Tab>
          </Tabs>

        </div>
      </MuiThemeProvider>
    );
  }
}

// <BottomNav />
export default Main;



