import React, { Component } from "react"
import { View } from "react-native"
import { Container, Content, Picker, Button, Text } from "native-base"
import Router from "./src/config/router.js"

export default class App extends Component {
  constructor() {
    super();
    this.state = {
      isReady: false
    }
  }
  
  async componentWillMount() {
    this.setState({ isReady: true })
  }

  render() {
    return <Router />
  }
}