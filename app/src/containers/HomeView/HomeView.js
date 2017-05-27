import React, { Component } from "react"
import { AppRegistry, StatusBar, View } from 'react-native'
import {
  Button,
  Text,
  Container,
  Card,
  CardItem,
  Body,
  Content,
  Header,
  Title,
  Left,
  List,
  ListItem,
  Icon,
  Right,
  Separator,
  Thumbnail
} from "native-base"
import CollectionList from '../../components/CollectionList'
import Logger from '../../components/Logger'

export default class HomeView extends Component {
  render() {
    return (
      <Container>
        <Header noShadow={true} style={{ marginTop: 5, backgroundColor: '#ffffff', borderBottomColor: '#cccccc' }}>
          <Left>
            <Button
              transparent
              onPress={() => this.props.navigation.navigate("DrawerOpen")}>
              <Icon name="menu" style={{ color: '#e0742b' }} />
            </Button>
          </Left>
          <Body>
            <Title>Home</Title>
          </Body>
          <Right>
            <Button
              transparent
              onPress={() => this.props.navigation.navigate("DrawerOpen")}>
              <Icon name="add" style={{ color: '#e0742b' }} />
            </Button>
          </Right>
        </Header>
        <Content padder>

          <CollectionList />

          <Logger navigation={this.props.navigation} />

        </Content>
      </Container>
    )
  }
}
