import React, { Component } from 'react'
import { Alert, DeviceEventEmitter, View } from 'react-native'
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

import { colors } from '../config/theme'

export default class TagView extends Component {
  constructor(props) {
    super(props)
  }

  componentDidMount() {
    
  }

  render() {
    const { params } = this.props.navigation.state
    return (
      <Container>
        <Content padder style={{ backgroundColor: colors.white }}>

          <Text>{params.tag.name}</Text>
          <Text>{params.tag.location}</Text>
          <Text>{params.tag.lastSeen}</Text>

        </Content>
      </Container>
    )
  }
}

TagView.navigationOptions = ({ navigation }) => ({
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
        <Title>{navigation.state.params.tag.name}</Title>
      </Body>
      <Right>
        <Button
          transparent
          onPress={() => navigation.navigate('DrawerOpen')}>
          <Icon name="more" ios="ios-more" android="md-more" style={{ color: colors.orange }} />
        </Button>
      </Right>
    </Header>
  )
})
