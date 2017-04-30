import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  TouchableOpacity,
  View
} from 'react-native';

import ViewContainer from '../components/ViewContainer'

export default class TagShow extends Component {

  constructor(props) {
    super(props)
  }

  render() {
    return (
      <ViewContainer style={{ backgroundColor: 'dodgerblue' }}>
        <Text>PUSHED VIEW</Text>
        <Text style={styles.uuid}>{this.props.tag.uuid}</Text>
      </ViewContainer>
    );
  }
}

const styles = StyleSheet.create({
  uuid: {
    marginLeft: 25,
    fontSize: 25
  }
});
