import { StyleSheet, Text, View } from 'react-native';
import Imc from './Components/Imc/Imc';
import Like from './Components/Like/Like';
import React from 'react';
import { LinearGradient } from 'expo-linear-gradient';

export default function App() {
  return (
    <View style={styles.container}>
      <Imc peso={93.0} altura={1.71} />
      <Imc peso={56.0} altura={1.95} />
      <Like nome="JOÃO"/>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
      flex: 1,
      backgroundColor: '#FFFFFF',
      alignItems: 'center',
      justifyContent: 'center',
      paddingHorizontal: 20,
      paddingVertical: 30,
      borderRadius: 20,
      shadowColor: '#000',
      shadowOffset: {
        width: 0,
        height: 2,
      },
      shadowOpacity: 0.25,
      shadowRadius: 5,
      elevation: 5,
  }
});

