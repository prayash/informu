import React, { Component } from 'react'
import { Alert, DeviceEventEmitter, View } from 'react-native'
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

import ViewContainer from '../components/ViewContainer'
import { colors } from '../config/theme'

export default class LoginView extends Component {
  constructor(props) {
    super(props)
  }

  componentDidMount() {
    
  }

  render() {
    const { params } = this.props.navigation.state
    return (
      <ViewContainer>

        <Text>Login!</Text>

      </ViewContainer>
    )
  }
}
