import React, { Component } from 'react';
import { AppRegistry, Navigator, StyleSheet, TabBarIOS } from 'react-native';
import AppNavigator from './src/navigation/AppNavigator'
import Icon from 'react-native-vector-icons/FontAwesome'

export default class informu extends Component {

  constructor(props) {
    super(props)
    this.state = {
      selectedTab: 'Tab1'
    }
  }

  render() {
    return (
      // <AppNavigator initialRoute={{ id: 'TagsCollection' }}/>
      
      <TabBarIOS selectedTab={this.state.selectedTab}>
        
        <Icon.TabBarItemIOS
          selected={this.state.selectedTab === 'Tab1'}
          title='Tags'
          iconName='tags'
          onPress={() => this.setState({ selectedTab: 'Tab1' })}>
          <AppNavigator initialRoute={{ id: 'TagsCollection' }}/>
        </Icon.TabBarItemIOS>
        
        <Icon.TabBarItemIOS
          selected={this.state.selectedTab === 'Tab2'}
          title='Map'
          iconName='map-marker'
          onPress={() => this.setState({ selectedTab: 'Tab2' })}>
          <AppNavigator initialRoute={{ id: 'TagShow', tag: { uuid: 'asdfasdfasd-asdfafsfd'} }}/>
        </Icon.TabBarItemIOS>

        <Icon.TabBarItemIOS
          selected={this.state.selectedTab === 'Tab3'}
          title='Settings'
          iconName='gear'
          onPress={() => this.setState({ selectedTab: 'Tab3' })}>
          <AppNavigator initialRoute={{ id: 'TagShow', tag: { uuid: 'SettingsPage'} }}/>
        </Icon.TabBarItemIOS>

      </TabBarIOS>
    )
  }
}

const styles = StyleSheet.create({ })

AppRegistry.registerComponent('informu', () => informu);
