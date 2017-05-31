import React, { Component } from "react"
import { Container, Content } from "native-base"
import { colors } from '../config/theme'

export default class ViewContainer extends Component {
  render() {
    return (
      <Container>
        <Content padder style={{ backgroundColor: colors.white }}>
        {this.props.children}
        </Content>
      </Container>
    )
  }
}
