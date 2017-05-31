import React from 'react'
import { DrawerNavigator, StackNavigator, TabNavigator } from 'react-navigation'

import AddTagView from '../containers/AddTagView'
import HomeView from '../containers/HomeView'
import TagView from '../containers/TagView'
import SideBar from '../components/SideBar'

const HomeRoute = StackNavigator({
  HomeView: { screen: HomeView },
  TagView: { screen: TagView },
  AddTagView: { screen: AddTagView }
})

const routes = ['Home', 'Settings', 'Logout']
const Router = DrawerNavigator(
  {
    Home: { screen: HomeRoute },
    Logout: { screen: HomeRoute },
    Settings: { screen: HomeRoute }
  },
  {
    drawerPosition: 'left',
    drawerWidth: 275,
    contentComponent: props => <SideBar {...props} routes={routes} />
  }
)

export default Router