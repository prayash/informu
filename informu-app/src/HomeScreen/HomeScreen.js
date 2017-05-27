import React from "react";
import { AppRegistry, StatusBar, View } from 'react-native';
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
} from "native-base";
import { Col, Row, Grid } from 'react-native-easy-grid';

export default class HomeScreen extends React.Component {
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
        <Content padder >
          <List>
            <Separator style={{ backgroundColor: "#ffffff" }}>
              <Text>TAGS</Text>
            </Separator>

            <View style={{ marginTop: 10, borderTopColor: '#e0742b', borderTopWidth: 3, borderBottomColor: '#eee', borderBottomWidth: 1}}>
              <ListItem style={{ borderBottomWidth: 0 }}>
                <Thumbnail square size={150} source={require('./img/mu1.png')} />
                <Body>
                  <Text>Car</Text>
                  <Text note>Location: 1111 Engineering Dr</Text>
                  <Text note>Last seen 4 hours ago</Text>
                </Body>
              </ListItem>
            </View>

            <View style={{ marginTop: 10, borderTopColor: '#65d8d8', borderTopWidth: 3, borderBottomColor: '#eee', borderBottomWidth: 1}}>
              <ListItem style={{ borderBottomWidth: 0 }}>
                <Thumbnail square size={150} source={require('./img/mu2.png')} />
                <Body>
                  <Text>Laptop</Text>
                  <Text note>Location: 1310 College Ave</Text>
                  <Text note>Last seen 4 hours ago</Text>
                </Body>
              </ListItem>
            </View>
          </List>


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

        </Content>
      </Container>
    );
  }
}
