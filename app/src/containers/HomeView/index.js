import React, { Component } from "react"
import HomeScreen from "./HomeView.js"
import MainScreenNavigator from "../ChatScreen/index.js"
import Profile from "../ProfileScreen"
import SideBar from "../../components/SideBar"
import { DrawerNavigator } from "react-navigation"

const HomeScreenRouter = DrawerNavigator(
  {
    Home: { screen: HomeScreen },
    Chat: { screen: MainScreenNavigator },
    Profile: { screen: Profile }
  },
  {
    drawerPosition: 'left',
    drawerWidth: 275,
    contentComponent: props => <SideBar {...props} />
  }
)

export default HomeScreenRouter
