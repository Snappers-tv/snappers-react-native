import React, { useEffect } from 'react'
import SnappersModule, { Counter } from 'snappers-react-native'

const App = () => {
  useEffect(() => {
    console.log(SnappersModule)
  })

  return <Counter />
}

export default App
