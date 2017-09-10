import React, { Component } from 'react';
import RTM from "satori-rtm-sdk";
// import { render } from "react-dom";
// import { makeData } from "./Utils";

// Import React Table
import ReactTable from "react-table";
import "react-table/react-table.css";

import { withGoogleMap, GoogleMap, Marker } from "react-google-maps";
import withScriptjs from "react-google-maps/lib/async/withScriptjs";

import _ from 'lodash';
import moment from 'moment';

import GoogleMapReact from 'google-map-react';

// import { client as wiki_client, subscription as wiki_sub, channel as wiki_channel } from './satori/channel_wiki';
import { client as test_client, subscription as test_sub, channel as test_channel } from './satori/channel_test';

import faker from 'faker'

var FaCutlery = require('react-icons/lib/fa/cutlery');
var FaAutomobile = require('react-icons/lib/fa/automobile');
var FaHeartbeat = require('react-icons/lib/fa/heartbeat');
var FaFemale = require('react-icons/lib/fa/female');
var FaCheck = require('react-icons/lib/fa/check');
var FaArchive = require('react-icons/lib/fa/archive');


const startTestData = () => {
  console.log('ole');
  const range = {
    userId: [0, 1000],
    lng: [37.752350, 37.804730],
    lat: [-122.464959, -122.381635],
    direction: ['offer', 'request'],
    type: ['transport', 'food', 'supply', 'medical', 'clothing', 'shoes'],
    transport: [1,10],
    medical: ['urgent', 'moderate', 'low priority'],
    food: ['water', 'food'],
    supply: ['diapers', 'batteries'],
    clothing: ['man', 'woman', 'boy', 'girl'],
    shoes: [5,12],
  };

  const randomNumRange = ([min, max]) => faker.random.number({min, max});

  const genData = () => {
    const dataRoot = {
      userId: randomNumRange(range.userId),
      lng: randomNumRange(range.lng),
      lat: randomNumRange(range.lat),
      direction: faker.random.arrayElement(range.direction),
      type: faker.random.arrayElement(range.type),
    };

    let dataDetails;
    switch(dataRoot.type) {
      case 'transport':
        dataDetails = { numPeople: faker.random.arrayElement(range.transport) };
        break;
      case 'medical':
        dataDetails = { severity: faker.random.arrayElement(range.medical) };
        break;
      case 'food':
        dataDetails = { foodType: faker.random.arrayElement(range.food) };
        break;
      case 'supply':
        dataDetails = { item: faker.random.arrayElement(range.supply) };
        break;
      case 'clothing':
        dataDetails = { target: faker.random.arrayElement(range.clothing) };
        break;
			case 'shoes':
        dataDetails = { size: randomNumRange(range.shoes) };
        break;
      default:
        dataDetails = {};
        break;

    };

    const newData = _.merge({ requestedAt: new Date(), status: 'new', ackBy: [] },dataRoot, {details: dataDetails});

    return newData;
  };

  let n = 0;
  const sendData = ()=>{
    setTimeout(()=>{
      console.log('inside timer', n);
      const randomData = genData();
      console.log('randomData', randomData);
      test_client.publish(test_channel, randomData);
      n++;
      if(n < 1000) sendData();
    }, 1000);
  };
  sendData();
};

// startTestData();

// test_client.on('enter-connected', function () {
//   console.log('Connected to Satori RTM!');
// });
//
// test_client.start();


class App extends React.Component {
  constructor() {
    super();
    this.state = {
      data_request: [],
      data_offer: [],
      data_geotype: [],
    };
  }

  // componentDidMount() {
  //   let self = this;
  //   test_sub.on('rtm/subscription/data', function (pdu) {
  //     pdu.body.messages.forEach(function (msg) {
  //       console.log('Got message:', msg);
  //       const dataBucket = msg.direction === 'request' ? 'data_request' : 'data_offer';
  //       self.setState((ps)=>({[dataBucket]: [msg].concat(_.take(ps[dataBucket], 100))}))
  //     });
  //   });
  //
  //
  //
  //   console.log('test_channel', test_channel);
  //   var test_sub_geotype = test_client.subscribe(test_channel+'1', RTM.SubscriptionMode.SIMPLE, {
  //     filter: 'SELECT * FROM `'+test_channel+'` GROUP BY type'
  //   });
  // }
  componentWillUnmount() {
    test_client.stop();
  }

