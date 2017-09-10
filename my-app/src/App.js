import React, { Component } from 'react';
import RTM from "satori-rtm-sdk";
// import { render } from "react-dom";
// import { makeData } from "./Utils";

// Import React Table
import ReactTable from "react-table";
import "react-table/react-table.css";

// import { withGoogleMap, GoogleMap, Marker } from "react-google-maps";
// import withScriptjs from "react-google-maps/lib/async/withScriptjs";

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
      const randomData = genData();
      test_client.publish(test_channel, randomData);
      n++;
      if(n < 1000) sendData();
    }, 3000);
  };
  sendData();
};

startTestData();

test_client.on('enter-connected', function () {
  console.log('Connected to Satori RTM!');
});

test_client.start();


class App extends React.Component {
  constructor() {
    super();
    this.state = {
      data_request: [],
      data_offer: [],
      data_geotype: [],
    };
  }

  componentDidMount() {
    let self = this;
    test_sub.on('rtm/subscription/data', function (pdu) {
      pdu.body.messages.forEach(function (msg) {
        console.log('Got message:', msg);
        const dataBucket = msg.direction === 'request' ? 'data_request' : 'data_offer';
        self.setState((ps)=>({[dataBucket]: [msg].concat(_.take(ps[dataBucket], 100))}))
      });
    });



    console.log('test_channel', test_channel);
    var test_sub_geotype = test_client.subscribe(test_channel+'1', RTM.SubscriptionMode.SIMPLE, {
      filter: 'SELECT * FROM `'+test_channel+'` GROUP BY type'
    });
  }
  componentWillUnmount() {
    test_client.stop();
  }

  // ["action", "change_size", "flags", "hashtags", "is_anon", "is_bot", "is_minor", "is_new", "is_unpatrolled", "mentions", "ns", "page_title", "parent_rev_id", "rev_id", "summary", "url", "user"]
  render() {
    const { data_request, data_offer, data_geotype  } = this.state;

    // eslint-disable-next-line

    //
    const f1 = function(a,b){console.log(a,b)};

    const self = this;
    return (
      <div>
        <div style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginLeft: '2em', marginRight: '2em'}}>
          <h1>Current Situation</h1>
          <img src="/logo.png" alt="Logo" style={{"height": '4em'}} />
        </div>
        <div style={{width: '100%', height: '400px'}}>
          <SimpleMap2 data={self.state.data_request.concat(self.state.data_offer)} />
        </div>

        <h1 style={{marginLeft: '1em'}}>Emergency Requests</h1>
        {table1(data_request)}

        <br/>

