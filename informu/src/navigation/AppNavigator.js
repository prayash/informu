import React, { Component } from 'react';
import { Navigator, StyleSheet } from 'react-native';

import TagsCollection from '../screens/TagsCollection'
import TagShow from '../screens/TagShow'

export default class AppNavigator extends Component {

  _renderScene(route, navigator) {
    let globalNavigatorProps = { navigator }

    switch(route.id) {
      case 'TagsCollection':
        return <TagsCollection {...globalNavigatorProps} />
      
      case 'TagShow':
        return <TagShow tag={route.tag} {...globalNavigatorProps} />
      
      default:
        return <TagsCollection {...globalNavigatorProps} />
    }
  }

  render() {
    return (
      <Navigator
        initialRoute={this.props.initialRoute}
        ref='appNavigator'
        style={styles.navigatorStyles}
        renderScene={this._renderScene}
        configureScene={(route) => ({
          ...route.sceneConfig || Navigator.SceneConfigs.FloatFromRight
        })} />
    )
  }
}

const styles = StyleSheet.create({
  navigatorStyles: {

  }
})