  // ["action", "change_size", "flags", "hashtags", "is_anon", "is_bot", "is_minor", "is_new", "is_unpatrolled", "mentions", "ns", "page_title", "parent_rev_id", "rev_id", "summary", "url", "user"]
  render() {
    // const { data_request, data_offer, data_geotype  } = this.state;

    // eslint-disable-next-line
    // <SimpleMap data={ _.concat(data_request, data_offer)} />

    // {table1(data_request)}
    //
    // {table1(data_offer)}
    //
    const f1 = function(a,b){console.log(a,b)};

    return (
      <div>
        <h1>Current Situation</h1>
        <div style={{width: '100%', height: '400px'}}>
        </div>
        {/*{ map({onMapLoad: f1, markers: []})}*/}
        {/*<GoogleMap*/}
          {/*onClick={_.noop}*/}
          {/*onRightClick={_.noop}*/}
          {/*onDragStart={_.noop}*/}
        {/*/>*/}
        <h1>Emergency Requests</h1>

        <br/>

          <h1>Responders</h1>


      </div>
    )
  }
}

export default App;

const table1 = (data) => (
    <ReactTable
      data={data}
      columns={[
        {
          Header: "Description",
          columns: [
            {
              Header: "Direction",
              accessor: "direction"
            },
            {
              Header: "Type",
              accessor: "type"
            },            {
              Header: "Details",
              id: 'details',
              accessor: d => _.join(_.values(d.details), ",")
            },
          ]
        },
        {
          Header: "Location",
          columns: [
            {
              Header: "Longitude",
              accessor: "lng"
            },
            {
              Header: "Latitude",
              accessor: "lat"
            }
          ]
        },
        {
          Header: 'Requested At',
          columns: [
            {
              Header: "Requested At",
              id: "requestedAt",
              accessor: d => moment(d.requestedAt).format('LT'),
            }
          ]
        }
      ]}
      defaultPageSize={10}
      className="-striped -highlight"
    />
);


const table2 = (data) => (
    <ReactTable
      data={data}
      columns={[
        {
          Header: "Page",
          columns: [
            {
              Header: "Title",
              accessor: "page_title"
            }
          ]
        },
        {
          Header: "Location",
          columns: [
            {
              Header: "City",
              accessor: "geo_ip.city"
            },
            {
              Header: "Summary",
              accessor: "summary"
            }
          ]
        },
        {
          Header: 'URL',
          columns: [
            {
              Header: "URL",
              accessor: "url",
            }
          ]
        }
      ]}
      defaultPageSize={10}
      className="-striped -highlight"
    />
);

const googleMapsAPIKey = "AIzaSyBlGrA1_s4Sd2qbGvyIeVw8lc3DfGcstbY";
const googleMapURL="https://maps.googleapis.com/maps/api/js?v=3.27&libraries=places,geometry&key="+googleMapsAPIKey

// eslint-disable-next-line
const map = (props) => (
    <GoogleMap
    ref={props.onMapLoad}
    defaultZoom={3}
    defaultCenter={{ lat: -25.363882, lng: 131.044922 }}
    // Pass the map reference here as props
    googleMapURL={googleMapURL}
    onClick={props.onMapClick}
  >
    {props.markers.map((marker, index) => (
      <Marker
        {...marker}
        onRightClick={() => props.onMarkerRightClick(index)}
      />
    ))}
  </GoogleMap>
)


