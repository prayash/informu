import React, { Component } from 'react'
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

import ViewContainer from '../components/ViewContainer'
import { colors } from '../config/theme'

export default class HomeView extends Component {
  constructor(props) {
    super(props)

  }

  componentDidMount() {

  }

  render() {
    return (
      <ViewContainer>

        <Text>Add a tag here!</Text>

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
          onPress={() => navigation.goBack()}>
          <Icon name="arrow-back" style={{ color: colors.orange }} />
        </Button>
      </Left>
      <Body>
        <Title>Select a tag</Title>
      </Body>
      <Right>
        
      </Right>
    </Header>
  )
})
