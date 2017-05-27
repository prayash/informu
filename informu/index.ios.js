import React, { Component } from 'react';
import { AppRegistry, Navigator, StyleSheet, TabBarIOS } from 'react-native';
// import AppNavigator from './src/navigation/AppNavigator'
// import Icon from 'react-native-vector-icons/FontAwesome'
import { Container, Header, Title, Content, Footer, FooterTab, Button, Left, Right, Body, Icon } from 'native-base';

export default class informu extends Component {

  constructor(props) {
    super(props)
    this.state = {
      selectedTab: 'Tab1'
    }
  }

  render() {
    return (
      <Container>
        <Header>
          <Left>
            <Button transparent>
              <Icon name='menu' />
            </Button>
          </Left>

          <Body>
            <Title>Header</Title>
          </Body>

          <Right />
        </Header>

        <Content>
            // Your main content goes here
        </Content>

        <Footer>
          <FooterTab>
            <Button full>
              <Text>Footer</Text>
            </Button>
          </FooterTab>
        </Footer>
      </Container>
    )
  }
}

const styles = StyleSheet.create({ })

AppRegistry.registerComponent('informu', () => informu);