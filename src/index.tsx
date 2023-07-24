import * as React from 'react'
import { Button, NativeModules, StyleSheet, View } from 'react-native'

export const addOne = (input: number) => input + 1

export const Counter = () => {
  return (
    <View style={styles.container}>
      <Button
        onPress={() => NativeModules.SnappersModule.launch()}
        title='Launch Snappers'
      />
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    height: 200,
  },
})

export default NativeModules.SnappersModule
