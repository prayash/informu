import React from 'react'
import { DrawerNavigator, StackNavigator, TabNavigator } from 'react-navigation'

import MainScreenNavigator from '../containers/ChatScreen/index.js'
import ProfileScreen from '../containers/ProfileScreen'
import AddTagView from '../containers/AddTagView/AddTagView.js'
import HomeView from '../containers/HomeView/HomeView.js'
import TagView from '../containers/TagView/TagView.js'
import SideBar from '../components/SideBar'

const HomeRoute = StackNavigator({
  HomeView: { screen: HomeView },
  TagView: { screen: TagView },
  AddTagView: { screen: AddTagView }
})

const routes = ["Home", "Settings", "Logout"]
const Router = DrawerNavigator(
  {
    Home: { screen: HomeRoute },
    Logout: { screen: MainScreenNavigator },
    Settings: { screen: ProfileScreen },
    Tag: { screen: TagView }
  },
  {
    drawerPosition: 'left',
    drawerWidth: 275,
    contentComponent: props => <SideBar {...props} routes={routes} />
  }
)

export default Router