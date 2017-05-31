import React, { Component } from 'react'
import { Alert, DeviceEventEmitter, View } from 'react-native'
import { StackNavigator } from 'react-navigation'
import Beacons from 'react-native-beacons-manager'
import {
  Body,
  Button,
  Container,
  Content,
  Header,
  Icon,
  Left,
  Right,
  Text,
  Title
} from 'native-base'

export default class HomeView extends Component {
  constructor(props) {
    super(props)

  }

  componentDidMount() {

  }

  render() {
    return (
      <Container>
        <Content padder style={{ backgroundColor: '#ffffff' }}>

          

        </Content>
      </Container>
    )
  }
}

HomeView.navigationOptions = ({ navigation }) => ({
  header: (
    <Header noShadow={true} style={{ marginTop: 5, backgroundColor: '#ffffff', borderBottomColor: '#cccccc' }}>
      <Left>
        <Button
          transparent
          onPress={() => navigation.navigate("DrawerOpen")}>
          <Icon name="menu" style={{ color: '#e0742b' }} />
        </Button>
      </Left>
      <Body>
        <Title>Home</Title>
      </Body>
      <Right>
        
      </Right>
    </Header>
  )
})
