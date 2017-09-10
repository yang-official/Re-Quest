import React from 'react';
import AppBar from 'material-ui/AppBar';
import Drawer from 'material-ui/Drawer';
import MenuItem from 'material-ui/MenuItem';
import RaisedButton from 'material-ui/RaisedButton';


/**
 * A simple example of `AppBar` with an icon on the right.
 * By default, the left icon is a navigation-menu.
 */

export default class AppBarExample extends React.Component {

  constructor(props) {
    super(props);
    this.state = {open: false};
  }

  handleToggle = () => {
    console.log('clicked');
    this.setState({open: !this.state.open});

  }

  render() {
    return (
      <div>
      <AppBar
        title="Re-Quest"
        iconClassNameRight="muidocs-icon-navigation-expand-more"
        onLeftIconButtonTouchTap={this.handleToggle}
        // onRightIconButtonTouchTap={this.handleToggle}
        // onTitleTouchTap={this.handleToggle}
        zDepth={1}
      />
        <Drawer open={this.state.open} zDepth={2}>
          <MenuItem  style={{marginTop: 30}} onTouchTap={()=>{

            this.setState({open: false});
            FlowRouter.go('/profile')
          }
          }>Profile</MenuItem>
          <MenuItem>Requests</MenuItem>
        </Drawer>
      </div>
    );
  }
}