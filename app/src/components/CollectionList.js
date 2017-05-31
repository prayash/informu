import React, { Component } from "react"
import { StyleSheet, View } from 'react-native'
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
} from "native-base"

import { colors, thumbnails } from '../config/theme'

export default class CollectionList extends Component {
  render() {
    const { navigate } = this.props.navigation
    const { tags } = this.props
    return (
      <List>
        <Separator style={{ backgroundColor: colors.white }}>
          <Text>TAGS</Text>
        </Separator>
        {tags.map(t => {
            const borderColor = colors[t.color]
            const thumbnail = thumbnails[t.color]
            return (
              <View key={t.uuid + t.minor} style={[styles.list, { borderTopColor: borderColor }]}>
                <ListItem
                  button
                  onPress={() => navigate('TagView', { tag: t })}
                  style={{ borderBottomWidth: 0 }}>
                  
                  <Thumbnail square size={150} source={thumbnail} />
                  <Body>
                    <Text>{t.name}</Text>
                    <Text note>Location: {t.location}</Text>
                    <Text note>Last seen {t.lastSeen}</Text>
                  </Body>
                  <Icon name="chevron-right" ios="ios-arrow-forward" android="md-arrow-dropright" style={{ color: 'grey', opacity: 0.75 }}/>
                </ListItem>
              </View>
            )}
        )}
      </List>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },

  list: {
    marginTop: 10,
    borderTopColor: '#e0742b',
    borderTopWidth: 3,
    borderBottomColor: '#eee',
    borderBottomWidth: 1
  },

  beaconRow: {
    flexDirection: 'row',
    justifyContent: 'flex-start',
    alignItems: 'center',
    height: 50
  },

  disclosureIndicator: {
    color: 'orange'
  }
});