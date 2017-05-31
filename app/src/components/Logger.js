import React, { Component } from "react"
import { Alert, View } from 'react-native'
import {
  Button,
  Text,
  Icon,
  Separator,
  Spinner
} from "native-base"

export default class Logger extends Component {
  render() {
    return (
      <View>
        <Separator style={{ backgroundColor: "#ffffff" }}>
          <Text>LOGGER</Text>
        </Separator>
        
        <View style={{ flex: 1, flexDirection: 'row', justifyContent: 'space-between' }}>
          <Button
            light
            iconRight
            style={{ marginTop: 10, width: '47.5%', backgroundColor: this.props.record ? '#f4f4f4' : 'orange' }}
            onPress={this.props.onStart}>
            <Text>Start</Text>
            <Icon name='play' />
          </Button>
          <Button
            light
            iconRight
            style={{ marginTop: 10, width: '47.5%', backgroundColor: this.props.record ? 'orange' : '#f4f4f4' }}
            onPress={this.props.onStop}>
            <Text>Stop</Text>
            <Icon name='pause' />
          </Button>
        </View>

        {this.props.record ? <Spinner color="#e0742b" /> : null}
      </View>
    )
  }
}