        <h1>Responders</h1>
        {table1(data_offer)}


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
              Header: "",
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
// const themap = (props) => (
//     <GoogleMap
//     ref={props.onMapLoad}
//     defaultZoom={3}
//     defaultCenter={{ lat: -25.363882, lng: 131.044922 }}
//     // Pass the map reference here as props
//     googleMapURL={googleMapURL}
//     onClick={props.onMapClick}
//   >
//     {props.markers.map((marker, index) => (
//       <Marker
//         {...marker}
//         onRightClick={() => props.onMarkerRightClick(index)}
//       />
//     ))}
//   </GoogleMap>
// )
//
//
// const GettingStartedGoogleMap = withGoogleMap(props => (
//   <GoogleMap
//     ref={props.onMapLoad}
//     defaultZoom={3}
//     defaultCenter={{ lat: -25.363882, lng: 131.044922 }}
//     onClick={props.onMapClick}
//   >
//     {props.markers.map((marker, index) => (
//       <Marker
//         {...marker}
//         onRightClick={() => props.onMarkerRightClick(index)}
//       />
//     ))}
//   </GoogleMap>
// ));

const markers = [];
// eslint-disable-next-line
// const map2 = ()=>(
//   <GettingStartedGoogleMap
//     containerElement={
//       <div style={{ height: `100%` }} />
//     }
//     mapElement={
//       <div style={{ height: `100%` }} />
//     }
//     onMapLoad={_.noop}
//     onMapClick={_.noop}
//     markers={markers}
//     onMarkerRightClick={_.noop}
//   />
// );
//
//
//
//
// // Wrap all `react-google-maps` components with `withGoogleMap` HOC
// // then wraps it into `withScriptjs` HOC
// // It loads Google Maps JavaScript API v3 for you asynchronously.
// // Name the component AsyncGettingStartedExampleGoogleMap
// const AsyncGettingStartedExampleGoogleMap = withScriptjs(
//   withGoogleMap(
//     props => (
//       <GoogleMap
//         ref={props.onMapLoad}
//         defaultZoom={3}
//         defaultCenter={{ lat: -25.363882, lng: 131.044922 }}
//         onClick={props.onMapClick}
//       >
//         {props.markers.map(marker => (
//           <Marker
//             {...marker}
//             onRightClick={() => props.onMarkerRightClick(marker)}
//           />
//         ))}
//       </GoogleMap>
//     )
//   )
// );

// eslint-disable-next-line
// const map3 = (props) => (
//
//   <AsyncGettingStartedExampleGoogleMap
//     googleMapURL={"https://maps.googleapis.com/maps/api/js?v=3.exp&key="+googleMapsAPIKey}
//     loadingElement={
//       <div style={{ height: `100%` }}>
//         {/*<FaSpinner*/}
//           {/*style={{*/}
//             {/*display: `block`,*/}
//             {/*width: `80px`,*/}
//             {/*height: `80px`,*/}
//             {/*margin: `150px auto`,*/}
//             {/*animation: `fa-spin 2s infinite linear`,*/}
//           {/*}}*/}
//         {/*/>*/}
//       </div>
//     }
//     containerElement={
//       <div style={{ height: `100%` }} />
//     }
//     mapElement={
//       <div style={{ height: `100%` }} />
//     }
//     onMapLoad={_.noop}
//     onMapClick={_.noop}
//     markers={markers}
//     onMarkerRightClick={_.noop}
//   />
//   )

const markerStyle = {
  transport: [FaAutomobile, '#da403a'],
  food: [FaCutlery, '#ffaf05'],
	supply: [FaArchive, '#646d72'],
	medical: [FaHeartbeat, '#00a8cf'],
	clothing: [FaFemale, '#f37b6d'],
	shoes: [FaCheck, '#774b98'],
};

const MarkerComponent = ({re_quest}) => {
  const {direction, type} = re_quest;
  const backgroundColor = direction === "request" ? "red" : "blue";
  const iconStyle = {width: '2em', height: '2em'};
  const iconSymbol = markerStyle[type][0];
  return (
    <div style={{
      color: 'white', background: backgroundColor,
      height: 50, width: 50, top: -20, left: -30,
      flexDirection: 'column',  borderRadius: '1em',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
    }}>
      {React.createElement(iconSymbol , {style:iconStyle})}
      {type}
    </div>
  )
};


class SimpleMap2 extends Component {
  static defaultProps = {
    center: {lat: 37.773660, lng: -122.415878},
    zoom: 13,
    renderHack: 0.01,
  };
  //
  // componentDidUpdate() {
  //   this.setState((ps)=>{renderHack: (-1)*ps.renderHack});
  // }
  componentDidMount() {
    const self = this;

    setInterval(()=>{
      self.setState((ps)=>{renderHack: (-1)*ps.renderHack});
    }, 1000);
    //
  }

  render() {
    const self = this;
    const {lat, lng} = this.props.center;
    const firstPoint = self.props.data[0];
    // const lat = _.isUndefined(firstPoint) || _.isUndefined(firstPoint.lat) ? lat0 : firstPoint.lat;
    // const lng = _.isUndefined(firstPoint) || _.isUndefined(firstPoint.lng) ? lng0 : firstPoint.lng;
    // console.log('lat', 'lng', lat, lng);

    const refreshF = (a,b,c) => {
      console.log('refreshF', a,b,c);
    };
    return (
      <GoogleMapReact
        apiKey={googleMapsAPIKey}
        zoom={this.props.zoom}
        center={{lat: lat+this.props.renderHack, lng}}
        key={this.props.renderHack}

      >

      { self.props.data.map((re_quest, n)=>{
          return (
             <MarkerComponent
              lat={lat}
              lng={lng}
              re_quest={re_quest}
              key={n}
              onBoundsChange={refreshF}
              onChildClick={refreshF}
              onChildMouseEnter={refreshF}
              onChildMouseLeave={refreshF}
            />
          )
      })}

      </GoogleMapReact>
    );
  }
}
