import React, { Component } from "react"
import { AppRegistry, Image, StatusBar } from "react-native"
import {
  Body,
  Button,
  Text,
  Container,
  Left,
  List,
  ListItem,
  Content,
  Icon,
  View
} from "native-base"

const routes = ["Home", "Chat", "Profile"]

export default class SideBar extends Component {
  render() {
    return (
      <Container>
        <Content style={{ backgroundColor: '#2d2d2d' }}>
          <View style={{ height: 75, paddingTop: 25, paddingLeft: 15 }}>
            <Text style={{ fontWeight: '600', fontSize: 20, color: '#EBEBEB'}}>Prayash</Text>
            <Text style={{ fontWeight: '100', color: '#EBEBEB'}}>prayash.thapa@informu.io</Text>
          </View>
          {/*<Image
            source={{
              uri: "https://github.com/GeekyAnts/NativeBase-KitchenSink/raw/react-navigation/img/drawer-cover.png"
            }}
            style={{
              height: 120,
              alignSelf: "stretch",
              justifyContent: "center",
              alignItems: "center"
            }}>
            <Image
              square
              style={{ height: 80, width: 70 }}
              source={{
                uri: "https://github.com/GeekyAnts/NativeBase-KitchenSink/raw/react-navigation/img/logo.png"
              }}
            />
          </Image>*/}
          <List
            dataArray={routes}
            renderRow={data => {
              return (
                <ListItem
                  icon
                  button={false}
                  style={{ height: 50 }}
                  onPress={() => this.props.navigation.navigate(data)}>
                  <Left><Icon name="home" style={{ color: '#EBEBEB' }} /></Left>
                  <Body style={{ borderBottomWidth: 0 }}>
                    <Text style={{ fontWeight: '100', color: '#EBEBEB'}}>{data}</Text>
                  </Body>
                </ListItem>
              )
            }}
          />
        </Content>
      </Container>
    )
  }
}
