import React, { Component } from 'react';
import {
  DeviceEventEmitter,
  ListView,
  Navigator,
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from 'react-native';

import Beacons from 'react-native-beacons-manager'
import ViewContainer from '../components/ViewContainer'
import Icon from 'react-native-vector-icons/FontAwesome'

let ds = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 != r2 })

export default class TagsCollection extends Component {

  constructor(props) {
    super(props)

    this.state = {
      tags: [],
      dataSource: ds.cloneWithRows([])
    }
  }
  
  componentDidMount() {
    const region = {
      identifier: 'Simblee',
      uuid: 'E2C56DB5-DFFB-48D2-B060-D0F5A71096E0'
    };

    Beacons.requestWhenInUseAuthorization();
    Beacons.startMonitoringForRegion(region);
    Beacons.startRangingBeaconsInRegion(region);
    Beacons.startUpdatingLocation();

    // Ranging: Listen for beacon changes
    this.beaconsDidRange = DeviceEventEmitter.addListener(
      'beaconsDidRange',
      (data) => {
        this.setState({
          tags: data.beacons,
          dataSource: ds.cloneWithRows(data.beacons),
        });
      }
    );
  }

  render() {
    console.log(this.state.tags[0])
    return (
      <ViewContainer>
        <View style={styles.container}>
          <ListView
            style={{ marginTop: 50 }}
            dataSource={this.state.dataSource}
            renderRow={(tags) => { return this._renderRow(tags) }} />
        </View>
      </ViewContainer>
    );
  }

  _renderRow(tag) {
    return (
      <TouchableOpacity onPress={(e) => this._navigateToTagShow(tag)}>
      <View style={styles.beaconRow}>
        <View>
          <Text>Proximity: {tag.proximity}</Text>
          <Text>RSSI: {tag.rssi}</Text>
          <Text>Accuracy: {tag.accuracy}</Text>
        </View>
        <View style={{ flex: 1 }} />
        <Icon name='chevron-right' size={20} style={styles.disclosureIndicator} />
      </View>
      </TouchableOpacity>
    )
  }

  _navigateToTagShow(tag) {
    this.props.navigator.push({
      id: 'TagShow',
      tag: tag
    })
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },

  beaconRow: {
    flexDirection: 'row',
    justifyContent: 'flex-start',
    alignItems: 'center',
    height: 50
  },

  disclosureIndicator: {
    color: 'orange',
    height: 20,
    width: 20
  }
});
