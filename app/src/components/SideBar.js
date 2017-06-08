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

import { colors, sidebarIcons } from '../config/theme'

export default class SideBar extends Component {
  render() {
    const { state, navigate } = this.props.navigation
    const routes = this.props.routes
    console.log(state.index)
    return (
      <Container>
        <Content style={{ backgroundColor: colors.grey }}>
          <View style={{ height: 75, paddingTop: 25, paddingLeft: 15 }}>
            <Text style={{ fontWeight: '600', fontSize: 20, color: colors.light }}>Prayash</Text>
            <Text style={{ fontWeight: '100', color: colors.light }}>prayash.thapa@informu.io</Text>
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
                  button={true}
                  style={{ height: 50 }}
                  onPress={() => navigate(data)}>
                  <Left><Icon name={sidebarIcons[data]} style={{ color: colors.light, fontWeight: '700' }} /></Left>
                  <Body style={{ borderBottomWidth: 0 }}>
                    <Text style={{ fontWeight: '100', color: colors.light }}>{data}</Text>
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
