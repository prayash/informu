import React, { Component } from 'react'
import { Alert, DeviceEventEmitter, View } from 'react-native'
import Beacons from 'react-native-beacons-manager'
import {
  Body,
  Button,
  Header,
  Icon,
  Left,
  Right,
  Text,
  Title
} from 'native-base'
import moment from 'moment'

import ViewContainer from '../components/ViewContainer'
import CollectionList from '../components/CollectionList'
import Logger from '../components/Logger.js'
import { colors } from '../config/theme'
import { convertToCSV } from '../utils'
import tags from '../config/data'

let recordedTags = []

export default class HomeView extends Component {
  constructor(props) {
    super(props)

    this.state = {
      tags: [],
      record: false
    }
  }

  componentDidMount() {
    const region = {
      identifier: 'Simblee',
      uuid: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'
    }

    Beacons.requestWhenInUseAuthorization()
    Beacons.startMonitoringForRegion(region)
    Beacons.startRangingBeaconsInRegion(region)
    Beacons.startUpdatingLocation()

    const subscription = DeviceEventEmitter.addListener(
      'beaconsDidRange',
      (data) => {
        // console.log(data.beacons)
        if (this.state.record) {
          let beacon = data.beacons[0]
          let t = {
            timestamp: moment().format('LTS'),
            device_name: 'Tag',
            uuid: beacon.uuid,
            major: beacon.major,
            minor: beacon.minor,
            rssi: beacon.rssi,
            distance: beacon.proximity,
            accuracy: beacon.accuracy
          }
          recordedTags.push(t)
        } else {
          console.log(recordedTags)
          console.log(convertToCSV({ data: recordedTags }))
        }

        // data.region - The current region
        // data.region.identifier
        // data.region.uuid

        // timestamp, device_name, UUID, major num, minor num, RSSI, distance_entry
        // data.beacons - Array of all beacons inside a region
        //	in the following structure:
        //	  .uuid
        //	  .major - The major version of a beacon
        //	  .minor - The minor version of a beacon
        //	  .rssi - Signal strength: RSSI value (between -100 and 0)
        // 	  .proximity - Proximity value, can either be "unknown", "far", "near" or "immediate"
        //	  .accuracy - The accuracy of a beacon
      }
    )
  }

  startRecording = () => {
    this.setState({ record: true })
    Alert.alert('Started data collection!', 'Feel free to stop whenever.')
    console.log('Started recording')
  }

  stopRecording = () => {
    this.setState({ record: false })
    Alert.alert('Stopped data collection!', 'The CSV file is ready to parse.')
    console.log('Stopped recording')
  }

  render() {
    return (
      <ViewContainer>

        <CollectionList tags={tags} navigation={this.props.navigation} />

        <Logger
          record={this.state.record}
          onStart={this.startRecording}
          onStop={this.stopRecording} />

      </ViewContainer>
    )
  }
}

HomeView.navigationOptions = ({ navigation }) => ({
  header: (
    <Header noShadow={true} style={{ marginTop: 5, backgroundColor: colors.white, borderBottomColor: '#cccccc' }}>
      <Left>
        <Button
          transparent
          onPress={() => navigation.navigate('DrawerOpen')}>
          <Icon name="menu" style={{ color: colors.orange }} />
        </Button>
      </Left>
      <Body>
        <Title>Home</Title>
      </Body>
      <Right>
        <Button
          transparent
          onPress={() => navigation.navigate('AddTagView')}>
          <Icon name="add" style={{ color: colors.orange }} />
        </Button>
      </Right>
    </Header>
  )
})