const GettingStartedGoogleMap = withGoogleMap(props => (
  <GoogleMap
    ref={props.onMapLoad}
    defaultZoom={3}
    defaultCenter={{ lat: -25.363882, lng: 131.044922 }}
    onClick={props.onMapClick}
  >
    {props.markers.map((marker, index) => (
      <Marker
        {...marker}
        onRightClick={() => props.onMarkerRightClick(index)}
      />
    ))}
  </GoogleMap>
));

const markers = [];
// eslint-disable-next-line
const map2 = ()=>(
  <GettingStartedGoogleMap
    containerElement={
      <div style={{ height: `100%` }} />
    }
    mapElement={
      <div style={{ height: `100%` }} />
    }
    onMapLoad={_.noop}
    onMapClick={_.noop}
    markers={markers}
    onMarkerRightClick={_.noop}
  />
);




// Wrap all `react-google-maps` components with `withGoogleMap` HOC
// then wraps it into `withScriptjs` HOC
// It loads Google Maps JavaScript API v3 for you asynchronously.
// Name the component AsyncGettingStartedExampleGoogleMap
const AsyncGettingStartedExampleGoogleMap = withScriptjs(
  withGoogleMap(
    props => (
      <GoogleMap
        ref={props.onMapLoad}
        defaultZoom={3}
        defaultCenter={{ lat: -25.363882, lng: 131.044922 }}
        onClick={props.onMapClick}
      >
        {props.markers.map(marker => (
          <Marker
            {...marker}
            onRightClick={() => props.onMarkerRightClick(marker)}
          />
        ))}
      </GoogleMap>
    )
  )
);

// eslint-disable-next-line
const map3 = (props) => (

  <AsyncGettingStartedExampleGoogleMap
    googleMapURL={"https://maps.googleapis.com/maps/api/js?v=3.exp&key="+googleMapsAPIKey}
    loadingElement={
      <div style={{ height: `100%` }}>
        {/*<FaSpinner*/}
          {/*style={{*/}
            {/*display: `block`,*/}
            {/*width: `80px`,*/}
            {/*height: `80px`,*/}
            {/*margin: `150px auto`,*/}
            {/*animation: `fa-spin 2s infinite linear`,*/}
          {/*}}*/}
        {/*/>*/}
      </div>
    }
    containerElement={
      <div style={{ height: `100%` }} />
    }
    mapElement={
      <div style={{ height: `100%` }} />
    }
    onMapLoad={_.noop}
    onMapClick={_.noop}
    markers={markers}
    onMarkerRightClick={_.noop}
  />
  )

const markerStyle = {
  transport: [FaAutomobile, '#da403a'],
  food: [FaCutlery, '#ffaf05'],
	supply: [FaArchive, '#646d72'],
	medical: [FaHeartbeat, '#00a8cf'],
	clothing: [FaFemale, '#f37b6d'],
	shoes: [FaCheck, '#774b98'],
};

const MarkerComponent = ({direction, type}) => {
  const backgroundColor = direction === "request" ? "red" : "blue";
  const iconStyle = {width: '2em', height: '2em'};
  const iconSymbol = markerStyle[type][0];
  return (
    <div style={{
      position: 'relative', color: 'white', background: {backgroundColor},
      height: 40, width: 60, top: -20, left: -30,
    }}>
      <iconSymbol style={iconStyle} />
      {type}
    </div>
  )
};


class SimpleMap extends Component {
  static defaultProps = {
    center: {lat: 37.773660, lng: -122.415878},
    zoom: 13,
    renderHack: 1,
  };

  // componentDidMount() {
  //   const self = this;
  //
  //   setInterval(()=>{
  //     self.setState((ps)=>{renderHack: (-1)*ps.renderHack});
  //   }, 1000);
  //   //
  // }

  render() {
    const self = this;
    return (
      <GoogleMapReact
        defaultCenter={this.props.center}
        defaultZoom={this.props.zoom}
      >

      { _.take(this.props.data, 3).map((re_quest)=>{
          return
            <MarkerComponent
              lat={37.773660+self.state.renderHack}
              lng={-122.415878}
              re_quest={re_quest}
            />
      })}

      </GoogleMapReact>
    );
  }
}
