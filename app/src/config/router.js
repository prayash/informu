import React from 'react';
import { TabNavigator } from 'react-navigation';
// import { Icon } from 'react-native-elements';

import ProfileScreen from '../containers/ProfileScreen/Profile.js';
import HomeView from '../containers/HomeView/HomeView.js';

export const Tabs = TabNavigator({
  Profile: {
    screen: ProfileScreen
  },

  Home: {
    screen: HomeView
  }
})