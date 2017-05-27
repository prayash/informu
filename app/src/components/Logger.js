import React, { Component } from "react"
import { View } from 'react-native'
import {
  Button,
  Text,
  Icon,
  Separator,
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
            primary
            iconRight
            style={{ marginTop: 10, width: '47.5%' }}
            onPress={() => this.props.navigation.navigate("Chat")}>
            <Text>Start</Text>
            <Icon name='play' />
          </Button>
          <Button
            light
            iconRight
            style={{ marginTop: 10, width: '47.5%' }}
            onPress={() => this.props.navigation.navigate("Profile")}>
            <Text>Stop</Text>
            <Icon name='pause' />
          </Button>
        </View>
      </View>
    )
  }
}