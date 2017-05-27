import React, { Component } from "react"
import { View } from 'react-native'
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

export default class CollectionList extends Component {
  render() {
    return (
      <List>
        <Separator style={{ backgroundColor: "#ffffff" }}>
          <Text>TAGS</Text>
        </Separator>

        <View style={{ marginTop: 10, borderTopColor: '#e0742b', borderTopWidth: 3, borderBottomColor: '#eee', borderBottomWidth: 1 }}>
          <ListItem
            button
            onPress={() => this.props.navigation.navigate(data)}
            style={{ borderBottomWidth: 0 }}>
            <Thumbnail square size={150} source={require('../assets/mu-orange.png')} />
            <Body>
              <Text>Car</Text>
              <Text note>Location: 1111 Engineering Dr</Text>
              <Text note>Last seen 4 hours ago</Text>
            </Body>
          </ListItem>
        </View>

        <View style={{ marginTop: 10, borderTopColor: '#65d8d8', borderTopWidth: 3, borderBottomColor: '#eee', borderBottomWidth: 1 }}>
          <ListItem style={{ borderBottomWidth: 0 }}>
            <Thumbnail square size={150} source={require('../assets/mu-blue.png')} />
            <Body>
              <Text>Laptop</Text>
              <Text note>Location: 1310 College Ave</Text>
              <Text note>Last seen 4 hours ago</Text>
            </Body>
          </ListItem>
        </View>
      </List>
    )
  }
}